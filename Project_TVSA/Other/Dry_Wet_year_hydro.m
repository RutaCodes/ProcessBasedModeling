my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

figure; set(gcf,'color','w'); %Wet year
MAP=colormap;
load Data_Qflow_Merced_Pohono.mat; %streamflow
year = Data_Qflow_Merced_Pohono(:,1);
month = Data_Qflow_Merced_Pohono(:,2);
day = Data_Qflow_Merced_Pohono(:,3);
%Wet year in all watersheds 1982 oct 1 to 1983 sept 30
[x1, ~]=find(year==1982 & month == 10 & day == 1);
[x2, ~]=find(year==1983 & month == 9 & day == 30);
%Dry year in all watersheds 1993 oct 1 to 1994 sept 30
[y1, ~]=find(year==1993 & month == 10 & day == 1);
[y2, ~]=find(year==1994 & month == 9 & day == 30);
W_size = 836.15; % basin size in km2
Streamflow = ((Data_Qflow_Merced_Pohono(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(x1:x2)); hold on;
load Data_Qflow_Bear_Lake.mat; %streamflow
W_size = 142.19; % basin size in km2
Streamflow = ((Data_Qflow_Bear_Lake(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(x1:x2)); hold on;
load Data_Qflow_Big_Rock_R.mat; %streamflow
W_size = 310.25; % basin size in km2
Streamflow = ((Data_Qflow_Big_Rock_R(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(x1:x2)); hold on;
load Data_Qflow_Blackwood_Cr.mat; %streamflow
W_size = 32.46; % basin size in km2
Streamflow = ((Data_Qflow_Blackwood_Cr(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(x1:x2)); hold on;
load Data_Qflow_Deer_Cr.mat; %streamflow
W_size = 634.08; % basin size in km2
Streamflow = ((Data_Qflow_Deer_Cr(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(x1:x2)); hold on;
load Data_Qflow_Merced_Happy.mat; %streamflow
W_size = 472.3; % basin size in km2
Streamflow = ((Data_Qflow_Merced_Happy(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(x1:x2)); hold on;
load Data_Qflow_MF_Eel_R.mat; %streamflow
W_size = 1930.41; % basin size in km2
Streamflow = ((Data_Qflow_MF_Eel_R(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(x1:x2)); hold on;
load Data_Qflow_Pitman_Cr.mat; %streamflow
W_size = 65.21; % basin size in km2
Streamflow = ((Data_Qflow_Pitman_Cr(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(x1:x2)); hold on;
load Data_Qflow_Sagehen_Cr.mat; %streamflow
W_size = 27.34; % basin size in km2
Streamflow = ((Data_Qflow_Sagehen_Cr(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(x1:x2)); hold on;
load Data_Qflow_Salmon_R.mat; %streamflow
W_size = 1946.3; % basin size in km2
Streamflow = ((Data_Qflow_Salmon_R(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(x1:x2)); hold on;
load Data_Qflow_SF_Trinity_R.mat; %streamflow
W_size = 1982.54; % basin size in km2
Streamflow = ((Data_Qflow_SF_Trinity_R(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(x1:x2)); hold on;
load Data_Qflow_Trinity_R.mat; %streamflow
W_size = 385.08; % basin size in km2
Streamflow = ((Data_Qflow_Trinity_R(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(x1:x2)); hold on;
legend('Merced Pohono','Bear','Big Rock','Blackwood','Deer','Merced Happy','MF Eel','Pitman','Sagehen','Salmon','SF Trinity','Trinity'); 
xlim([0 365]); title('Wet Year');

figure; set(gcf,'color','w'); %Dry year
load Data_Qflow_Merced_Pohono.mat; %streamflow
W_size = 836.15; % basin size in km2
Streamflow = ((Data_Qflow_Merced_Pohono(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(y1:y2)); hold on;
load Data_Qflow_Bear_Lake.mat; %streamflow
W_size = 142.19; % basin size in km2
Streamflow = ((Data_Qflow_Bear_Lake(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(y1:y2)); hold on;
load Data_Qflow_Big_Rock_R.mat; %streamflow
W_size = 310.25; % basin size in km2
Streamflow = ((Data_Qflow_Big_Rock_R(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(y1:y2)); hold on;
load Data_Qflow_Blackwood_Cr.mat; %streamflow
W_size = 32.46; % basin size in km2
Streamflow = ((Data_Qflow_Blackwood_Cr(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(y1:y2)); hold on;
load Data_Qflow_Deer_Cr.mat; %streamflow
W_size = 634.08; % basin size in km2
Streamflow = ((Data_Qflow_Deer_Cr(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(y1:y2)); hold on;
load Data_Qflow_Merced_Happy.mat; %streamflow
W_size = 472.3; % basin size in km2
Streamflow = ((Data_Qflow_Merced_Happy(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(y1:y2)); hold on;
load Data_Qflow_MF_Eel_R.mat; %streamflow
W_size = 1930.41; % basin size in km2
Streamflow = ((Data_Qflow_MF_Eel_R(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(y1:y2)); hold on;
load Data_Qflow_Pitman_Cr.mat; %streamflow
W_size = 65.21; % basin size in km2
Streamflow = ((Data_Qflow_Pitman_Cr(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(y1:y2)); hold on;
load Data_Qflow_Sagehen_Cr.mat; %streamflow
W_size = 27.34; % basin size in km2
Streamflow = ((Data_Qflow_Sagehen_Cr(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(y1:y2)); hold on;
load Data_Qflow_Salmon_R.mat; %streamflow
W_size = 1946.3; % basin size in km2
Streamflow = ((Data_Qflow_Salmon_R(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(y1:y2)); hold on;
load Data_Qflow_SF_Trinity_R.mat; %streamflow
W_size = 1982.54; % basin size in km2
Streamflow = ((Data_Qflow_SF_Trinity_R(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(y1:y2)); hold on;
load Data_Qflow_Trinity_R.mat; %streamflow
W_size = 385.08; % basin size in km2
Streamflow = ((Data_Qflow_Trinity_R(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
plot(Streamflow(y1:y2)); hold on;
legend('Merced Pohono','Bear','Big Rock','Blackwood','Deer','Merced Happy','MF Eel','Pitman','Sagehen','Salmon','SF Trinity','Trinity'); 
xlim([0 365]); title('Dry Year');

