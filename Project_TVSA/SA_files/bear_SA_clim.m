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
Data_Qflow=Data_Qflow_Bear_Lake;
Data_Qflow(:,4)=Streamflow;  
save bear_Streamflow2.mat Data_Qflow
                                           
%Observation data
Data.Calib.Flow     = Streamflow;
Data.Calib.Period   = (1:length(dataset));
year = dataset(:,1);
month = dataset(:,2);
day = dataset(:,3);

%Using nldas
precip=dataset(:,6);
tempaver=(dataset(:,9)+ dataset(:,10))/2;%calculating average

%Met data
Data.Calib.Precip = precip;%in mm/day
Data.Calib.AT = tempaver;%in C

months=[10 11 12 1 2 3 4 5 6 7 8 9];
mo_cnt=0;

for j=1981:2013 %1980:2014
    mo_cnt = mo_cnt+1;
    [x, xx]=find(year==j & month == 10 & day == 1);
    [y, yy]=find(year==(j+1) & month == 9 & day == 30);
    
    clim(mo_cnt,1) = nansum(Data.Calib.Precip(x:y));
    clim(mo_cnt,2) = nanmean(Data.Calib.AT(x:y));
end

save bearclim.mat clim
