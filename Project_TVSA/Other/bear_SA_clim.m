%Ruta Basijokaite

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
