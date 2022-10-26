%Ruta Basijokaite

clear all; 
global Data

my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

Prec_WatY_cum=zeros(33,5); %annual P data in all sites
Temp_WatY_aver=zeros(33,5);
Q_dry=zeros(365,5);
Q_wet=zeros(365,5);
da=0;
for i=1:5
    switch i
        case 1
            load Data_MFEel.mat;
            dataset = Data_MFEel;
            year = dataset(:,1);
            month = dataset(:,2);
            day = dataset(:,3);
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load mfeel_Streamflow.mat;
            %load mfeel_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat; 
            %load mfeel_sens_yr_run5000_snow_Newrun1.mat;
        case 2
            load Data_Redwood.mat;
            dataset = Data_Redwood;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load redwood_Streamflow.mat;
            %load redwood_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load redwood_sens_yr_run5000_snow_Newrun1.mat;
        case 3
            load Data_Deer.mat;
            dataset = Data_Deer;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load deer_Streamflow.mat;
            %load deer_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load deer_sens_yr_run5000_snow_Newrun1.mat;
        case 4
            load Data_Bear_Lake.mat;
            dataset = Data_Bear_Lake;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load bear_Streamflow.mat;
            %load bear_lake_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load bear_lake_sens_yr_run5000_snow_Newrun1.mat;
        case 5
            load Data_DelPuerto.mat;
            dataset = Data_DelPuerto;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load delpuerto_Streamflow.mat;
            %load del_puerto_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load del_puerto_sens_yr_run5000_snow_Newrun1.mat;
    end
    
    for j=1981:2013 %1980:2014
        [x, ~]=find(year==j & month == 10 & day == 1);
        [y, ~]=find(year==(j+1) & month == 9 & day == 30);
        da=da+1;
        Prec_WatY_cum(da,i)=sum(precip(x:y,1));
        Temp_WatY_aver(da,i)=mean(tempaver(x:y,1));
        if j==1990
            Q_dry(:,i)=Streamflow(x:y);
        elseif j==1994
            Q_wet(:,i)=Streamflow(x:y);
        end
    end
    da=0;
end

%precipitation comp
figure; set(gcf,'color','w'); 
for i=1:5
    plot(1:33,Prec_WatY_cum(:,i));hold on;
end
legend('MF Eel','Redwood','Deer','Bear','Del Puerto','Location','northeastoutside');legend('boxoff');
ylabel('Cumulative Annual Precipitation (mm)');xlim([1 33]);%grid;
xticks([4 9 14 19 24 29]);
xticklabels({'1985','1990','1995','2000','2005','2010'});

%dry year comp
figure; set(gcf,'color','w'); 
for i=1:5
    plot(1:365,Q_dry(:,i));hold on;
end
legend('MF Eel','Redwood','Deer','Bear','Del Puerto','Location','northeastoutside');legend('boxoff');
ylabel('Daily Streamflow (mm/day)');xlim([1 365]);ylim([0 80]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

%wet year comp
figure; set(gcf,'color','w'); 
for i=1:5
    plot(1:365,Q_wet(:,i));hold on;
end
legend('MF Eel','Redwood','Deer','Bear','Del Puerto','Location','northeastoutside');legend('boxoff');
ylabel('Daily Streamflow (mm/day)');xlim([1 365]);%grid;
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
