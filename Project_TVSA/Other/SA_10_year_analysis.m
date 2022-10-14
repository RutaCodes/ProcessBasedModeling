clear all; 
global Data

my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

% figure; set(gcf,'color','w');
% subplot(1,5,1);
% load big_sur_sub_sens_yr_run5000_snow_test1s.mat;
% imagesc(KGEyearSTi);hold on;
% title('BSU');colormap(flipud(gray));caxis([0 1]);
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
% % yticks([2 3 4 5 6 7 8 9]);
% % yticklabels({'2006','2007','2008','2009','2010','2011','2012','2013'});
% yticks([4 9 14 19 24 29]);
% yticklabels({'1985','1990','1995','2000','2005','2010'});
% subplot(1,5,2);
% load sf_trinity_sub_sens_yr_run5000_snow_test1s.mat;
% imagesc(KGEyearSTi);hold on;
% title('SFT');colormap(flipud(gray));caxis([0 1]);
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
% yticks([4 9 14 19 24 29]);
% yticklabels({'1985','1990','1995','2000','2005','2010'});
% subplot(1,5,3);
% load redwood_sub_sens_yr_run5000_snow_test1s.mat;
% imagesc(KGEyearSTi);hold on;
% title('RED');colormap(flipud(gray));caxis([0 1]);
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
% yticks([4 9 14 19 24 29]);
% yticklabels({'1985','1990','1995','2000','2005','2010'});
% subplot(1,5,4);
% load trinity_sub_sens_yr_run5000_snow_test1s.mat;
% imagesc(KGEyearSTi);hold on;
% title('TRI');colormap(flipud(gray));caxis([0 1]);
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
% yticks([4 9 14 19 24 29]);
% yticklabels({'1985','1990','1995','2000','2005','2010'});
% subplot(1,5,5);
% load pitman_sub_sens_yr_run5000_snow_test1s.mat;
% imagesc(KGEyearSTi);hold on;
% title('PIT');colormap(flipud(gray));caxis([0 1]);%colorbar;
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
% yticks([4 9 14 19 24 29]);
% yticklabels({'1985','1990','1995','2000','2005','2010'});
% 
% figure; set(gcf,'color','w');
% subplot(1,5,1);
% load big_sur_sub_sens_yr_run5000_snow_test1s.mat;
% imagesc(KGEyearSTi(24:33,:));hold on;
% title('BSU');colormap(flipud(gray));caxis([0 1]);
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
% yticks([1 2 3 4 5 6 7 8 9 10]);
% yticklabels({'2005','2006','2007','2008','2009','2010','2011','2012','2013','2014'});
% subplot(1,5,2);
% load sf_trinity_sub_sens_yr_run5000_snow_test1s.mat;
% imagesc(KGEyearSTi(24:33,:));hold on;
% title('SFT');colormap(flipud(gray));caxis([0 1]);
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
% yticks([1 2 3 4 5 6 7 8 9 10]);
% yticklabels({'2005','2006','2007','2008','2009','2010','2011','2012','2013','2014'});
% subplot(1,5,3);
% load redwood_sub_sens_yr_run5000_snow_test1s.mat;
% imagesc(KGEyearSTi(24:33,:));hold on;
% title('RED');colormap(flipud(gray));caxis([0 1]);
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
% yticks([1 2 3 4 5 6 7 8 9 10]);
% yticklabels({'2005','2006','2007','2008','2009','2010','2011','2012','2013','2014'});
% subplot(1,5,4);
% load trinity_sub_sens_yr_run5000_snow_test1s.mat;
% imagesc(KGEyearSTi(24:33,:));hold on;
% title('TRI');colormap(flipud(gray));caxis([0 1]);
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
% yticks([1 2 3 4 5 6 7 8 9 10]);
% yticklabels({'2005','2006','2007','2008','2009','2010','2011','2012','2013','2014'});
% subplot(1,5,5);
% load pitman_sub_sens_yr_run5000_snow_test1s.mat;
% imagesc(KGEyearSTi(24:33,:));hold on;
% title('PIT');colormap(flipud(gray));caxis([0 1]);%colorbar;
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
% yticks([1 2 3 4 5 6 7 8 9 10]);
% yticklabels({'2005','2006','2007','2008','2009','2010','2011','2012','2013','2014'});

%RMSE analysis
color=zeros(5,1);
str = '#a6cee3';
color(1,1:3) = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
str = '#1f78b4';
color(2,1:3) = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
str = '#b2df8a';
color(3,1:3) = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
str = '#33a02c';
color(4,1:3) = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
str = '#fb9a99';
color(5,1:3) = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
str = '#e31a1c';
color(6,1:3) = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
str = '#fdbf6f';
color(7,1:3) = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
str = '#ff7f00';
color(8,1:3) = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
str = '#cab2d6';
color(9,1:3) = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
str = '#6a3d9a';
color(10,1:3) = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;

%monthly vs weekly
figure; set(gcf,'color','w');
load redwood_sub_sens_mo_run5000_snow_test1s.mat;
N1=length(RSME_moSTi);
for i=1:10
    plot(RSME_moSTi(((N1-335):N1),i),'Color',color(i,:),'LineWidth',1.5);hold on;
end
title('Monthly RMSE');
%legend({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'},'Location','northeastoutside');
%legend('boxoff'); 
xlim([1 335]);ylim([0 1]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

figure; set(gcf,'color','w');
load redwood_sub_sens_mo_run5000_snow_test1s.mat;
N2=length(RSME_weSTi);
%plot(RSME_weSTi(((N2-358):N2),:));hold on;
for i=1:10
    plot(RSME_weSTi(((N2-335):N2),i),'Color',color(i,:),'LineWidth',1.5);hold on;
end
title('Weekly RMSE');xlim([1 335]);ylim([0 1]);
%legend({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

figure; set(gcf,'color','w');
load redwood_Streamflow.mat
load Data_Redwood.mat;
dataset = Data_Redwood(275:12692,:);
year = dataset(:,1);
month = dataset(:,2);
day = dataset(:,3);
[a, ~]=find(year==2013 & month == 10 & day == 1);
[b, ~]=find(year==2014 & month == 9 & day == 30);
str = '#377EB8';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
plot(Streamflow(a:b),'Color',color,'LineWidth',1.5);xlim([1 335]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

% load big_sur_sub_sens_mo_run5000_snow_test1s.mat;
% load sf_trinity_sub_sens_mo_run5000_snow_test1s.mat;
% load redwood_sub_sens_mo_run5000_snow_test1s.mat;
% load trinity_sub_sens_mo_run5000_snow_test1s.mat;
% load pitman_sub_sens_mo_run5000_snow_test1s.mat;

%Figure comparing Ks STi values
Wet_year_RMSE=zeros(335,5);
Dry_year_RMSE=zeros(335,5);
figure; set(gcf,'color','w');
subplot(5,1,1); %BSU
load big_sur_sub_sens_mo_run5000_snow_test1s.mat;
plot(RSME_moSTi((336:671),2),'b');hold on;%wet year
Wet_year_RMSE(1:335,1)=RSME_moSTi(336:670,2);
plot(RSME_moSTi(((N1-335):N1),2),'r');hold on;%dry year
Dry_year_RMSE(1:335,1)=RSME_moSTi((N1-334):N1,2);
xlim([1 335]);ylim([0 1]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
legend('Wet year', 'Dry year','Location','southeast'); legend('boxoff');
ylabel('BSU');title('STi');
subplot(5,1,2); %SFT
load sf_trinity_sub_sens_mo_run5000_snow_test1s.mat;
plot(RSME_moSTi((336:671),2),'b');hold on;%wet year
Wet_year_RMSE(1:335,2)=RSME_moSTi(336:670,2);
plot(RSME_moSTi(((N1-335):N1),2),'r');hold on;%dry year
Dry_year_RMSE(1:335,2)=RSME_moSTi((N1-334):N1,2);
xlim([1 335]);ylim([0 1]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
ylabel('SFT');
subplot(5,1,3); %RED
load redwood_sub_sens_mo_run5000_snow_test1s.mat;
plot(RSME_moSTi((336:671),2),'b');hold on;%wet year
Wet_year_RMSE(1:335,3)=RSME_moSTi(336:670,2);
plot(RSME_moSTi(((N1-335):N1),2),'r');hold on;%dry year
Dry_year_RMSE(1:335,3)=RSME_moSTi((N1-334):N1,2);
xlim([1 335]);ylim([0 1]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
ylabel('RED');
%legend('Wet year', 'Dry year','Location','northeastoutside'); legend('boxoff');
subplot(5,1,4); %TRI
load trinity_sub_sens_mo_run5000_snow_test1s.mat;
plot(RSME_moSTi((336:671),2),'b');hold on;%wet year
Wet_year_RMSE(1:335,4)=RSME_moSTi(336:670,2);
plot(RSME_moSTi(((N1-335):N1),2),'r');hold on;%dry year
Dry_year_RMSE(1:335,4)=RSME_moSTi((N1-334):N1,2);
xlim([1 335]);ylim([0 1]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
ylabel('TRI');
subplot(5,1,5);%PIT
load pitman_sub_sens_mo_run5000_snow_test1s.mat;
plot(RSME_moSTi((336:671),2),'b');hold on;%wet year
Wet_year_RMSE(1:335,5)=RSME_moSTi(336:670,2);
plot(RSME_moSTi(((N1-335):N1),2),'r');hold on;%dry year
Dry_year_RMSE(1:335,5)=RSME_moSTi((N1-334):N1,2);
xlim([1 335]);ylim([0 1]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
ylabel('PIT');
