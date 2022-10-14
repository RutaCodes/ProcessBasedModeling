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
dataset = Data_Bear_Lake;%(1:12692,:)
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
Data.Calib.Evap = PE_value;

% Define input distribution and ranges:
M  = 10 ; % number of uncertain parameters 
DistrFun  = 'unif'  ; % Parameter distribution
% Assign feasible ranges to parameters
%DistrPar  = { [ 0.1 1 ]; [ 0 0.2 ]; [ 0 1 ]; [ 5 500]; [ 0 2 ]; [ 1 10 ]; [ 1 3 ]; [ -3 1 ]; [-3 3]; [0 0.1]; [0.9 1.1]; [0.9 1.1] } ; % Parameter ranges
%From 12 parameters to 10
DistrPar  = { [ 0.1 1 ]; [ 0 0.2 ]; [ 0 1 ]; [ 5 500]; [ 0 2 ]; [ 1 10 ]; [ 1 3 ]; [ -3 1 ]; [-3 3]; [0 0.1] } ; % Parameter ranges

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

E1=0.5;
E2=2;
for a=1:size(XALL,1) % for loop to cycle through random sampling parameter sets
    
    % Run model once
    Model = Hymod01opt(Data,XALL(a,:));
    
    % Specify sim & obs - need to be same size
    qobs = Data.Calib.Flow;
    qsim = Model.Q;
    c = 0;da = 1;
    qs(a,:) = qsim;
%     sm1 = Model.XHuz;
%     sm2 = Model.XCuz;
    [x,~] = find(year==1981); %start at Jan 1
    [y,~] = find(year==1985); %for 5 year values
    [z,~] = find(year==1990); %for 10 year values
    
    % 5 year values
    qo5 = qobs(min(x):max(y),1);
    qs5 = qsim(1,min(x):max(y));
    NSE5 = 1 - (sum((qo5-qs5').^2)/(sum((qo5 - mean(qo5)).^2)));
    KGE5 = kge(qs5',qo5);
    WB5 = sum(abs(qo5-qs5'))/sum(qo5);
    % 10 year values
    qo10 = qobs(min(x):max(z),1);
    qs10 = qsim(1,min(x):max(z));
    NSE10 = 1 - (sum((qo10-qs10').^2)/(sum((qo10 - mean(qo10)).^2)));
    KGE10 = kge(qs10',qo10);
    WB10 = sum(abs(qo10-qs10'))/sum(qo10);
    
    clear x y z qo5 qs5 qo10 qs10
    [x,~] = find(year==1981 & month == 10 & day == 1); %start at Oct 1
    [y,~] = find(year==1985 & month == 9 & day == 30); %for 5 year values
    [z,~] = find(year==1990 & month == 9 & day == 30); %for 10 year values
    
    % 5 year values
    qo5 = qobs(x:y,1);
    qs5 = qsim(1,x:y);
    NSE5_wy = 1 - (sum((qo5-qs5').^2)/(sum((qo5 - mean(qo5)).^2)));
    KGE5_wy = kge(qs5',qo5);
    WB5_wy = sum(abs(qo5-qs5'))/sum(qo5);
    % 10 year values
    qo10 = qobs(x:z,1);
    qs10 = qsim(1,x:z);
    NSE10_wy = 1 - (sum((qo10-qs10').^2)/(sum((qo10 - mean(qo10)).^2)));
    KGE10_wy = kge(qs10',qo10);
    WB10_wy = sum(abs(qo10-qs10'))/sum(qo10);
    
%     for j=1981:2014 %1980:2014
%         [x, y]=find(year==j);
%         
%         da = da+1;
%         qoyr = Data.Calib.Flow(x);
%         qsyr = Model.Q(x);
%         
%         NSEyear(a,da) = 1 - (sum((qoyr-qsyr').^2)/(sum((qoyr - mean(qoyr)).^2)));
%         WByear(a,da) = sum(abs(qoyr-qsyr'))/sum(qoyr);
%         KGEyear(a,da) = kge(qsyr',qoyr);
%         RREyear(a,da) = 100*[(sum(qsim)/sum(Data.Calib.Precip)) - (sum(qobs)/sum(Data.Calib.Precip))]./(sum(qobs)/sum(Data.Calib.Precip));
%         
%         % Fuzzy index
%         logqobs=log10(qoyr); %converting to log space
%         val=log10(qsyr');
% 
%         [a1, ~]=find(abs(val - logqobs)>E2);M(1,a1)=0;
%         [b1, ~]=find(abs(val - logqobs)<E1);M(1,b1)=1;
%         [c1, ~]=find(abs(val - logqobs)> E1 & abs(val - logqobs) < E2);
%         cdat = abs(logqobs(c1,:)-val(c1,:));
%         %transform it to the minimum and maximum data points (and then subtract by 1)
%         c_val = 1 - (cdat - E1)./ (E2 - E1);
%         M(1,c1)=c_val;
%         
%         Myear(a,da) = sum(M)./length(M);
%         
%     end

    % NSE
    NSEW(a,1) = 1 - (sum((qobs-qsim').^2)/(sum((qobs - mean(qobs)).^2)));
    WBW(a, 1) = sum(abs(qobs-qsim'))./sum(qobs);
end

AT = Data.Calib.AT;
P = Data.Calib.Precip;

% save bear_lake_SA_5000ofs_yr_test1.mat WBW NSEW NSEyear WByear Myear KGEyear RREyear %N by year nr
% save bear_lake_SA_5000sim_test1.mat PE_value %data length by 1
% save bear_lake_SA_5000pars_test1.mat XALL %N by par  nr
save bear_lake_SA_5000ofs_5y_test0.mat NSE5 KGE5 WB5 NSE5_wy KGE5_wy WB5_wy
save bear_lake_SA_5000ofs_10y_test0.mat NSE10 KGE10 WB10 NSE10_wy KGE10_wy WB10_wy
% %save merced_pohono_SA_5000sim_var_test1.mat qs %does not save, file too large
% %save merced_pohono_SA_5000sim_var_test1.mat qsim qs sm1 sm2

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
end

% save bear_lake_sens_yr_run5000_test1.mat WByearSi WByearSTi NSEyearSi NSEyearSTi KGEyearSi KGEyearSTi MyearSi MyearSTi RREyearSi RREyearSTi %year nr by par nr

%%%%%%%%%%%%%%%% figures %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure; % plot main and total separately
set(gcf,'color','w');
subplot(2,2,1);
imagesc(KGEyearSi);
title('KGE (yearly Si)');colorbar;
%X_Labels = {'Kq';'Ks';'Alp';'Huz';'B';'DDF';'TR';'TM'} ;
%xlabel(X_Labels);
hold on;
subplot(2,2,2);
imagesc(KGEyearSTi);
title('KGE (yearly STi)');colorbar;
hold on;
subplot(2,2,3);
imagesc(NSEyearSi);
title('NSE (yearly Si)');colorbar;
hold on;
subplot(2,2,4);
imagesc(NSEyearSTi);
title('NSE (yearly STi)');colorbar;
