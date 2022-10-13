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
Data.Calib.Flow = Streamflow;
Data.Calib.Period = (1:length(dataset));
year = dataset(:,1);
month = dataset(:,2);
day = dataset(:,3);

%Using nldas
precip = dataset(:,6);
tempaver = (dataset(:,9)+ dataset(:,10))/2;

%Met data
Data.Calib.Precip = precip; %from inches to mm
Data.Calib.AT = tempaver;

% % Calculate potential evapotranspiration (mm/day)
% Julian Date
[JD] = juliandate(year);
% Oudin ET
PE_value = oudinET(JD,Data.Calib.AT,lat); %m/day
Data.Calib.Evap = PE_value*1000;

% Define input distribution and ranges:
M  = 10 ; % number of uncertain parameters 
DistrFun  = 'unif'  ; % Parameter distribution

%New snow routine 
DistrPar  = {  [ 0.1 0.8 ]; [ 0 0.2 ]; [ 0 0.8 ]; [ 5 500 ]; [ 0 2 ]; [ 1 8 ]; [ -3, 3 ]; [ 0, 1]; [-2 2]; [0, 0.8] } ;

% Sample parameter space using the resampling strategy proposed by (Saltelli, 2008; for reference and more details, see help of functions
% vbsa_resampling and vbsa_indices) 
SampStrategy = 'lhs' ;
N = 5000; % Base sample size.
% Comment: the base sample size N is not the actual number of input samples that will be evaluated. In fact, because of the resampling
% strategy, the total number of model evaluations to compute the two variance-based indices is equal to N*(M+2) 
X = AAT_sampling(SampStrategy,M,DistrFun,DistrPar,2*N);
[ XA, XB, XC ] = vbsa_resampling(X);
XALL = vertcat(XA,XB,XC);
Pars.Nq = 3; %Number of quickflow routing tanks

qsyr_all = zeros(60000,366,33); 
qoyr_all = zeros(33,366);
NSEmo = zeros(60000,396);
WBmo = zeros(60000,396);
KGEmo = zeros(60000,396);
RREmo = zeros(60000,396);
months = [10 11 12 1 2 3 4 5 6 7 8 9];
mo_cnt = 0;

for a=1:size(XALL,1) % for loop to cycle through random sampling parameter sets
    
    % Run model once
    Model = Hymod10par_new_RB(Data,XALL(a,:));%new snow routine
    %Model = Hymod10par_old(Data,XALL(a,:));%old snow routine
    
    % Specify sim & obs - need to be same size
    qobs = Data.Calib.Flow;
    qsim = Model.Q;
    c = 0; 
    mo_cnt = 0;
    da = 0;
    qs(a,:) = qsim;

    NSE_whole(a,1) = 1 - (sum((qobs-qsim').^2)/(sum((qobs - mean(qobs)).^2)));
    KGE_whole(a,1) = kge(qsim',qobs);
    
    for j=1981:2013
        [x, xx] = find(year==j & month == 10 & day == 1);
        [y, yy] = find(year==(j+1) & month == 9 & day == 30);
        
        da = da+1;
        qoyr = Data.Calib.Flow(x:y);
        qsyr = Model.Q(x:y);
        qsyr_all(a,1:length(qoyr),da) = qsyr';
        
        NSEyear(a,da) = 1 - (sum((qoyr-qsyr').^2)/(sum((qoyr - mean(qoyr)).^2)));
        WByear(a,da) = sum(abs(qoyr-qsyr'))/sum(qoyr);
        KGEyear(a,da) = kge(qsyr',qoyr);
        RREyear(a,da) = 100*[(sum(qsim)/sum(Data.Calib.Precip)) - (sum(qobs)/sum(Data.Calib.Precip))]./(sum(qobs)/sum(Data.Calib.Precip));
        
        %Hydrologic signatures
        qoyr_down_loop = sort(qoyr,'descend');
        qsyr_down_loop = sort(qsyr,'descend');
        qfdcobs_loop = prctile(qoyr_down_loop,(1:100));
        qfdcsim_loop = prctile(qsyr_down_loop,(1:100));
        qfdcobs_loop_EP = sort(qfdcobs_loop,'descend');
        qfdcsim_loop_EP = sort(qfdcsim_loop,'descend');
        
        SFDC_low_obs_yr_loop = ((qfdcobs_loop_EP(90))-(qfdcobs_loop_EP(70)))/(90-70);
        SFDC_low_sim_yr_loop = ((qfdcsim_loop_EP(90))-(qfdcsim_loop_EP(70)))/(90-70);
        SFDC_mid_obs_yr_loop = ((qfdcobs_loop_EP(60))-(qfdcobs_loop_EP(30)))/(60-30);
        SFDC_mid_sim_yr_loop = ((qfdcsim_loop_EP(60))-(qfdcsim_loop_EP(30)))/(60-30);
        SFDC_high_obs_yr_loop = ((qfdcobs_loop_EP(10))-(qfdcobs_loop_EP(5)))/(10-5);
        SFDC_high_sim_yr_loop = ((qfdcsim_loop_EP(10))-(qfdcsim_loop_EP(5)))/(10-5);
        
        SFDCE.high_yr_loop(a,da) = SFDC_high_obs_yr_loop-SFDC_high_sim_yr_loop;
        SFDCE.mid_yr_loop(a,da) = SFDC_mid_obs_yr_loop-SFDC_mid_sim_yr_loop;
        SFDCE.low_yr_loop(a,da) = SFDC_low_obs_yr_loop-SFDC_low_sim_yr_loop;
        
        SFDCEP.high_yr_loop(a,da) = 100*(SFDC_high_obs_yr_loop-SFDC_high_sim_yr_loop)./SFDC_high_obs_yr_loop;
        SFDCEP.mid_yr_loop(a,da) = 100*(SFDC_mid_obs_yr_loop-SFDC_mid_sim_yr_loop)./SFDC_mid_obs_yr_loop;
        SFDCEP.low_yr_loop(a,da) = 100*(SFDC_low_obs_yr_loop-SFDC_low_sim_yr_loop)./SFDC_low_obs_yr_loop;
        
        %monthly loop
        for k = 1:12
            clear mo_nr qob_mo qsim_mo qob_mo_down_loop qsim_mo_down_loop qfdcobs_mo_loop qfdcsim_mo_loop qfdcobs_mo_loop_EP qfdcsim_mo_loop_EP
            clear SFDC_low_obs_mo_loop SFDC_low_sim_mo_loop SFDC_mid_obs_mo_loop SFDC_mid_sim_mo_loop SFDC_high_obs_mo_loop SFDC_high_sim_mo_loop
            [mo_nr, ~] = find(year==j & month == months(k));
            
            qob_mo = Data.Calib.Flow(mo_nr);
            qsim_mo = Model.Q(mo_nr);
            mo_cnt = mo_cnt+1;
            
            NSEmo(a,mo_cnt) = 1 - (sum((qob_mo-qsim_mo').^2)/(sum((qob_mo - mean(qob_mo)).^2)));
            WBmo(a,mo_cnt) = sum(abs(qob_mo-qsim_mo'))/sum(qob_mo);
            KGEmo(a,mo_cnt) = kge(qsim_mo',qob_mo);
            RREmo(a,mo_cnt) = 100*[(sum(qsim_mo)/sum(Data.Calib.Precip)) - (sum(qob_mo)/sum(Data.Calib.Precip))]./(sum(qob_mo)/sum(Data.Calib.Precip));
            
            %Hydrologic signatures monthly
            qob_mo_down_loop = sort(qob_mo,'descend');
            qsim_mo_down_loop = sort(qsim_mo,'descend');
            qfdcobs_mo_loop = prctile(qob_mo_down_loop,(1:100));
            qfdcsim_mo_loop = prctile(qsim_mo_down_loop,(1:100));
            qfdcobs_mo_loop_EP = sort(qfdcobs_mo_loop,'descend');
            qfdcsim_mo_loop_EP = sort(qfdcsim_mo_loop,'descend');
            
            SFDC_low_obs_mo_loop = ((qfdcobs_mo_loop_EP(90))-(qfdcobs_mo_loop_EP(70)))/(90-70);
            SFDC_low_sim_mo_loop = ((qfdcsim_mo_loop_EP(90))-(qfdcsim_mo_loop_EP(70)))/(90-70);
            SFDC_mid_obs_mo_loop = ((qfdcobs_mo_loop_EP(60))-(qfdcobs_mo_loop_EP(30)))/(60-30);
            SFDC_mid_sim_mo_loop = ((qfdcsim_mo_loop_EP(60))-(qfdcsim_mo_loop_EP(30)))/(60-30);
            SFDC_high_obs_mo_loop = ((qfdcobs_mo_loop_EP(10))-(qfdcobs_mo_loop_EP(5)))/(10-5);
            SFDC_high_sim_mo_loop = ((qfdcsim_mo_loop_EP(10))-(qfdcsim_mo_loop_EP(5)))/(10-5);
            
            SFDCEmo.high_mo_loop(a,mo_cnt) = SFDC_high_obs_mo_loop-SFDC_high_sim_mo_loop;
            SFDCEmo.mid_mo_loop(a,mo_cnt) = SFDC_mid_obs_mo_loop-SFDC_mid_sim_mo_loop;
            SFDCEmo.low_mo_loop(a,mo_cnt) = SFDC_low_obs_mo_loop-SFDC_low_sim_mo_loop;
            
            SFDCEPmo.high_mo_loop(a,mo_cnt) = 100*(SFDC_high_obs_mo_loop-SFDC_high_sim_yr_loop)./SFDC_high_obs_mo_loop;
            SFDCEPmo.mid_mo_loop(a,mo_cnt) = 100*(SFDC_mid_obs_mo_loop-SFDC_mid_sim_yr_loop)./SFDC_mid_obs_mo_loop;
            SFDCEPmo.low_mo_loop(a,mo_cnt) = 100*(SFDC_low_obs_mo_loop-SFDC_low_sim_yr_loop)./SFDC_low_obs_mo_loop;
            
        end
        
    end

end

[NSEtop_val,NSEtop_index] = sort(NSE_whole,'descend'); %a values, b index
[KGEtop_val,KGEtop_index] = sort(KGE_whole,'descend');
Best_KGE_run = qs(KGEtop_index(1),:);
Best_NSE_run = qs(NSEtop_index(1),:);

AT = Data.Calib.AT;
P = Data.Calib.Precip;

%looking for best KGE value run
KGE_sorted_val = zeros(length(KGEyear),da);
KGE_sorted_ind = zeros(length(KGEyear),da);
for i = 1:size(KGEyear,2)
   [a1,b1] = sort(KGEyear(:,i),'descend'); %a values, b index
   KGE_sorted_val(:,i) = a1;
   KGE_sorted_ind(:,i) = b1;
end
%recording best yearly qsim runs
qsim_best = zeros(da,366);
for i = 1:da 
    qsim_best(i,:) = qsyr_all(KGE_sorted_ind(1,i),:,i);
end
% sorting q values
qoyr_down = zeros(da,366); obs_ind=zeros(da,366); 
qsyr_down = zeros(da,366); sim_ind=zeros(da,366);
for i = 1:da
    [qoyr_down(i,:),obs_ind(i,:)] = sort(qoyr_all(i,:),'descend');
    [qsyr_down(i,:),sim_ind(i,:)] = sort(qsim_best(i,:),'descend');
end
% calculating EP
for i = 1:length(qsyr_down)
    for j = 1:da
        EP_obs_yr(j,i) = 100*(i/(length(qoyr_down)+1));
        EP_sim_yr(j,i) = 100*(i/(length(qsyr_down)+1));
    end
end

%Hydrologic signatures (whole)
for i = 1:da
    qfdcobs( i,:) = prctile(qoyr_down(i,:),(1:100));
    qfdcobs_EP(i,:) = sort(qfdcobs(i,:),'descend');
    qfdcsim( i,:) = prctile(qsyr_down(i,:),(1:100));
    qfdcsim_EP(i,:) = sort(qfdcsim(i,:),'descend');
    
    SFDC_low_obs_yr(i,1) = ((qfdcobs_EP(i,90))-(qfdcobs_EP(i,70)))/(90-70);
    SFDC_low_sim_yr(i,1) = ((qfdcsim_EP(i,90))-(qfdcsim_EP(i,70)))/(90-70);
    SFDC_mid_obs_yr(i,1) = ((qfdcobs_EP(i,60))-(qfdcobs_EP(i,30)))/(60-30);
    SFDC_mid_sim_yr(i,1) = ((qfdcsim_EP(i,60))-(qfdcsim_EP(i,30)))/(60-30);
    SFDC_high_obs_yr(i,1) = ((qfdcobs_EP(i,10))-(qfdcobs_EP(i,5)))/(10-5);
    SFDC_high_sim_yr(i,1) = ((qfdcsim_EP(i,10))-(qfdcsim_EP(i,5)))/(10-5);
    
    SFDCE_high_yr(i,1) = SFDC_high_obs_yr(i,1)-SFDC_high_sim_yr(i,1);
    SFDCE_mid_yr(i,1) = SFDC_mid_obs_yr(i,1)-SFDC_mid_sim_yr(i,1);
    SFDCE_low_yr(i,1) = SFDC_low_obs_yr(i,1)-SFDC_low_sim_yr(i,1);
    
    SFDCEP_high_yr(i,1) = SFDC_high_obs_yr(i,1)-SFDC_high_sim_yr(i,1);
    SFDCEP_mid_yr(i,1) = SFDC_mid_obs_yr(i,1)-SFDC_mid_sim_yr(i,1);
    SFDCEP_low_yr(i,1) = SFDC_low_obs_yr(i,1)-SFDC_low_sim_yr(i,1);
end

save bear_lake_hymod_5000hyd_q_EP_snow_Nrun1.mat EP_obs_yr qoyr_down EP_sim_yr qsyr_down
save bear_lake_hymod_5000hyd_ofs_best_snow_Nrun1.mat SFDCE_high_yr SFDCE_mid_yr SFDCE_low_yr SFDCEP_high_yr SFDCEP_mid_yr SFDCEP_low_yr 
save bear_lake_hymod_5000hyd_ofs_loop_snow_Newrun1.mat SFDCE SFDCEP 
save bear_lake_hymod_5000hyd_objFun_snow_Newrun1.mat NSEyear KGEyear WByear RREyear NSE_whole KGE_whole
save bear_lake_SA_5000sim_val_snow_Newrun1.mat NSEtop_val NSEtop_index KGEtop_val KGEtop_index Best_KGE_run Best_NSE_run
save bear_lake_SA_5000ofs_yr_snow_Newrun1.mat NSE_whole KGE_whole NSEyear WByear KGEyear RREyear 
save bear_lake_SA_5000sim_snow_Newrun1.mat PE_value 
save bear_lake_SA_5000pars_snow_Newrun1.mat XALL 
save bear_lake_hymod_5000hyd_ofs_mo_loop_snow_Newrun1.mat SFDCEmo SFDCEPmo
save bear_lake_hymod_5000hyd_objFun_mo_snow_Newrun1.mat NSEmo KGEmo WBmo RREmo

% Compute main (first-order) and total effects:
for c = 1:size(NSEyear,2)
    i1 = 1:size(XA,1);
    i2 = (size(XA,1)+1):2*size(XA,1);
    i3 = (2*size(XA,1)+1):size(XALL);
  [ WByearSi(c,:), WByearSTi(c,:) ] = vbsa_indices(WByear(i1,c),WByear(i2,c),WByear(i3,c)); %Si first order STi total order
  [ NSEyearSi(c,:), NSEyearSTi(c,:) ] = vbsa_indices(NSEyear(i1,c),NSEyear(i2,c),NSEyear(i3,c));
  [ KGEyearSi(c,:), KGEyearSTi(c,:) ] = vbsa_indices(KGEyear(i1,c),KGEyear(i2,c),KGEyear(i3,c)); 
  [ RREyearSi(c,:), RREyearSTi(c,:) ] = vbsa_indices(RREyear(i1,c),RREyear(i2,c),RREyear(i3,c));
  [ SFDCE_high_yearSi(c,:), SFDCE_high_yearSTi(c,:) ] = vbsa_indices(SFDCE.high_yr_loop(i1,c),SFDCE.high_yr_loop(i2,c),SFDCE.high_yr_loop(i3,c));
  [ SFDCE_mid_yearSi(c,:), SFDCE_mid_yearSTi(c,:) ] = vbsa_indices(SFDCE.mid_yr_loop(i1,c),SFDCE.mid_yr_loop(i2,c),SFDCE.mid_yr_loop(i3,c));
  [ SFDCE_low_yearSi(c,:), SFDCE_low_yearSTi(c,:) ] = vbsa_indices(SFDCE.low_yr_loop(i1,c),SFDCE.low_yr_loop(i2,c),SFDCE.low_yr_loop(i3,c));
end

save bear_lake_sens_yr_run5000_snow_Newrun1.mat WByearSi WByearSTi NSEyearSi NSEyearSTi KGEyearSi KGEyearSTi RREyearSi RREyearSTi 
save bear_lake_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat SFDCE_high_yearSi SFDCE_high_yearSTi SFDCE_mid_yearSi SFDCE_mid_yearSTi SFDCE_low_yearSi SFDCE_low_yearSTi

for c = 1:size(NSEmo,2)
    i1 = 1:size(XA,1);
    i2 = (size(XA,1)+1):2*size(XA,1);
    i3 = (2*size(XA,1)+1):size(XALL);
  [ WBmoSi(c,:), WBmoSTi(c,:) ] = vbsa_indices(WBmo(i1,c),WBmo(i2,c),WBmo(i3,c)); 
  [ NSEmoSi(c,:), NSEmoSTi(c,:) ] = vbsa_indices(NSEmo(i1,c),NSEmo(i2,c),NSEmo(i3,c));
  [ KGEmoSi(c,:), KGEmoSTi(c,:) ] = vbsa_indices(KGEmo(i1,c),KGEmo(i2,c),KGEmo(i3,c)); 
  [ RREmoSi(c,:), RREmoSTi(c,:) ] = vbsa_indices(RREmo(i1,c),RREmo(i2,c),RREmo(i3,c));
  [ SFDCE_high_mo_yearSi(c,:), SFDCE_high_mo_yearSTi(c,:) ] = vbsa_indices(SFDCEmo.high_mo_loop(i1,c),SFDCEmo.high_mo_loop(i2,c),SFDCEmo.high_mo_loop(i3,c));
  [ SFDCE_mid_mo_yearSi(c,:), SFDCE_mid_mo_yearSTi(c,:) ] = vbsa_indices(SFDCEmo.mid_mo_loop(i1,c),SFDCEmo.mid_mo_loop(i2,c),SFDCEmo.mid_mo_loop(i3,c));
  [ SFDCE_low_mo_yearSi(c,:), SFDCE_low_mo_yearSTi(c,:) ] = vbsa_indices(SFDCEmo.low_mo_loop(i1,c),SFDCEmo.low_mo_loop(i2,c),SFDCEmo.low_mo_loop(i3,c));
end

save bear_lake_sens_yr_hyd_mo_SFDCE_run5000_snow_Newrun1.mat SFDCE_high_mo_yearSi SFDCE_high_mo_yearSTi SFDCE_mid_mo_yearSi SFDCE_mid_mo_yearSTi SFDCE_low_mo_yearSi SFDCE_low_mo_yearSTi
save bear_lake_sens_mo_run5000_snow_Newrun1.mat WBmoSi WBmoSTi NSEmoSi NSEmoSTi KGEmoSi KGEmoSTi RREmoSi RREmoSTi 
