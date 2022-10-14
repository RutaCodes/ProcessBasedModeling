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
% Assign feasible ranges to 12 parameters
%DistrPar  = { [ 0.1 1 ]; [ 0 0.2 ]; [ 0 1 ]; [ 5 500]; [ 0 2 ]; [ 1 10 ]; [ 1 3 ]; [ -3 1 ]; [-3 3]; [0 0.1]; [0.9 1.1]; [0.9 1.1] } ; % Parameter ranges
%Old parameter ranges
%DistrPar  = { [ 0.1 1 ]; [ 0 0.2 ]; [ 0 1 ]; [ 5 500]; [ 0 2 ]; [ 1 10 ]; [ 1 3 ]; [ -3 1 ]; [-3 3]; [0 0.1] } ; 
%New parameter ranges
%DistrPar  = { [ 0.1 0.8 ]; [ 0 0.2 ]; [ 0 0.8 ]; [ 5 500 ]; [ 0 2 ]; [ 1 8 ]; [ 1 3 ]; [ -3 1 ]; [-2 2]; [0 0.05] } ;

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

E1=0.5; E2=2;
qsyr_all=zeros(60000,366,33); qoyr_all=zeros(33,366);
for a=1:size(XALL,1) % for loop to cycle through random sampling parameter sets
    
    % Run model once
    %Model = Hymod10par_edit(Data,XALL(a,:));%new snow routine
    %Model = Hymod01opt10par(Data,XALL(a,:));%old snow routine
    %Edited new snow
    Model = Hymod10par_edit_v1_rb(Data,XALL(a,:));
    
    % Specify sim & obs - need to be same size
    qobs = Data.Calib.Flow;
    qsim = Model.Q;
    c = 0;da = 0;
    qs(a,:) = qsim;

    NSE_whole(a,1)= 1 - (sum((qobs-qsim').^2)/(sum((qobs - mean(qobs)).^2)));
    KGE_whole(a,1)= kge(qsim',qobs);
    
    for j=1981:2013 %1980:2014
        [x, xx]=find(year==j & month == 10 & day == 1);
        [y, yy]=find(year==(j+1) & month == 9 & day == 30);
        
        da = da+1;
        qoyr = Data.Calib.Flow(x:y);
        qsyr = Model.Q(x:y);
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
        
        % Fuzzy index
        logqobs=log10(qoyr); %converting to log space
        val=log10(qsyr');

        [a1, ~]=find(abs(val - logqobs)>E2);M(1,a1)=0;
        [b1, ~]=find(abs(val - logqobs)<E1);M(1,b1)=1;
        [c1, ~]=find(abs(val - logqobs)> E1 & abs(val - logqobs) < E2);
        cdat = abs(logqobs(c1,:)-val(c1,:));
        %transform it to the minimum and maximum data points (and then subtract by 1)
        c_val = 1 - (cdat - E1)./ (E2 - E1);
        M(1,c1)=c_val;
        
        Myear(a,da) = sum(M)./length(M);
        
    end

%     % NSE
%     NSEW(a,1) = 1 - (sum((qobs-qsim').^2)/(sum((qobs - mean(qobs)).^2)));
%     WBW(a, 1) = sum(abs(qobs-qsim'))./sum(qobs);
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

%Hydrologic signatures
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

% figure; set(gcf,'color','w');
% plot(qs(KGEtop_index(1),:)); hold on;
% plot(qobs); legend('Simulated','Observed');
% title('Best KGE value'); %xlim([1 365]);

% save bear_lake_SA_5000sim_val_test4.mat NSEtop_val NSEtop_index KGEtop_val KGEtop_index Best_KGE_run Best_NSE_run
% save bear_lake_SA_5000ofs_yr_test4.mat WBW NSEW NSEyear WByear Myear KGEyear RREyear %N by year nr
% save bear_lake_SA_5000sim_test4.mat PE_value %data length by 1
% save bear_lake_SA_5000pars_test4.mat XALL %N by par  nr
% %save merced_pohono_SA_5000sim_var_test1.mat qsim qs sm1 sm2

save bear_lake_hymod_5000hyd_q_EP_snow_old.mat EP_obs_yr qoyr_down EP_sim_yr qsyr_down
save bear_lake_hymod_5000hyd_ofs_best_snow_old.mat SFDCE_high_yr SFDCE_mid_yr SFDCE_low_yr SFDCEP_high_yr SFDCEP_mid_yr SFDCEP_low_yr %SFDCE_high_whole SFDCE_mid_whole SFDCE_low_whole %EP_obs EP_obs_yr EP_sim_yr EP_sim
%save merced_pohono_hymod_5000hyd_ofs_loop_test5.mat SFDCE_high_yr_loop SFDCE_mid_yr_loop SFDCE_low_yr_loop
save bear_lake_hymod_5000hyd_ofs_loop_snow_old.mat SFDCE SFDCEP %SFDCE.high_yr_loop SFDCE.mid_yr_loop SFDCE.low_yr_loop SFDCEP.high_yr_loop SFDCEP.mid_yr_loop SFDCEP.low_yr_loop
save bear_lake_hymod_5000hyd_objFun_snow_old.mat NSEyear KGEyear WByear RREyear NSE_whole KGE_whole
save bear_lake_SA_5000sim_val_snow_old.mat NSEtop_val NSEtop_index KGEtop_val KGEtop_index Best_KGE_run Best_NSE_run
save bear_lake_SA_5000ofs_yr_snow_old.mat NSE_whole KGE_whole NSEyear WByear Myear KGEyear RREyear %N by year nr
save bear_lake_SA_5000sim_snow_old.mat PE_value %data length by 1
save bear_lake_SA_5000pars_snow_old.mat XALL %N by par  nr

% Compute main (first-order) and total effects:
for c=1:size(NSEyear,2);
    i1 = 1:size(XA,1);
    i2 = (size(XA,1)+1):2*size(XA,1);
    i3 = (2*size(XA,1)+1):size(XALL);
  [ WByearSi(c,:), WByearSTi(c,:) ] = vbsa_indices(WByear(i1,c),WByear(i2,c),WByear(i3,c)); %Si first order STi total order
  [ NSEyearSi(c,:), NSEyearSTi(c,:) ] = vbsa_indices(NSEyear(i1,c),NSEyear(i2,c),NSEyear(i3,c));
  [ KGEyearSi(c,:), KGEyearSTi(c,:) ] = vbsa_indices(KGEyear(i1,c),KGEyear(i2,c),KGEyear(i3,c)); %Si first order STi total order
  [ MyearSi(c,:), MyearSTi(c,:) ] = vbsa_indices(Myear(i1,c),Myear(i2,c),Myear(i3,c)); %Si first order STi total order
  [ RREyearSi(c,:), RREyearSTi(c,:) ] = vbsa_indices(RREyear(i1,c),RREyear(i2,c),RREyear(i3,c));
  [ SFDCE_high_yearSi(c,:), SFDCE_high_yearSTi(c,:) ] = vbsa_indices(SFDCE.high_yr_loop(i1,c),SFDCE.high_yr_loop(i2,c),SFDCE.high_yr_loop(i3,c));
  [ SFDCE_mid_yearSi(c,:), SFDCE_mid_yearSTi(c,:) ] = vbsa_indices(SFDCE.mid_yr_loop(i1,c),SFDCE.mid_yr_loop(i2,c),SFDCE.mid_yr_loop(i3,c));
  [ SFDCE_low_yearSi(c,:), SFDCE_low_yearSTi(c,:) ] = vbsa_indices(SFDCE.low_yr_loop(i1,c),SFDCE.low_yr_loop(i2,c),SFDCE.low_yr_loop(i3,c));
end

save bear_lake_sens_yr_hyd_run5000_snow_old.mat SFDCE_high_yearSi SFDCE_high_yearSTi SFDCE_mid_yearSi SFDCE_mid_yearSTi SFDCE_low_yearSi SFDCE_low_yearSTi
save bear_lake_sens_yr_run5000_snow_old.mat WByearSi WByearSTi NSEyearSi NSEyearSTi KGEyearSi KGEyearSTi MyearSi MyearSTi RREyearSi RREyearSTi %year nr by par nr
% save bear_lake_sens_yr_run5000_test4.mat WByearSi WByearSTi NSEyearSi NSEyearSTi KGEyearSi KGEyearSTi MyearSi MyearSTi RREyearSi RREyearSTi %year nr by par nr
%test 2 - normal year, test 3 - water year
%test 4 - water year, PCF and ATCF are set to 1, to avoid misinterpretation
%of results due to input changes from PCF
%test 6 - SA with FDC code
%test 9nr - SA with new parameter ranges
%test snow1 - SA with new paranemeter ranges (from 9nr) and new snow routine
%test snow2 - New snow routine with PET changes
%test snow_old - Old snow routine with PET changes
%of results due to input changes from PCF
%%%%%%%%%%%%%%%% figures %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure; % plot Si/STi
set(gcf,'color','w');
subplot(2,2,1);
imagesc(KGEyearSi);
title('KGE Si');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});
hold on;
subplot(2,2,2);
imagesc(SFDCE_low_yearSi);
title('SFDCE low Si');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});
hold on;
subplot(2,2,3);
imagesc(KGEyearSTi);
title('KGE STi');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});
hold on;
subplot(2,2,4);
imagesc(SFDCE_low_yearSTi);
title('SFDCE low STi');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});

figure; set(gcf,'color','w');
subplot(2,2,1); imagesc(KGEyearSTi);
title('KGE STi'); colorbar; caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SFC'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});
subplot(2,2,2); imagesc(SFDCE_high_yearSTi);
title('SFDCE high STi'); colorbar; caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SFC'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});
subplot(2,2,3); imagesc(SFDCE_mid_yearSTi);
title('SFDCE mid STi'); colorbar; caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SFC'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});
subplot(2,2,4); imagesc(SFDCE_low_yearSTi);
title('SFDCE low STi'); colorbar; caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SFC'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});

figure; set(gcf,'color','w');
subplot(2,2,1); imagesc(KGEyearSi);
title('KGE Si'); colorbar; caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SFC'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});
subplot(2,2,2); imagesc(SFDCE_high_yearSi);
title('SFDCE high Si'); colorbar; caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SFC'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});
subplot(2,2,3); imagesc(SFDCE_mid_yearSi);
title('SFDCE mid Si'); colorbar; caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SFC'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});
subplot(2,2,4); imagesc(SFDCE_low_yearSi);
title('SFDCE low Si'); colorbar; caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SFC'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});

% figure; % plot main and total separately
% set(gcf,'color','w');
% subplot(2,2,1);
% imagesc(KGEyearSi);
% title('KGE (yearly Si)');colorbar;
% %X_Labels = {'Kq';'Ks';'Alp';'Huz';'B';'DDF';'TR';'TM'} ;
% %xlabel(X_Labels);
% hold on;
% subplot(2,2,2);
% imagesc(KGEyearSTi);
% title('KGE (yearly STi)');colorbar;
% hold on;
% subplot(2,2,3);
% imagesc(NSEyearSi);
% title('NSE (yearly Si)');colorbar;
% hold on;
% subplot(2,2,4);
% imagesc(NSEyearSTi);
% title('NSE (yearly STi)');colorbar;
