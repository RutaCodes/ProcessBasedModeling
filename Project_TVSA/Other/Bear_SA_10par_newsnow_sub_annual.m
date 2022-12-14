%Ruta Basijokaite

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DATA STRUCTURE
%   Data.Period = Period of observation data (1:length of observations)
%   Data.Precip = Precipitation flux (mm/day)
%   Data.Evap = Potential Evapo-Transpiration flux (mm/day)
%   Data.Flow = Streamflow flux (mm/day)
% PARAMETER STRUCTURE
%   Pars.Huz = Max height of soil moisture accounting tank - Range [0, 500]
%   Pars.B   = Distribution function shape parameter       - Range [0, 2]
%   Pars.Alp = Quick-slow split parameter                  - Range [0, 1];
%   Pars.Nq  = Number of quickflow routing tanks           - Range [1, 10]
%   Pars.Kq  = Quickflow routing tanks rate parameter      - Range [0.1, 1]
%   Pars.Ks  = Slowflow routing tanks rate parameter       - Range [0, 0.1]
% Initialize state variables
%   InState.XCuz = Soil moisture accounting tank state contents - Dim(1 x 1)
%   InState.Xq   = Quickflow routing tanks state contents - Dim(1 x Pars.nq)
%   InState.Xs   = Slowflow routing tank state contents - Dim (1 x 1)
% MODEL STRUCTURE (The output uses a structure array, in which different
% matrixes/vectores are stored under one 'header', i.e. 'Model')
%   Model.XHuz = Model computed upper zone soil moisture tank state contents
%   Model.XCuz = Model computed upper zone soil moisture tank state contents
%   Model.Xq   = Model computed quickflow tank states contents
%   Model.Xs   = Model computed slowflow tank state contents
%   Model.ET   = Model computed evapotranspiration flux
%   Model.OV   = Model computed precipitation excess flux
%   Model.Qq   = Model computed quickflow flux
%   Model.Qs   = Model computed slowflow flux
%   Model.Q    = Model computed total streamflow flux
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; 
global Data

my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

% Latitude and WS size
lat = 37.33939; % latitude at outlet
W_size = 142.19; % basin size in km2

% Load the data files
load Data_Bear_Lake.mat; %nldas data
dataset = Data_Bear_Lake(1:12692,:);
load Data_Qflow_Bear_Lake.mat; %streamflow
Streamflow = ((Data_Qflow_Bear_Lake(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day      
save bear_Streamflow.mat Streamflow                                           
                                           
%Observation data
Data.Calib.Flow     = Streamflow;
Data.Calib.Period   = (1:length(dataset));
year = dataset(:,1);
month = dataset(:,2);
day = dataset(:,3);

%Using nldas
precip=dataset(:,6);
tempaver=(dataset(:,9)+ dataset(:,10))/2;

%Met data
Data.Calib.Precip = precip;%from inches to mm
Data.Calib.AT = tempaver;

% % Calculate potential evapotranspiration (mm/day)
% Julian Date
[JD] = juliandate(year);
% Oudin ET
PE_value = oudinET(JD,Data.Calib.AT,lat);%m/day
Data.Calib.Evap = PE_value*1000;

% Define input distribution and ranges:
M  = 10 ; % number of uncertain parameters 
DistrFun  = 'unif'  ; % Parameter distribution

%New snow routine 
DistrPar  = {  [ 0.1 0.8 ]; [ 0 0.2 ]; [ 0 0.8 ]; [ 5 500 ]; [ 0 2 ]; [ 1 8 ]; [ -3, 3 ]; [ 0, 1]; [-2 2]; [0, 0.8] } ;

% Sample parameter space using the resampling strategy proposed by 
% (Saltelli, 2008; for reference and more details, see help of functions
% vbsa_resampling and vbsa_indices) 
SampStrategy = 'lhs' ;
N = 5000; % Base sample size.
% Comment: the base sample size N is not the actual number of input 
% samples that will be evaluated. In fact, because of the resampling
% strategy, the total number of model evaluations to compute the two
% variance-based indices is equal to N*(M+2) 
X = AAT_sampling(SampStrategy,M,DistrFun,DistrPar,2*N);
[ XA, XB, XC ] = vbsa_resampling(X) ;
XALL = vertcat(XA,XB,XC);
Pars.Nq = 3;     %Number of quickflow routing tanks

qsyr_all=zeros(60000,366,33); 
qoyr_all=zeros(33,366);

for a=1:size(XALL,1) % for loop to cycle through random sampling parameter sets
    
    % Run model once
    Model = Hymod10par_new_RB(Data,XALL(a,:));%new snow routine
    %Model = Hymod10par_old(Data,XALL(a,:));%old snow routine
    
    % Specify sim & obs - need to be same size
    qobs = Data.Calib.Flow;
    qsim = Model.Q;
    %c = 0;% mo_cnt=0;
    cnt1=0;
    cnt2=0;
    da = 0;
    qs(a,:) = qsim;

    NSE_whole(a,1)= 1 - (sum((qobs-qsim').^2)/(sum((qobs - mean(qobs)).^2)));
    KGE_whole(a,1)= kge(qsim',qobs);
    
    for j=2011:2013%1981:2013
        [x, xx]=find(year==j & month == 10 & day == 1);
        [y, yy]=find(year==(j+1) & month == 9 & day == 30);
        
        da = da+1;
%         cnt1=0;
%         cnt2=0;
        qoyr = Data.Calib.Flow(x:y);
        qsyr = Model.Q(x:y);
        qsyr_all(a,1:length(qoyr),da) = qsyr';
        
        NSEyear(a,da) = 1 - (sum((qoyr-qsyr').^2)/(sum((qoyr - mean(qoyr)).^2)));
        WByear(a,da) = sum(abs(qoyr-qsyr'))/sum(qoyr);
        KGEyear(a,da) = kge(qsyr',qoyr);
        RREyear(a,da) = 100*[(sum(qsim)/sum(Data.Calib.Precip)) - (sum(qobs)/sum(Data.Calib.Precip))]./(sum(qobs)/sum(Data.Calib.Precip));
        
        %Hydrologic signatures
        qoyr_down_loop=sort(qoyr,'descend');
        qsyr_down_loop=sort(qsyr,'descend');
        qfdcobs_loop = prctile(qoyr_down_loop,(1:100));
        qfdcsim_loop = prctile(qsyr_down_loop,(1:100));
        qfdcobs_loop_EP=sort(qfdcobs_loop,'descend');
        qfdcsim_loop_EP=sort(qfdcsim_loop,'descend');
        
        SFDC_low_obs_yr_loop=((qfdcobs_loop_EP(90))-(qfdcobs_loop_EP(70)))/(90-70);
        SFDC_low_sim_yr_loop=((qfdcsim_loop_EP(90))-(qfdcsim_loop_EP(70)))/(90-70);
        SFDC_mid_obs_yr_loop=((qfdcobs_loop_EP(60))-(qfdcobs_loop_EP(30)))/(60-30);
        SFDC_mid_sim_yr_loop=((qfdcsim_loop_EP(60))-(qfdcsim_loop_EP(30)))/(60-30);
        SFDC_high_obs_yr_loop=((qfdcobs_loop_EP(10))-(qfdcobs_loop_EP(5)))/(10-5);
        SFDC_high_sim_yr_loop=((qfdcsim_loop_EP(10))-(qfdcsim_loop_EP(5)))/(10-5);
        
        SFDCE.high_yr_loop(a,da)=SFDC_high_obs_yr_loop-SFDC_high_sim_yr_loop;
        SFDCE.mid_yr_loop(a,da)=SFDC_mid_obs_yr_loop-SFDC_mid_sim_yr_loop;
        SFDCE.low_yr_loop(a,da)=SFDC_low_obs_yr_loop-SFDC_low_sim_yr_loop;
        
        SFDCEP.high_yr_loop(a,da)=100*(SFDC_high_obs_yr_loop-SFDC_high_sim_yr_loop)./SFDC_high_obs_yr_loop;
        SFDCEP.mid_yr_loop(a,da)=100*(SFDC_mid_obs_yr_loop-SFDC_mid_sim_yr_loop)./SFDC_mid_obs_yr_loop;
        SFDCEP.low_yr_loop(a,da)=100*(SFDC_low_obs_yr_loop-SFDC_low_sim_yr_loop)./SFDC_low_obs_yr_loop;
        
        %sub_annual  scale for last 10 years
        if j>2011%j>2003
            %monthly running window
            yr_l=length(qoyr);
            for k=1:(yr_l-30)
                qob_mo = qoyr(k:(k+30));
                qsim_mo = qsyr(k:(k+30));
                cnt1=cnt1+1;
                RSME_mo(a,cnt1)=sqrt(1/31*sum((qob_mo-qsim_mo').^2));%high flows
                TE_mo(a,cnt1)=sum(abs(log(qsim_mo)-log(qob_mo')));%low flows
            end
            %weekly running window
            for s=1:(yr_l-6)
                qob_we = qoyr(s:(s+6));
                qsim_we = qsyr(s:(s+6));
                cnt2=cnt2+1;
                RSME_we(a,cnt2)=sqrt(1/31*sum((qob_we-qsim_we').^2));%high flows
                TE_we(a,cnt2)=sum(abs(log(qsim_we)-log(qob_we')));%low flows
            end
        end
    end

end

[NSEtop_val,NSEtop_index]=sort(NSE_whole,'descend'); %a values, b index
[KGEtop_val,KGEtop_index]=sort(KGE_whole,'descend');
Best_KGE_run=qs(KGEtop_index(1),:);
Best_NSE_run=qs(NSEtop_index(1),:);

AT = Data.Calib.AT;
P = Data.Calib.Precip;

%looking for best KGE value run
KGE_sorted_val=zeros(length(KGEyear),da);
KGE_sorted_ind=zeros(length(KGEyear),da);
for i=1:size(KGEyear,2)
[a1,b1]=sort(KGEyear(:,i),'descend'); %a values, b index
KGE_sorted_val(:,i)=a1;
KGE_sorted_ind(:,i)=b1;
end
%recording best yearly qsim runs
qsim_best=zeros(da,366);
for i=1:da %qsyr_all(da,:,a)
    qsim_best(i,:)=qsyr_all(KGE_sorted_ind(1,i),:,i);
end
% sorting q values
qoyr_down=zeros(da,366); obs_ind=zeros(da,366); 
qsyr_down=zeros(da,366); sim_ind=zeros(da,366);
for i=1:da
    [qoyr_down(i,:),obs_ind(i,:)]=sort(qoyr_all(i,:),'descend');
    [qsyr_down(i,:),sim_ind(i,:)]=sort(qsim_best(i,:),'descend');
end
% calculating EP
for i=1:length(qsyr_down)
    for j=1:da
        EP_obs_yr(j,i)=100*(i/(length(qoyr_down)+1));
        EP_sim_yr(j,i)=100*(i/(length(qsyr_down)+1));
    end
end

%Hydrologic signatures (whole)
for i=1:da
    qfdcobs( i,:) = prctile(qoyr_down(i,:),(1:100));
    qfdcobs_EP(i,:)=sort(qfdcobs(i,:),'descend');
    qfdcsim( i,:) = prctile(qsyr_down(i,:),(1:100));
    qfdcsim_EP(i,:)=sort(qfdcsim(i,:),'descend');
    
    SFDC_low_obs_yr(i,1)=((qfdcobs_EP(i,90))-(qfdcobs_EP(i,70)))/(90-70);
    SFDC_low_sim_yr(i,1)=((qfdcsim_EP(i,90))-(qfdcsim_EP(i,70)))/(90-70);
    SFDC_mid_obs_yr(i,1)=((qfdcobs_EP(i,60))-(qfdcobs_EP(i,30)))/(60-30);
    SFDC_mid_sim_yr(i,1)=((qfdcsim_EP(i,60))-(qfdcsim_EP(i,30)))/(60-30);
    SFDC_high_obs_yr(i,1)=((qfdcobs_EP(i,10))-(qfdcobs_EP(i,5)))/(10-5);
    SFDC_high_sim_yr(i,1)=((qfdcsim_EP(i,10))-(qfdcsim_EP(i,5)))/(10-5);
    
    SFDCE_high_yr(i,1)=SFDC_high_obs_yr(i,1)-SFDC_high_sim_yr(i,1);
    SFDCE_mid_yr(i,1)=SFDC_mid_obs_yr(i,1)-SFDC_mid_sim_yr(i,1);
    SFDCE_low_yr(i,1)=SFDC_low_obs_yr(i,1)-SFDC_low_sim_yr(i,1);
    
    SFDCEP_high_yr(i,1)=SFDC_high_obs_yr(i,1)-SFDC_high_sim_yr(i,1);
    SFDCEP_mid_yr(i,1)=SFDC_mid_obs_yr(i,1)-SFDC_mid_sim_yr(i,1);
    SFDCEP_low_yr(i,1)=SFDC_low_obs_yr(i,1)-SFDC_low_sim_yr(i,1);
end

save bear_lake_sub_hymod_5000hyd_q_EP_snow_test1s.mat EP_obs_yr qoyr_down EP_sim_yr qsyr_down
save bear_lake_sub_hymod_5000hyd_ofs_best_snow_test1s.mat SFDCE_high_yr SFDCE_mid_yr SFDCE_low_yr SFDCEP_high_yr SFDCEP_mid_yr SFDCEP_low_yr %SFDCE_high_whole SFDCE_mid_whole SFDCE_low_whole %EP_obs EP_obs_yr EP_sim_yr EP_sim
save bear_lake_sub_hymod_5000hyd_ofs_loop_snow_test1s.mat SFDCE SFDCEP %SFDCE.high_yr_loop SFDCE.mid_yr_loop SFDCE.low_yr_loop SFDCEP.high_yr_loop SFDCEP.mid_yr_loop SFDCEP.low_yr_loop
save bear_lake_sub_hymod_5000hyd_objFun_snow_test1s.mat NSEyear KGEyear WByear RREyear NSE_whole KGE_whole
save bear_lake_sub_SA_5000sim_val_snow_test1s.mat NSEtop_val NSEtop_index KGEtop_val KGEtop_index Best_KGE_run Best_NSE_run
save bear_lake_sub_SA_5000sim_snow_test1s.mat PE_value %data length by 1
save bear_lake_sub_SA_5000pars_snow_test1s.mat XALL %N by par  nr

% Compute main (first-order) and total effects:
for c=1:size(NSEyear,2)
    i1 = 1:size(XA,1);
    i2 = (size(XA,1)+1):2*size(XA,1);
    i3 = (2*size(XA,1)+1):size(XALL);
  [ WByearSi(c,:), WByearSTi(c,:) ] = vbsa_indices(WByear(i1,c),WByear(i2,c),WByear(i3,c)); %Si first order STi total order
  [ NSEyearSi(c,:), NSEyearSTi(c,:) ] = vbsa_indices(NSEyear(i1,c),NSEyear(i2,c),NSEyear(i3,c));
  [ KGEyearSi(c,:), KGEyearSTi(c,:) ] = vbsa_indices(KGEyear(i1,c),KGEyear(i2,c),KGEyear(i3,c)); 
  %[ MyearSi(c,:), MyearSTi(c,:) ] = vbsa_indices(Myear(i1,c),Myear(i2,c),Myear(i3,c));
  [ RREyearSi(c,:), RREyearSTi(c,:) ] = vbsa_indices(RREyear(i1,c),RREyear(i2,c),RREyear(i3,c));
  [ SFDCE_high_yearSi(c,:), SFDCE_high_yearSTi(c,:) ] = vbsa_indices(SFDCE.high_yr_loop(i1,c),SFDCE.high_yr_loop(i2,c),SFDCE.high_yr_loop(i3,c));
  [ SFDCE_mid_yearSi(c,:), SFDCE_mid_yearSTi(c,:) ] = vbsa_indices(SFDCE.mid_yr_loop(i1,c),SFDCE.mid_yr_loop(i2,c),SFDCE.mid_yr_loop(i3,c));
  [ SFDCE_low_yearSi(c,:), SFDCE_low_yearSTi(c,:) ] = vbsa_indices(SFDCE.low_yr_loop(i1,c),SFDCE.low_yr_loop(i2,c),SFDCE.low_yr_loop(i3,c));
end

save bear_lake_sub_sens_yr_run5000_snow_test1s.mat WByearSi WByearSTi NSEyearSi NSEyearSTi KGEyearSi KGEyearSTi RREyearSi RREyearSTi %MyearSi MyearSTi %year nr by par nr
save bear_lake_sub_sens_yr_hyd_SFDCE_run5000_snow_test1s.mat SFDCE_high_yearSi SFDCE_high_yearSTi SFDCE_mid_yearSi SFDCE_mid_yearSTi SFDCE_low_yearSi SFDCE_low_yearSTi

for c=1:size(RSME_mo,2)
    i1 = 1:size(XA,1);
    i2 = (size(XA,1)+1):2*size(XA,1);
    i3 = (2*size(XA,1)+1):size(XALL);
  [ RSME_moSi(c,:),RSME_moSTi(c,:) ] = vbsa_indices(RSME_mo(i1,c),RSME_mo(i2,c),RSME_mo(i3,c)); 
  [ TE_moSi(c,:), TE_moSTi(c,:) ] = vbsa_indices(TE_mo(i1,c),TE_mo(i2,c),TE_mo(i3,c));
end
for c=1:size(RSME_we,2)
    i1 = 1:size(XA,1);
    i2 = (size(XA,1)+1):2*size(XA,1);
    i3 = (2*size(XA,1)+1):size(XALL);
  [ RSME_weSi(c,:), RSME_weSTi(c,:) ] = vbsa_indices(RSME_we(i1,c),RSME_we(i2,c),RSME_we(i3,c)); 
  [ TE_weSi(c,:), TE_weSTi(c,:) ] = vbsa_indices(TE_we(i1,c),TE_we(i2,c),TE_we(i3,c));
end

save bear_lake_sub_sens_mo_run5000_snow_test1s.mat RSME_moSi RSME_moSTi TE_moSi TE_moSTi RSME_weSi RSME_weSTi TE_weSi TE_weSTi %MyearSi MyearSTi %year nr by par nr

Monthly_RMSE_STi=RSME_moSTi(1:30:end,:);
Weekly_RMSE_STi=RSME_weSTi(1:7:end,:);
Monthly_TE_STi=TE_moSTi(1:30:end,:);
Weekly_TE_STi=TE_weSTi(1:7:end,:);
