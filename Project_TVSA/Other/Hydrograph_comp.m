%Ruta Basijokaite

% Latitude and WS size
lat = 37.33939; % latitude at outlet
W_size = 142.19; % basin size in km2

% Load the data files
load Data_Bear_Lake.mat; %nldas data
dataset = Data_Bear_Lake(1:12692,:);
load Data_Qflow_Bear_Lake.mat; %streamflow
Streamflow = ((Data_Qflow_Bear_Lake(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        

load bear_lake_SA_5000sim_val_snow_old.mat;
                                           
figure; set(gcf,'color','w');
plot(Best_KGE_run); hold on;
plot(Streamflow);
legend('Simulated','Observed');
title('Old snow routine');

load bear_lake_SA_5000sim_val_snow2.mat;

figure; set(gcf,'color','w');
plot(Best_KGE_run); hold on;
plot(Streamflow);
legend('Simulated','Observed');
title('New snow routine');
