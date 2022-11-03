%Ruta Basijokaite

%SFDCE time series
clear all; 
global Data

my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

%define varaibe that can be used for confidence interval
Si_Ks=zeros(33,21);
STi_Ks=zeros(33,21);
KGE_STi_DDF=zeros(33,21);
KGE_STi_TT=zeros(33,21);
KGE_STi_Kf=zeros(33,21);
KGE_STi_TM=zeros(33,21);
Prec_WatY_cum=zeros(33,21); %annual P data in all sites
Temp_WatY_aver=zeros(33,21);
da=0;
for i=1:21
    switch i
        case 1
            load Data_NFCache.mat;
            dataset = Data_NFCache;
            year = dataset(:,1);
            month = dataset(:,2);
            day = dataset(:,3);
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load NFCache_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat; %SFDCE values
            load NFCache_sens_yr_run5000_snow_Newrun1.mat; %KGE values
        case 2
            load Data_Noyo.mat;
            dataset = Data_Noyo;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load noyo_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat; 
            load noyo_sens_yr_run5000_snow_Newrun1.mat;
        case 3
            load Data_MFEel.mat;
            dataset = Data_MFEel;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load mfeel_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat; 
            load mfeel_sens_yr_run5000_snow_Newrun1.mat;
        case 4 
            load Data_Salmon.mat;
            dataset = Data_Salmon;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load salmon_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            load salmon_sens_yr_run5000_snow_Newrun1.mat;
        case 5
            load Data_SFTrinity.mat;
            dataset = Data_SFTrinity;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load SFTrinity_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            load SFTrinity_sens_yr_run5000_snow_Newrun1.mat;
        case 6 
            load Data_Bull.mat;
            dataset = Data_Bull;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load bull_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            load bull_sens_yr_run5000_snow_Newrun1.mat;
        case 7
            load Data_Little.mat;
            dataset = Data_Little;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load little_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            load little_sens_yr_run5000_snow_Newrun1.mat;
        case 8
            load Data_VanDuzen.mat;
            dataset = Data_VanDuzen;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load VanDuzen_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            load VanDuzen_sens_yr_run5000_snow_Newrun1.mat;
        case 9
            load Data_Redwood.mat;
            dataset = Data_Redwood;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load redwood_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            load redwood_sens_yr_run5000_snow_Newrun1.mat;
        case 10
            load Data_Smith.mat;
            dataset = Data_Smith;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load smith_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            load smith_sens_yr_run5000_snow_Newrun1.mat;
        case 11
            load Data_Mill.mat;
            dataset = Data_Mill;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load mill_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            load mill_sens_yr_run5000_snow_Newrun1.mat;
        case 12
            load Data_Trinity_R.mat;
            dataset = Data_Trinity_R;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load trinity_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            load trinity_sens_yr_run5000_snow_Newrun1.mat;
        case 13
            load Data_Deer.mat;
            dataset = Data_Deer;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load deer_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            load deer_sens_yr_run5000_snow_Newrun1.mat;
        case 14
            load Data_Pitman.mat;
            dataset = Data_Pitman;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load pitman_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            load pitman_sens_yr_run5000_snow_Newrun1.mat;
        case 15
            load Data_Bear_Lake.mat;
            dataset = Data_Bear_Lake;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load bear_lake_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            load bear_lake_sens_yr_run5000_snow_Newrun1.mat;
        case 16
            load Data_Merced_Happy.mat;
            dataset = Data_Merced_Happy;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load merced_happy_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            load merced_happy_sens_yr_run5000_snow_Newrun1.mat;
        case 17
            load Data_Merced_Pohono.mat;
            dataset = Data_Merced_Pohono;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load merced_pohono_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            load merced_pohono_sens_yr_run5000_snow_Newrun1.mat;
        case 18
            load Data_Lopez.mat;
            dataset = Data_Lopez;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load lopez_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            load lopez_sens_yr_run5000_snow_Newrun1.mat;
        case 19
            load Data_Pescadero.mat;
            dataset = Data_Pescadero;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load pescadero_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            load pescadero_sens_yr_run5000_snow_Newrun1.mat;
        case 20
            load Data_BigSur.mat;
            dataset = Data_BigSur;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load big_sur_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            load big_sur_sens_yr_run5000_snow_Newrun1.mat;
        case 21
            load Data_DelPuerto.mat;
            dataset = Data_DelPuerto;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load del_puerto_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            load del_puerto_sens_yr_run5000_snow_Newrun1.mat;
    end
    
    for j=1981:2013 %1980:2014
        [x, ~]=find(year==j & month == 10 & day == 1);
        [y, ~]=find(year==(j+1) & month == 9 & day == 30);
        da=da+1;
        Prec_WatY_cum(da,i)=sum(precip(x:y,1));
        Temp_WatY_aver(da,i)=mean(tempaver(x:y,1));
    end
    da=0;
    Si_Ks(:,i)=SFDCE_low_yearSi(:,2);
    STi_Ks(:,i)=SFDCE_low_yearSTi(:,2);
    KGE_STi_DDF(:,i)=KGEyearSTi(:,6);
    KGE_STi_TT(:,i)=KGEyearSTi(:,7);
    KGE_STi_Kf(:,i)=KGEyearSTi(:,8);
    KGE_STi_TM(:,i)=KGEyearSTi(:,9);
end

figure; set(gcf,'color','w'); 
subplot(2,2,1);boxplot(KGE_STi_DDF(:,[14 17 16 15]));ylim([0 1]);
title('DDF STi');xticks([1 2 3 4]);
xticklabels({'Pitman','M Pohono','M Happy','Bear'});
subplot(2,2,2);boxplot(KGE_STi_TT(:,[14 17 16 15]));ylim([0 1]);
title('TT STi');xticks([1 2 3 4]);
xticklabels({'Pitman','M Pohono','M Happy','Bear'});
subplot(2,2,3);boxplot(KGE_STi_Kf(:,[14 17 16 15]));ylim([0 1]);
title('Kf STi');xticks([1 2 3 4]);
xticklabels({'Pitman','M Pohono','M Happy','Bear'});
subplot(2,2,4);boxplot(KGE_STi_TM(:,[14 17 16 15]));ylim([0 1]);
title('TM STi');xticks([1 2 3 4]);
xticklabels({'Pitman','M Pohono','M Happy','Bear'});

figure; set(gcf,'color','w'); sz=25;
scatter(KGE_STi_Kf(:,14),Temp_WatY_aver(:,14),sz,'filled','r');hold on;
p=polyfit(KGE_STi_Kf(:,14),Temp_WatY_aver(:,14),1);
y1=[p(2),(p(1)*0.8+p(2))];line2(1,1)=p(1);line2(1,2)=p(2);
scatter(KGE_STi_Kf(:,15),Temp_WatY_aver(:,15),sz,'filled','g');hold on;
p=polyfit(KGE_STi_Kf(:,15),Temp_WatY_aver(:,15),1);
y2=[p(2),(p(1)*0.8+p(2))];line2(2,1)=p(1);line2(2,2)=p(2);
scatter(KGE_STi_Kf(:,16),Temp_WatY_aver(:,16),sz,'filled','b');hold on;
p=polyfit(KGE_STi_Kf(:,16),Temp_WatY_aver(:,16),1);
y3=[p(2),(p(1)*0.8+p(2))];line2(3,1)=p(1);line2(3,2)=p(2);
scatter(KGE_STi_Kf(:,17),Temp_WatY_aver(:,17),sz,'filled','m');hold on;
p=polyfit(KGE_STi_Kf(:,17),Temp_WatY_aver(:,17),1);
y4=[p(2),(p(1)*0.8+p(2))];line2(4,1)=p(1);line2(4,2)=p(2);
plot([0 0.8],y1,'--r');hold on;
plot([0 0.8],y2,'--g');hold on;
plot([0 0.8],y3,'--b');hold on;
plot([0 0.8],y4,'--m');hold on;
legend('Pitman','Bear','M Happy','M Pohono','Location','northeastoutside');legend('boxoff');
ylabel('Mean Annual Temperature (C)');grid;%xlim([]);
xlabel('Kf KGE STi Group 4');

figure; set(gcf,'color','w'); sz=25;
scatter(KGE_STi_DDF(:,14),Temp_WatY_aver(:,14),sz,'filled','r');hold on;
p=polyfit(KGE_STi_DDF(:,14),Temp_WatY_aver(:,14),1);
y1=[p(2),(p(1)*0.8+p(2))];lineAT_DDF(1,1)=p(1);lineAT_DDF(1,2)=p(2);
scatter(KGE_STi_DDF(:,15),Temp_WatY_aver(:,15),sz,'filled','g');hold on;
p=polyfit(KGE_STi_DDF(:,15),Temp_WatY_aver(:,15),1);
y2=[p(2),(p(1)*0.8+p(2))];lineAT_DDF(2,1)=p(1);lineAT_DDF(2,2)=p(2);
scatter(KGE_STi_DDF(:,16),Temp_WatY_aver(:,16),sz,'filled','b');hold on;
p=polyfit(KGE_STi_DDF(:,16),Temp_WatY_aver(:,16),1);
y3=[p(2),(p(1)*0.8+p(2))];lineAT_DDF(3,1)=p(1);lineAT_DDF(3,2)=p(2);
scatter(KGE_STi_DDF(:,17),Temp_WatY_aver(:,17),sz,'filled','m');hold on;
p=polyfit(KGE_STi_DDF(:,17),Temp_WatY_aver(:,17),1);
y4=[p(2),(p(1)*0.8+p(2))];lineAT_DDF(4,1)=p(1);lineAT_DDF(4,2)=p(2);
plot([0 0.8],y1,'--r');hold on;
plot([0 0.8],y2,'--g');hold on;
plot([0 0.8],y3,'--b');hold on;
plot([0 0.8],y4,'--m');hold on;
legend('Pitman','Bear','M Happy','M Pohono','Location','northeastoutside');legend('boxoff');
ylabel('Mean Annual Temperature (C)');grid;
xlabel('DDF KGE STi Group 4');

figure; set(gcf,'color','w'); sz=25;
scatter(KGE_STi_TT(:,14),Temp_WatY_aver(:,14),sz,'filled','r');hold on;
p=polyfit(KGE_STi_TT(:,14),Temp_WatY_aver(:,14),1);
y1=[p(2),(p(1)*0.8+p(2))];lineAT_TT(1,1)=p(1);lineAT_TT(1,2)=p(2);
scatter(KGE_STi_TT(:,15),Temp_WatY_aver(:,15),sz,'filled','g');hold on;
p=polyfit(KGE_STi_TT(:,15),Temp_WatY_aver(:,15),1);
y2=[p(2),(p(1)*0.8+p(2))];lineAT_TT(2,1)=p(1);lineAT_TT(2,2)=p(2);
scatter(KGE_STi_TT(:,16),Temp_WatY_aver(:,16),sz,'filled','b');hold on;
p=polyfit(KGE_STi_TT(:,16),Temp_WatY_aver(:,16),1);
y3=[p(2),(p(1)*0.8+p(2))];lineAT_TT(3,1)=p(1);lineAT_TT(3,2)=p(2);
scatter(KGE_STi_TT(:,17),Temp_WatY_aver(:,17),sz,'filled','m');hold on;
p=polyfit(KGE_STi_TT(:,17),Temp_WatY_aver(:,17),1);
y4=[p(2),(p(1)*0.8+p(2))];lineAT_TT(4,1)=p(1);lineAT_TT(4,2)=p(2);
plot([0 0.8],y1,'--r');hold on;
plot([0 0.8],y2,'--g');hold on;
plot([0 0.8],y3,'--b');hold on;
plot([0 0.8],y4,'--m');hold on;
legend('Pitman','Bear','M Happy','M Pohono','Location','northeastoutside');legend('boxoff');
ylabel('Mean Annual Temperature (C)');grid;
xlabel('TT KGE STi Group 4'); xlim([-0.2 0.6]);

figure; set(gcf,'color','w'); sz=25;
scatter(KGE_STi_TM(:,14),Temp_WatY_aver(:,14),sz,'filled','r');hold on;
p=polyfit(KGE_STi_TM(:,14),Temp_WatY_aver(:,14),1);
y1=[p(2),(p(1)*0.8+p(2))];lineAT_TM(1,1)=p(1);lineAT_TM(1,2)=p(2);
scatter(KGE_STi_TM(:,15),Temp_WatY_aver(:,15),sz,'filled','g');hold on;
p=polyfit(KGE_STi_TM(:,15),Temp_WatY_aver(:,15),1);
y2=[p(2),(p(1)*0.8+p(2))];lineAT_TM(2,1)=p(1);lineAT_TM(2,2)=p(2);
scatter(KGE_STi_TM(:,16),Temp_WatY_aver(:,16),sz,'filled','b');hold on;
p=polyfit(KGE_STi_TM(:,16),Temp_WatY_aver(:,16),1);
y3=[p(2),(p(1)*0.8+p(2))];lineAT_TM(3,1)=p(1);lineAT_TM(3,2)=p(2);
scatter(KGE_STi_TM(:,17),Temp_WatY_aver(:,17),sz,'filled','m');hold on;
p=polyfit(KGE_STi_TM(:,17),Temp_WatY_aver(:,17),1);
y4=[p(2),(p(1)*0.8+p(2))];lineAT_TM(4,1)=p(1);lineAT_TM(4,2)=p(2);
plot([0 0.8],y1,'--r');hold on;
plot([0 0.8],y2,'--g');hold on;
plot([0 0.8],y3,'--b');hold on;
plot([0 0.8],y4,'--m');hold on;
legend('Pitman','Bear','M Happy','M Pohono','Location','northeastoutside');legend('boxoff');
ylabel('Mean Annual Temperature (C)');grid;
xlabel('TM KGE STi Group 4'); xlim([0 0.6]);

figure; set(gcf,'color','w'); sz=25;
scatter(KGE_STi_Kf(:,14),Prec_WatY_cum(:,14),sz,'filled','r');hold on;
p=polyfit(KGE_STi_Kf(:,14),Prec_WatY_cum(:,14),1);
y1=[p(2),(p(1)*0.8+p(2))];line(1,1)=p(1);line(1,2)=p(2);
scatter(KGE_STi_Kf(:,15),Prec_WatY_cum(:,15),sz,'filled','g');hold on;
p=polyfit(KGE_STi_Kf(:,15),Prec_WatY_cum(:,15),1);
y2=[p(2),(p(1)*0.8+p(2))];line(2,1)=p(1);line(2,2)=p(2);
scatter(KGE_STi_Kf(:,16),Prec_WatY_cum(:,16),sz,'filled','b');hold on;
p=polyfit(KGE_STi_Kf(:,16),Prec_WatY_cum(:,16),1);
y3=[p(2),(p(1)*0.8+p(2))];line(3,1)=p(1);line(3,2)=p(2);
scatter(KGE_STi_Kf(:,17),Prec_WatY_cum(:,17),sz,'filled','m');hold on;
p=polyfit(KGE_STi_Kf(:,17),Prec_WatY_cum(:,17),1);
y4=[p(2),(p(1)*0.8+p(2))];line(4,1)=p(1);line(4,2)=p(2);
plot([0 0.8],y1,'--r');hold on;
plot([0 0.8],y2,'--g');hold on;
plot([0 0.8],y3,'--b');hold on;
plot([0 0.8],y4,'--m');hold on;
legend('Pitman','Bear','M Happy','M Pohono','Location','northeastoutside');legend('boxoff');
ylabel('Cumulative Annual Precipitation (mm)');grid;
xlabel('Kf KGE STi Group 4');ylim([400 2000]);

figure; set(gcf,'color','w'); sz=25;
for i=14:17
    scatter(KGE_STi_DDF(:,i),Prec_WatY_cum(:,i),sz,'filled');hold on;
end
legend('Pitman','Bear','M Happy','M Pohono','Location','northeastoutside');legend('boxoff');
ylabel('Cumulative Annual Precipitation (mm)');grid;
xlabel('DDF KGE STi Group 4');

figure; set(gcf,'color','w'); sz=25;
for i=14:17
    scatter(KGE_STi_TT(:,i),Prec_WatY_cum(:,i),sz,'filled');hold on;
end
legend('Pitman','Bear','M Happy','M Pohono','Location','northeastoutside');legend('boxoff');
ylabel('Cumulative Annual Precipitation (mm)');grid;
xlabel('TT KGE STi Group 4');

% figure; set(gcf,'color','w'); sz=25;
% for i=14:17
%     scatter(KGE_STi_Kf(:,i),Prec_WatY_cum(:,i),sz,'filled');hold on;
% end
% legend('Pitman','Bear','M Happy','M Pohono','Location','northeastoutside');legend('boxoff');
% ylabel('Cumulative Annual Precipitation (mm)');grid;
% xlabel('Kf KGE STi Group 4');

figure; set(gcf,'color','w'); sz=25;
for i=14:17
    scatter(KGE_STi_TM(:,i),Prec_WatY_cum(:,i),sz,'filled');hold on;
end
legend('Pitman','Bear','M Happy','M Pohono','Location','northeastoutside');legend('boxoff');
ylabel('Cumulative Annual Precipitation (mm)');grid;
xlabel('TM KGE STi Group 4');

figure; set(gcf,'color','w');
% for i=1:21
%     plot(1:33,Si_Ks(:,i));hold on;
% end
str = '#FF7F00';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
for i=1:5
    plot(1:33,Si_Ks(:,i),'Color',color,'LineWidth',1);hold on;
end
str = '#4DAF4A';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
for i=6:10
    plot(1:33,Si_Ks(:,i),'Color',color,'LineWidth',1);hold on;
end
str = '#984EA3';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
for i=11:13
    plot(1:33,Si_Ks(:,i),'Color',color,'LineWidth',1);hold on;
end
str = '#377EB8';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
for i=14:17
    plot(1:33,Si_Ks(:,i),'Color',color,'LineWidth',1);hold on;
end
str = '#E41A1C';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
for i=18:21
    plot(1:33,Si_Ks(:,i),'Color',color,'LineWidth',1);hold on;
end
title('SFDCE Si tru time');
legend('NF Cache','Noyo','MF Eel','Salmon','SF Trinity','Bull','Little','Van Duzen','Redwood','Smith','Mill','Trinity','Deer',...
    'Pitman','Bear','M Happy','M Pohono','Lopez','Pescadero','Big Sur','Del Puerto','Location','northeastoutside');
legend('boxoff');
ylabel('SFDCE Si');xlim([1 33]);ylim([0 1]);
xticks([4 9 14 19 24 29]);
xticklabels({'1985','1990','1995','2000','2005','2010'});

figure; set(gcf,'color','w');
str = '#FF7F00';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
for i=1:5
    plot(1:33,STi_Ks(:,i),'Color',color,'LineWidth',1);hold on;
end
str = '#4DAF4A';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
for i=6:10
    plot(1:33,STi_Ks(:,i),'Color',color,'LineWidth',1);hold on;
end
str = '#984EA3';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
for i=11:13
    plot(1:33,STi_Ks(:,i),'Color',color,'LineWidth',1);hold on;
end
str = '#377EB8';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
for i=14:17
    plot(1:33,STi_Ks(:,i),'Color',color,'LineWidth',1);hold on;
end
str = '#E41A1C';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
for i=18:21
    plot(1:33,STi_Ks(:,i),'Color',color,'LineWidth',1);hold on;
end
title('SFDCE STi tru time');
legend('NF Cache','Noyo','MF Eel','Salmon','SF Trinity','Bull','Little','Van Duzen','Redwood','Smith','Mill','Trinity','Deer',...
    'Pitman','Bear','M Happy','M Pohono','Lopez','Pescadero','Big Sur','Del Puerto','Location','northeastoutside');
legend('boxoff');
ylabel('SFDCE STi');xlim([1 33]);ylim([0 1]);
xticks([4 9 14 19 24 29]);
xticklabels({'1985','1990','1995','2000','2005','2010'});

figure; set(gcf,'color','w'); sz=25;%group1 
for i=1:5
    scatter(STi_Ks(:,i),Prec_WatY_cum(:,i),sz,'filled');hold on;
end
legend('NF Cache','Noyo','MF Eel','Salmon','SF Trinity','Location','northeastoutside');legend('boxoff');
ylabel('Cumulative Annual Precipitation (mm)');grid;
xlabel('Ks SFDCE STi Group 1');

figure; set(gcf,'color','w'); sz=25;%group1 
for i=6:10
    scatter(STi_Ks(:,i),Prec_WatY_cum(:,i),sz,'filled');hold on;
end
legend('Bull','Little','Van Duzen','Redwood','Smith','Location','northeastoutside');legend('boxoff');
ylabel('Cumulative Annual Precipitation (mm)');grid;
xlabel('Ks SFDCE STi Group 2');

figure; set(gcf,'color','w'); sz=25;%group1 
for i=11:13
    scatter(STi_Ks(:,i),Prec_WatY_cum(:,i),sz,'filled');hold on;
end
legend('Mill','Trinity','Deer','Location','northeastoutside');legend('boxoff');
ylabel('Cumulative Annual Precipitation (mm)');grid;
xlabel('Ks SFDCE STi Group 3');

figure; set(gcf,'color','w'); sz=25;%group1 
for i=14:17
    scatter(STi_Ks(:,i),Prec_WatY_cum(:,i),sz,'filled');hold on;
end
legend('Pitman','Bear','M Happy','M Pohono','Location','northeastoutside');legend('boxoff');
ylabel('Cumulative Annual Precipitation (mm)');grid;
xlabel('Ks SFDCE STi Group 4');

figure; set(gcf,'color','w'); sz=25;%group1 
for i=18:21
    scatter(STi_Ks(:,i),Prec_WatY_cum(:,i),sz,'filled');hold on;
end
legend('Lopez','Pescadero','Big Sur','Del Puerto','Location','northeastoutside');legend('boxoff');
ylabel('Cumulative Annual Precipitation (mm)');grid;
xlabel('Ks SFDCE STi Group 5');
