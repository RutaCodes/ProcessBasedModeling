%Ruta Basijokaite

my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

MAP=colormap;
%finding dry and wet years in the streamflow data array
load Data_Qflow_Merced_Pohono.mat; %streamflow
year = Data_Qflow_Merced_Pohono(:,1);
month = Data_Qflow_Merced_Pohono(:,2);
day = Data_Qflow_Merced_Pohono(:,3);
%Wet year in all watersheds 1982 oct 1 to 1983 sept 30
[x1, ~]=find(year==1994 & month == 10 & day == 1);
[x2, ~]=find(year==1995 & month == 9 & day == 30);
%Dry year in all watersheds 1993 oct 1 to 1994 sept 30
[y1, ~]=find(year==1993 & month == 10 & day == 1);
[y2, ~]=find(year==1994 & month == 9 & day == 30);

%watershed sizes (from smallest to largest)
 W_size=[27.34; 32.46; 65.21; 142.19; 310.25; 385.08; 472.3; 634.08; 836.15; 1930.41; 1946.3; 1982.54];
% %turning the range from 1 to 64 for MAP
% for i=1:length(W_size)
%     W_size_stand(i)=(W_size(i)-27.34)/(1982.54-27.34);%from 0 to 1
%     W_size_scaled(i)=W_size_stand(i)*(64-1)+1; %from 1 to 64 
% end
% W_size_int=int16(fix(W_size_scaled));
% 
% %Recording streamflow values corresponding to dry and wet year
% load Data_Qflow_Sagehen_Cr.mat; %streamflow
% Streamflow = ((Data_Qflow_Sagehen_Cr(:,4)*0.0283168)/(W_size(1)*10^6))*1000*3600*24; %from ft3/s to mm/day              
%                                            %m3/s         m/s         mm/day                                                        
% Stream_values_wet(1,:)=Streamflow(x1:x2);%smallest watershed
% Stream_values_dry(1,:)=Streamflow(y1:y2);%smallest watershed
% load Data_Qflow_Blackwood_Cr.mat; %streamflow
% Streamflow = ((Data_Qflow_Blackwood_Cr(:,4)*0.0283168)/(W_size(2)*10^6))*1000*3600*24; %from ft3/s to mm/day              
%                                            %m3/s         m/s         mm/day                                                        
% Stream_values_wet(2,:)=Streamflow(x1:x2);
% Stream_values_dry(2,:)=Streamflow(y1:y2);
% load Data_Qflow_Pitman_Cr.mat; %streamflow
% Streamflow = ((Data_Qflow_Pitman_Cr(:,4)*0.0283168)/(W_size(3)*10^6))*1000*3600*24; %from ft3/s to mm/day              
%                                            %m3/s         m/s         mm/day                                                        
% Stream_values_wet(3,:)=Streamflow(x1:x2);
% Stream_values_dry(3,:)=Streamflow(y1:y2);
% load Data_Qflow_Bear_Lake.mat; %streamflow
% Streamflow = ((Data_Qflow_Bear_Lake(:,4)*0.0283168)/(W_size(4)*10^6))*1000*3600*24; %from ft3/s to mm/day              
%                                            %m3/s         m/s         mm/day                                                        
% Stream_values_wet(4,:)=Streamflow(x1:x2);
% Stream_values_dry(4,:)=Streamflow(y1:y2);
% load Data_Qflow_Big_Rock_R.mat; %streamflow
% Streamflow = ((Data_Qflow_Big_Rock_R(:,4)*0.0283168)/(W_size(5)*10^6))*1000*3600*24; %from ft3/s to mm/day              
%                                            %m3/s         m/s         mm/day                                                        
% Stream_values_wet(5,:)=Streamflow(x1:x2);
% Stream_values_dry(5,:)=Streamflow(y1:y2);
% load Data_Qflow_Trinity_R.mat; %streamflow
% Streamflow = ((Data_Qflow_Trinity_R(:,4)*0.0283168)/(W_size(6)*10^6))*1000*3600*24; %from ft3/s to mm/day              
%                                            %m3/s         m/s         mm/day                                                        
% Stream_values_wet(6,:)=Streamflow(x1:x2);
% Stream_values_dry(6,:)=Streamflow(y1:y2);
% load Data_Qflow_Merced_Happy.mat; %streamflow
% Streamflow = ((Data_Qflow_Merced_Happy(:,4)*0.0283168)/(W_size(7)*10^6))*1000*3600*24; %from ft3/s to mm/day              
%                                            %m3/s         m/s         mm/day                                                        
% Stream_values_wet(7,:)=Streamflow(x1:x2);
% Stream_values_dry(7,:)=Streamflow(y1:y2);
% load Data_Qflow_Deer_Cr.mat; %streamflow
% Streamflow = ((Data_Qflow_Deer_Cr(:,4)*0.0283168)/(W_size(8)*10^6))*1000*3600*24; %from ft3/s to mm/day              
%                                            %m3/s         m/s         mm/day                                                        
% Stream_values_wet(8,:)=Streamflow(x1:x2);
% Stream_values_dry(8,:)=Streamflow(y1:y2);
% load Data_Qflow_Merced_Pohono.mat; %streamflow
% Streamflow = ((Data_Qflow_Merced_Pohono(:,4)*0.0283168)/(W_size(9)*10^6))*1000*3600*24; %from ft3/s to mm/day              
%                                            %m3/s         m/s         mm/day                                                        
% Stream_values_wet(9,:)=Streamflow(x1:x2);
% Stream_values_dry(9,:)=Streamflow(y1:y2);
% load Data_Qflow_MF_Eel_R.mat; %streamflow
% Streamflow = ((Data_Qflow_MF_Eel_R(:,4)*0.0283168)/(W_size(10)*10^6))*1000*3600*24; %from ft3/s to mm/day              
%                                            %m3/s         m/s         mm/day                                                        
% Stream_values_wet(10,:)=Streamflow(x1:x2);
% Stream_values_dry(10,:)=Streamflow(y1:y2);
% load Data_Qflow_Salmon_R.mat; %streamflow
% Streamflow = ((Data_Qflow_Salmon_R(:,4)*0.0283168)/(W_size(11)*10^6))*1000*3600*24; %from ft3/s to mm/day              
%                                            %m3/s         m/s         mm/day                                                        
% Stream_values_wet(11,:)=Streamflow(x1:x2);
% Stream_values_dry(11,:)=Streamflow(y1:y2);
% load Data_Qflow_SF_Trinity_R.mat; %streamflow
% Streamflow = ((Data_Qflow_SF_Trinity_R(:,4)*0.0283168)/(W_size(12)*10^6))*1000*3600*24; %from ft3/s to mm/day              
%                                            %m3/s         m/s         mm/day                                                        
% Stream_values_wet(12,:)=Streamflow(x1:x2);
% Stream_values_dry(12,:)=Streamflow(y1:y2);

% figure;set(gcf,'color','w'); %Wet year
% for i=1:12
%     plot(Stream_values_wet(i,:),'Color',MAP(W_size_int(i),:)); hold on;
% end
% xlim([0 365]); title('Wet year (size)');
% legend('Sagehen (smallest)','Blackwood','Pitman','Bear','Big Rock','Trinity','Merced Happy','Deer','Merced Pohono','MF Eel','Salmon','SF Trinity (biggest)');
% xticks([1 32 62 93 124 152 183 213 244 274 305 336]);
% xticklabels({'Oct 1','Nov 1','Dec 1','Jan 1','Feb 1','March 1','Apr 1','May 1','June 1','July 1','Aug 1','Sep 1'});
% 
% figure;set(gcf,'color','w'); %Dry year
% for i=1:12
%     plot(Stream_values_dry(i,:),'Color',MAP(W_size_int(i),:)); hold on;
% end
% xlim([0 365]); title('Dry year (size)');
% legend('Sagehen(smallest)','Blackwood','Pitman','Bear','Big Rock','Trinity','Merced Happy','Deer','Merced Pohono','MF Eel','Salmon','SF Trinity (biggest)');
% xticks([1 32 62 93 124 152 183 213 244 274 305 336]);
% xticklabels({'Oct 1','Nov 1','Dec 1','Jan 1','Feb 1','March 1','Apr 1','May 1','June 1','July 1','Aug 1','Sep 1'});

W_elev=[1629.7; 2216.4; 2578.2; 2746.1; 3244.6];
%turning the range from 1 to 64 for MAP
for i=1:length(W_elev)
    W_elev_stand(i)=(W_elev(i)-1629.7)/(3244.6-1629.7);%from 0 to 1
    W_elev_scaled(i)=W_elev_stand(i)*(64-1)+1; %from 1 to 64 
end
W_elev_int=int16(fix(W_elev_scaled));

load Data_Qflow_Trinity_R.mat; %streamflow
Streamflow = ((Data_Qflow_Trinity_R(:,4)*0.0283168)/(W_size(6)*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
Stream_values_wet_elev(1,:)=Streamflow(x1:x2);
Stream_values_dry_elev(1,:)=Streamflow(y1:y2);
load Data_Qflow_Blackwood_Cr.mat; %streamflow
Streamflow = ((Data_Qflow_Blackwood_Cr(:,4)*0.0283168)/(W_size(2)*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
Stream_values_wet_elev(2,:)=Streamflow(x1:x2);
Stream_values_dry_elev(2,:)=Streamflow(y1:y2);
load Data_Qflow_Merced_Pohono.mat; %streamflow
Streamflow = ((Data_Qflow_Merced_Pohono(:,4)*0.0283168)/(W_size(9)*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
Stream_values_wet_elev(3,:)=Streamflow(x1:x2);
Stream_values_dry_elev(3,:)=Streamflow(y1:y2);
load Data_Qflow_Merced_Happy.mat; %streamflow
Streamflow = ((Data_Qflow_Merced_Happy(:,4)*0.0283168)/(W_size(7)*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
Stream_values_wet_elev(4,:)=Streamflow(x1:x2);
Stream_values_dry_elev(4,:)=Streamflow(y1:y2);
load Data_Qflow_Bear_Lake.mat; %streamflow
Streamflow = ((Data_Qflow_Bear_Lake(:,4)*0.0283168)/(W_size(4)*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        
Stream_values_wet_elev(5,:)=Streamflow(x1:x2);
Stream_values_dry_elev(5,:)=Streamflow(y1:y2);

figure;set(gcf,'color','w'); %Wet year
for i=1:5
    plot(Stream_values_wet_elev(i,:),'Color',MAP(W_elev_int(i),:)); hold on;
end
xlim([0 365]); title('Wet year 1994'); ylim([0 40]);
legend('Trinity (lowest)','Blackwood','Merced Pohono','Merced Happy','Bear (highest)');
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

figure;set(gcf,'color','w'); %Dry year
for i=1:5
    plot(Stream_values_dry_elev(i,:),'Color',MAP(W_elev_int(i),:)); hold on;
end
xlim([0 365]); title('Dry year 1993'); ylim([0 40]);
legend('Trinity (lowest)','Blackwood','Merced Pohono','Merced Happy','Bear (highest)');
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

    
