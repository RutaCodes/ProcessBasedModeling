%Ruta Basijokaite

function Model = Hymod10par_new_RB(Data,Pars)

%Observation data
Period = Data.Calib.Period; %Study period
Precip = Data.Calib.Precip; %Daily precipitation
Evap   = Data.Calib.Evap; %Potential evapotranspiration
AT     = Data.Calib.AT; %Average daily temperature

%Parameters
Nq   = 3; %Number of quick flow routing tanks
Kq   = Pars(:,1); %Quick flow reservoir rate constant
Ks   = Pars(:,2); %Slow flow reservoir rate constant
Alp  = Pars(:,3); %Division between quick/slow routing
Hpar = Pars(:,4); %Maximum soil moisture storage 
Bpar = Pars(:,5); %Distribution of soil storage function shape
DDF  = Pars(:,6); %Degree day factor (snow melt rate)
TT   = Pars(:,7); %Temperature threshold - base temperature below which snow forms
Kf   = Pars(:,8); %Degree day factor for refreezing
TM   = Pars(:,9); %Base temperature above which melt forms 
r    = Pars(:,10); %Water retention coefficient  

%Initial States
InState.Xq(1,1:Nq) = 0;
%InState.Xq(1,1:10) = 0; %Do this if varying Nq (number of quick flow reservoirs)
InState.Xs(1) = 0;
InState.XHuz(1) = 0;
InState.SNl(1) = 0;
InState.SNi(1) = 0;
InState.Lmax(1)=0; %maximum amount of liquid water in the snowpack

% Setting the initial value for each state
XHuz = InState.XHuz;
Xq   = InState.Xq;
Xs   = InState.Xs; 
Xwl   = InState.SNl; % Liquid water in the snowpack
Xwi   = InState.SNi; % Ice in the snowpack

%Intermediate calculations for ice and liquid snowpack state
Xwl_intra   = 0;
Xwi_intra   = 0;

for i = 1:length(Period)
    
    Day = Period(i)-min(Period)+1;
    
    % Partition precipitation
    if AT(Day) >= TT %if AT is higher than TT, all precipitation is rain
        Pr(i) = Precip(Day);
        Ps(i) = 0;
    else AT(Day) < TT; %if AT is lower than TT, all precip is snow
        Pr(i) = 0;
        Ps(i) = Precip(Day);
    end
    
    % Compute snowmelt (mm/day)
    if Xwi(i)>0 && AT(Day) > TM
        M(i) = (AT(Day)-TM)*DDF;
        % Check that there is enough SWE to melt
        if M(i) < Xwi(i)
            % Melt stays the same
        elseif M(i) > Xwi(i)
            M(i) = Xwi(i);
        end
    else
        M(i) = 0;
    end
    
    % Compute water retention capacity
    Lmax(i)=r*(Xwi(i));
    
    %Compute refreezing (mm/day)
    if Lmax(i) > 0 && AT(Day) < TM
        FR(i)=Kf*(TM-AT(Day));
        
        %Check if there is streamflow to refreeze
        if FR(i)>Lmax(i)
            FR(i)=Lmax(i);
        end
    else 
        FR(i)=0;
    end
    
    %Computing snowpack in ice
    if (Ps(i) + FR(i)) > M(i)
        Xwi_intra(i)= Ps(i) + FR(i) - M(i);
    else 
        Xwi_intra(i)=0; %if melt rate is higher than refreezing and snow accumulation that day, no new ice is added to snowpack
    end
    
    %Computing snowpack as liquid water
    if (Xwi(i) + Xwl(i)) > 0 %if there is snowpack
        if (Pr(i) + M(i)) > FR(i)
            Xwl_intra(i) = Pr(i) + M(i) - FR(i);
            if (Xwl(i) + Xwl_intra(i)) > Lmax(i)
                Pin(i) = Xwl(i) + Xwl_intra(i) - Lmax(i);%excess goes into soil
                %Xwl_intra(i)= Lmax(i);%maximum amount of liquid water is kept in the snowpack
                %Xw1(i)=Lmax(i); % at the enf of the day total liquid water is equal to Lmax
            else 
                Pin(i)=0;
            end
        else
            Xwl_intra(i)=0;%if refreezing rate is faster than rainfall and melt, no new liquid water is added to snowpack
            Pin(i)=0;
        end
    else %if there is no snowpack
        Pin(i)=Pr(i);
        Xwl_intra(i)=0;
    end
    
    if M(i) > 0
        Xwi(i) = Xwi(i)-M(i); %substracting melt from existing snowpack
    end
    
    %Computing snowpack in ice and liquid water state for next timestep
    Xwi(i+1) = Xwi(i)+ Xwi_intra(i);
    if(Xwl(i) + Xwl_intra(i)) > Lmax(i)
        Xwl(i+1)=Lmax(i); 
    else
        Xwl(i+1) = Xwl(i)+ Xwl_intra(i);
    end
    
    % Run soil moisture accouting including evapotranspiration
    [OV(i),ET(i),XHuz(i),XCuz(i)] = Pdm01(Hpar,Bpar,XHuz(i),Pin(Day),Evap(Day));
    
    % Run Nash Cascade routing of quickflow componant
    [Qq(i),Xq(i,1:Nq)] = Nash(Kq,Nq,Xq(i,1:Nq),Alp*OV(i));
    
    % Run slow flow component, one infinite linear tank
    [Qs(i),Xs(i)] = Nash(Ks,1,Xs(i),(1-Alp)*OV(i));
    
    if i<length(Period)
        XHuz(i+1) = XHuz(i);
        Xq(i+1,:) = Xq(i,:);
        Xs(i+1)   = Xs(i);
    end
end 

%Assign to model output
Model.XHuz = XHuz;   % Model computed upper zone soil moisture tank state contents
Model.XCuz = XCuz;   % Model computed upper zone soil moisture tank state contents
Model.Xq   = Xq;     % Model computed quickflow tank states contents
Model.Xs   = Xs;     % Model computed slowflow tank state contents
Model.ET   = ET;     % Model computed evapotranspiration flux
Model.OV   = OV;     % Model computed precipitation excess flux
Model.Qq   = Qq;     % Model computed quickflow flux
Model.Qs   = Qs;     % Model computed slowflow flux
Model.Q    = Qq + Qs; % Model computed total streamflow flux
Model.M    = M;      % Model computed snow melt
Model.FR   = FR;     % Model computed refreezing
Model.PIN  = Pin;    % Water into soil
Model.Xwi  = Xwi;    %Snowpack as ice
Model.Xwl  = Xwl;    %Snowpack as liquid
