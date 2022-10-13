function Model = Hymod10par_old(Data,Pars)

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
TR   = Pars(:,7); %Base temperature below which rain occurs
TS   = Pars(:,8); %Base temperature below which snow occurs
TM   = Pars(:,9); %Base temperature above which melt occurs
SCF  = Pars(:,10); %Snow correction factor

%Initial States
InState.Xq(1,1:Nq) = 0;
%InState.Xq(1,1:10) = 0; %Do this if varying Nq (number of quick flow reservoirs)
InState.Xs(1) = 0;
InState.XHuz(1) = 0;
InState.SN(1) = 0;

XHuz = InState.XHuz;
Xq   = InState.Xq;
Xs   = InState.Xs;
Xw   = InState.SN;

for i = 1:length(Period);
    Day = Period(i)-min(Period)+1;
    
    % Partition precipitation
    if AT(Day) > TR;
        Pr(i) = Precip(Day);
        Ps(i) = 0;
    elseif AT(Day)< TR;
        Pr(i) = 0;
        Ps(i) = Precip(Day);
    else
        Pr(i) = Precip(Day)*((AT(Day)-TS)/(TR-TS));
        Ps(i) = Precip(Day) - Pr(i);
    end;
    
    % Accounting for sublimation
    XSub(i) = Ps(i).*SCF;
    Ps(i) = Ps(i) - Ps(i)*SCF;

    % Compute snowmelt (mm/day)
    if Xw(i)>0 && AT(Day) > TM;
        
        M(i) = (AT(Day)-TM)*DDF;
        
        % Check that there is enough SWE to melt
        if M(i) < Xw(i);
            % Melt stays the same
        elseif M(i) > Xw(i);
            M(i) = Xw(i);
        end;
    else
        M(i) = 0;
    end;
    
    % Precipitation into soil
    Pin(i) = Pr(i)+M(i);
    
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
        Xw(i+1)   = Xw(i)+(Ps(i)-M(i));
    end
end 

%Assign to model output
Model.XSub = XSub;   % Sublimation
Model.XHuz = XHuz;   % Model computed upper zone soil moisture tank state contents
Model.XCuz = XCuz;   % Model computed upper zone soil moisture tank state contents
Model.Xq   = Xq;     % Model computed quickflow tank states contents
Model.Xs   = Xs;     % Model computed slowflow tank state contents
Model.ET   = ET;     % Model computed evapotranspiration flux
Model.OV   = OV;     % Model computed precipitation excess flux
Model.Qq   = Qq;     % Model computed quickflow flux
Model.Qs   = Qs;     % Model computed slowflow flux
Model.Q   = Qq + Qs; % Model computed total streamflow flux
Model.M = M;
    
