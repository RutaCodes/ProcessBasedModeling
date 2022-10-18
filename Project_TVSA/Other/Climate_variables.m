%Ruta Basijokaite

clear all; 

%Bear Lake
% Latitude and WS size
lat = 37.33939; % latitude at outlet
W_size = 142.19; % basin size in km2

% Load the data files
load Data_Bear_Lake.mat; %data nldas
dataset = Data_Bear_Lake; 
% load Data_Qflow_Bear_Lake.mat; %streamflow
% Streamflow = ((Data_Qflow_Bear_Lake(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
%                                            %m3/s         m/s         mm/day ;                                                       
year = dataset(:,1);
month = dataset(:,2);
day = dataset(:,3);

precip=dataset(:,6);
tempaver=(dataset(:,9)+ dataset(:,10))/2;

da = 0;
Prec_WatY=zeros(33,365);
Temp_WatY=zeros(33,365);
for j=1981:2013 %1980:2014
        [x, ~]=find(year==j & month == 10 & day == 1);
        [y, ~]=find(year==(j+1) & month == 9 & day == 30);
        
        da=da+1;
        Prec_WatY(da,1:length(precip(x:y)))=precip(x:y,1)';
        Prec_WatY_aver(da,1)=mean(precip(x:y,1));
        Prec_WatY_cum(da,1)=sum(precip(x:y,1));
        Temp_WatY(da,1:length(precip(x:y)))=tempaver(x:y,1)';
        Temp_WatY_aver(da,1)=mean(tempaver(x:y,1));
        
end

% 7 day moving window
for i=4:(length(precip)-3)
    Prec_7day(i)=precip(i)+precip(i-3)+precip(i-2)+precip(i-1)+precip(i+1)+precip(i+2)+precip(i+3);
end
count=0;
for j=1981:2013 %1980:2014
        [x, xx]=find(year==j & month == 10 & day == 1);
        [y, yy]=find(year==(j+1) & month == 9 & day == 30);
        count=count+1;
        [Prec_7day_max(count,1),Prec_7day_max(count,2)]=max(Prec_7day(1,x:y));
        
end

figure; set(gcf,'color','w');
plot(Prec_WatY_cum); xlim([1 33]);
title('Cumulative Precipitation');xticks([5 10 15 20 25 30]);
xticklabels({'1985','1990','1995','2000','2005','2010'});

figure; set(gcf,'color','w');
plot(Temp_WatY_aver); xlim([1 33]);
title('Average Temperature');xticks([5 10 15 20 25 30]);
xticklabels({'1985','1990','1995','2000','2005','2010'});

figure; set(gcf,'color','w');
plot(Prec_7day_max(:,1)); title('7day max precipitation'); xlim([1 33]);
xticks([5 10 15 20 25 30]);
xticklabels({'1985','1990','1995','2000','2005','2010'});


% figure; set(gcf,'color','w');
% subplot(2,2,1);
% plot(Temp_WatY_aver); title('Temperature average');
% subplot(2,2,2);
% boxplot(Temp_WatY'); title ('Temperature values');
% subplot(2,2,3);
% plot(Prec_WatY_cum); title('Precipitation cumulative');
% subplot(2,2,4);
% boxplot(Prec_WatY'); title ('Precipitation values');

