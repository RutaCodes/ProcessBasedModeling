clear all;

my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

%boxlots of all parameters KGE & SFDCE x2 models

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Old model

load bear_lake_sens_yr_run5000_snow_old.mat %KGE old
load bear_lake_sens_yr_hyd_run5000_snow_old.mat %SFDCE low old model
KGE_allWS=zeros(33,10,5);
SFDCE_allWS=zeros(33,10,5);
KGE_allWS(:,:,1)=KGEyearSTi;
SFDCE_allWS(:,:,1)=SFDCE_low_yearSTi;

load blackwood_sens_yr_run5000_snow_old.mat %KGE old
load blackwood_sens_yr_hyd_run5000_snow_old.mat %SFDCE low old model
KGE_allWS(:,:,2)=KGEyearSTi;
SFDCE_allWS(:,:,2)=SFDCE_low_yearSTi;

load merced_happy_sens_yr_run5000_snow_old.mat %KGE old
load merced_happy_sens_yr_hyd_run5000_snow_old.mat %SFDCE low old model
KGE_allWS(:,:,3)=KGEyearSTi;
SFDCE_allWS(:,:,3)=SFDCE_low_yearSTi;

load merced_pohono_sens_yr_run5000_snow_old.mat %KGE old
load merced_pohono_sens_yr_hyd_run5000_snow_old.mat %SFDCE low old model
KGE_allWS(:,:,4)=KGEyearSTi;
SFDCE_allWS(:,:,4)=SFDCE_low_yearSTi;

load trinity_sens_yr_run5000_snow_old.mat %KGE old
load trinity_sens_yr_hyd_run5000_snow_old.mat %SFDCE low old model
KGE_allWS(:,:,5)=KGEyearSTi;
SFDCE_allWS(:,:,5)=SFDCE_low_yearSTi;
% 
% figure; set(gcf,'color','w');
% subplot (5, 2, 1);
% imagesc(KGE_allWS(:,:,1)); %ylim([0 1]);
% title('KGE');colorbar;caxis([0 1]);
% ylabel('Bear');
% xticks([1 2 3 4 5 6 7 8 9 10]);
% %xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
% subplot (5, 2, 2);
% imagesc(SFDCE_allWS(:,:,1)); %ylim([0 1]);
% title('SFDCE low');colorbar;caxis([0 1]);
% ylabel('Bear');
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
% subplot (5, 2, 3);
% imagesc(KGE_allWS(:,:,2)); %ylim([0 1]);
% colorbar;caxis([0 1]);
% ylabel('Blackwood');
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
% subplot (5, 2, 4);
% imagesc(SFDCE_allWS(:,:,2)); %ylim([0 1]);
% colorbar;caxis([0 1]);
% ylabel('Blackwood');
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
% subplot (5, 2, 5);
% imagesc(KGE_allWS(:,:,3)); %ylim([0 1]);
% colorbar;caxis([0 1]);
% ylabel('Merced Happy');
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
% subplot (5, 2, 6);
% imagesc(SFDCE_allWS(:,:,3)); %ylim([0 1]);
% colorbar;caxis([0 1]);
% ylabel('Merced Happy');
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
% subplot (5, 2, 7);
% imagesc(KGE_allWS(:,:,4)); %ylim([0 1]);
% colorbar;caxis([0 1]);
% ylabel('Merced Pohono');
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
% subplot (5, 2, 8);
% imagesc(SFDCE_allWS(:,:,4)); %ylim([0 1]);
% colorbar;caxis([0 1]);
% ylabel('Merced Pohono');
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
% subplot (5, 2, 9);
% imagesc(KGE_allWS(:,:,5)); %ylim([0 1]);
% colorbar;caxis([0 1]);
% ylabel('Trinity');
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
% subplot (5, 2, 10);
% imagesc(SFDCE_allWS(:,:,5)); %ylim([0 1]);
% colorbar;caxis([0 1]);
% ylabel('Trinity');
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
% 
figure; set(gcf,'color','w');
subplot (5, 2, 1);
boxplot(KGE_allWS(:,:,1)); ylim([0 1]);
title('KGE');%colorbar;caxis([0 1]);
ylabel('Bear');
xticks([1 2 3 4 5 6 7 8 9 10]);
%xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
subplot (5, 2, 2);
boxplot(SFDCE_allWS(:,:,1)); ylim([0 1]);
title('SFDCE low');%colorbar;caxis([0 1]);
ylabel('Bear');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
subplot (5, 2, 3);
boxplot(KGE_allWS(:,:,2)); ylim([0 1]);
ylabel('Blackwood');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
subplot (5, 2, 4);
boxplot(SFDCE_allWS(:,:,2)); ylim([0 1]);
ylabel('Blackwood');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
subplot (5, 2, 5);
boxplot(KGE_allWS(:,:,3)); ylim([0 1]);
ylabel('Merced Happy');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
subplot (5, 2, 6);
boxplot(SFDCE_allWS(:,:,3)); ylim([0 1]);
ylabel('Merced Happy');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
subplot (5, 2, 7);
boxplot(KGE_allWS(:,:,4)); ylim([0 1]);
ylabel('Merced Pohono');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
subplot (5, 2, 8);
boxplot(SFDCE_allWS(:,:,4)); ylim([0 1]);
ylabel('Merced Pohono');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
subplot (5, 2, 9);
boxplot(KGE_allWS(:,:,5)); ylim([0 1]);
ylabel('Trinity');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
subplot (5, 2, 10);
boxplot(SFDCE_allWS(:,:,5)); ylim([0 1]);
ylabel('Trinity');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%new snow routine 
load bear_lake_sens_yr_run5000_snow2.mat %KGE new
load bear_lake_sens_yr_hyd_run5000_snow2.mat %SFDCE low old model
KGE_allWS=zeros(33,10,5);
SFDCE_allWS=zeros(33,10,5);
KGE_allWS(:,:,1)=KGEyearSTi;
SFDCE_allWS(:,:,1)=SFDCE_low_yearSTi;

load blackwood_sens_yr_run5000_snow2.mat %KGE old
load blackwood_sens_yr_hyd_run5000_snow2.mat %SFDCE low old model
KGE_allWS(:,:,2)=KGEyearSTi;
SFDCE_allWS(:,:,2)=SFDCE_low_yearSTi;

load merced_happy_sens_yr_run5000_snow2.mat %KGE old
load merced_happy_sens_yr_hyd_run5000_snow2.mat %SFDCE low old model
KGE_allWS(:,:,3)=KGEyearSTi;
SFDCE_allWS(:,:,3)=SFDCE_low_yearSTi;

load merced_pohono_sens_yr_run6000_snow2.mat %KGE old
load merced_pohono_sens_yr_hyd_run6000_snow2.mat %SFDCE low old model
KGE_allWS(:,:,4)=KGEyearSTi;
SFDCE_allWS(:,:,4)=SFDCE_low_yearSTi;

load trinity_sens_yr_run5000_snow2.mat %KGE old
load trinity_sens_yr_hyd_run5000_snow2.mat %SFDCE low old model
KGE_allWS(:,:,5)=KGEyearSTi;
SFDCE_allWS(:,:,5)=SFDCE_low_yearSTi;

figure; set(gcf,'color','w');
subplot (5, 2, 1);
imagesc(KGE_allWS(:,:,1)); %ylim([0 1]);
title('KGE');colorbar;caxis([0 1]);
ylabel('Bear');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
%xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
subplot (5, 2, 2);
imagesc(SFDCE_allWS(:,:,1)); %ylim([0 1]);
title('SFDCE low');colorbar;caxis([0 1]);
ylabel('Bear');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot (5, 2, 3);
imagesc(KGE_allWS(:,:,2)); %ylim([0 1]);
colorbar;caxis([0 1]);
ylabel('Blackwood');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot (5, 2, 4);
imagesc(SFDCE_allWS(:,:,2)); %ylim([0 1]);
colorbar;caxis([0 1]);
ylabel('Blackwood');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot (5, 2, 5);
imagesc(KGE_allWS(:,:,3)); %ylim([0 1]);
colorbar;caxis([0 1]);
ylabel('Merced Happy');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot (5, 2, 6);
imagesc(SFDCE_allWS(:,:,3)); %ylim([0 1]);
colorbar;caxis([0 1]);
ylabel('Merced Happy');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot (5, 2, 7);
imagesc(KGE_allWS(:,:,4)); %ylim([0 1]);
colorbar;caxis([0 1]);
ylabel('Merced Pohono');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot (5, 2, 8);
imagesc(SFDCE_allWS(:,:,4)); %ylim([0 1]);
colorbar;caxis([0 1]);
ylabel('Merced Pohono');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot (5, 2, 9);
imagesc(KGE_allWS(:,:,5)); %ylim([0 1]);
colorbar;caxis([0 1]);
ylabel('Trinity');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot (5, 2, 10);
imagesc(SFDCE_allWS(:,:,5)); %ylim([0 1]);
colorbar;caxis([0 1]);
ylabel('Trinity');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});

figure; set(gcf,'color','w');
subplot (5, 2, 1);
boxplot(KGE_allWS(:,:,1)); ylim([0 1]);
title('KGE');%colorbar;caxis([0 1]);
ylabel('Bear');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
%xticklabels({'Kq','Ks','Alp','H','B','DDF','TR','TS','TM','SCF'});
subplot (5, 2, 2);
boxplot(SFDCE_allWS(:,:,1)); ylim([0 1]);
title('SFDCE low');%colorbar;caxis([0 1]);
ylabel('Bear');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot (5, 2, 3);
boxplot(KGE_allWS(:,:,2)); ylim([0 1]);
ylabel('Blackwood');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot (5, 2, 4);
boxplot(SFDCE_allWS(:,:,2)); ylim([0 1]);
ylabel('Blackwood');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot (5, 2, 5);
boxplot(KGE_allWS(:,:,3)); ylim([0 1]);
ylabel('Merced Happy');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot (5, 2, 6);
boxplot(SFDCE_allWS(:,:,3)); ylim([0 1]);
ylabel('Merced Happy');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot (5, 2, 7);
boxplot(KGE_allWS(:,:,4)); ylim([0 1]);
ylabel('Merced Pohono');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot (5, 2, 8);
boxplot(SFDCE_allWS(:,:,4)); ylim([0 1]);
ylabel('Merced Pohono');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot (5, 2, 9);
boxplot(KGE_allWS(:,:,5)); ylim([0 1]);
ylabel('Trinity');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot (5, 2, 10);
boxplot(SFDCE_allWS(:,:,5)); ylim([0 1]);
ylabel('Trinity');
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ks_par_old_Si=zeros(33,5);
%Loading all the Si/STi values for plots
load bear_lake_sens_yr_hyd_run5000_snow_old.mat %SFDCE low old model
Ks_par_old_Si(:,1)=SFDCE_low_yearSi(:,2);
load blackwood_sens_yr_hyd_run5000_snow_old.mat
Ks_par_old_Si(:,2)=SFDCE_low_yearSi(:,2);
load merced_happy_sens_yr_hyd_run5000_snow_old.mat 
Ks_par_old_Si(:,3)=SFDCE_low_yearSi(:,2);
load merced_pohono_sens_yr_hyd_run5000_snow_old.mat 
Ks_par_old_Si(:,4)=SFDCE_low_yearSi(:,2);
load trinity_sens_yr_hyd_run5000_snow_old.mat
Ks_par_old_Si(:,5)=SFDCE_low_yearSi(:,2);

Ks_par_old_STi=zeros(33,5);
%Loading all the Si/STi values for plots
load bear_lake_sens_yr_hyd_run5000_snow_old.mat %SFDCE low old model
Ks_par_old_STi(:,1)=SFDCE_low_yearSTi(:,2);
load blackwood_sens_yr_hyd_run5000_snow_old.mat
Ks_par_old_STi(:,2)=SFDCE_low_yearSTi(:,2);
load merced_happy_sens_yr_hyd_run5000_snow_old.mat 
Ks_par_old_STi(:,3)=SFDCE_low_yearSTi(:,2);
load merced_pohono_sens_yr_hyd_run5000_snow_old.mat 
Ks_par_old_STi(:,4)=SFDCE_low_yearSTi(:,2);
load trinity_sens_yr_hyd_run5000_snow_old.mat
Ks_par_old_STi(:,5)=SFDCE_low_yearSTi(:,2);

Ks_par_new_Si=zeros(33,5);
%Loading all the Si/STi values for plots
load bear_lake_sens_yr_hyd_run5000_snow2.mat %SFDCE low old model
Ks_par_new_Si(:,1)=SFDCE_low_yearSi(:,2);
load blackwood_sens_yr_hyd_run5000_snow2.mat
Ks_par_new_Si(:,2)=SFDCE_low_yearSi(:,2);
load merced_happy_sens_yr_hyd_run5000_snow2.mat 
Ks_par_new_Si(:,3)=SFDCE_low_yearSi(:,2);
load merced_pohono_sens_yr_hyd_run6000_snow2.mat 
Ks_par_new_Si(:,4)=SFDCE_low_yearSi(:,2);
load trinity_sens_yr_hyd_run5000_snow2.mat
Ks_par_new_Si(:,5)=SFDCE_low_yearSi(:,2);

Ks_par_new_STi=zeros(33,5);
%Loading all the Si/STi values for plots
load bear_lake_sens_yr_hyd_run5000_snow2.mat %SFDCE low old model
Ks_par_new_STi(:,1)=SFDCE_low_yearSTi(:,2);
load blackwood_sens_yr_hyd_run5000_snow2.mat
Ks_par_new_STi(:,2)=SFDCE_low_yearSTi(:,2);
load merced_happy_sens_yr_hyd_run5000_snow2.mat 
Ks_par_new_STi(:,3)=SFDCE_low_yearSTi(:,2);
load merced_pohono_sens_yr_hyd_run6000_snow2.mat 
Ks_par_new_STi(:,4)=SFDCE_low_yearSTi(:,2);
load trinity_sens_yr_hyd_run5000_snow2.mat
Ks_par_new_STi(:,5)=SFDCE_low_yearSTi(:,2);

figure; set(gcf,'color','w');
subplot (2, 2, 1);
imagesc(Ks_par_old_Si); %ylim([0 1]);
title('SFDCE low Ks old Si');colorbar;caxis([0 1]);
xticks([1 2 3 4 5]);
xticklabels({'Bear','Blackw','Happy','Pohono','Trinity'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});
subplot (2, 2, 2);
imagesc(Ks_par_old_STi); %ylim([0 1]);
title('SFDCE low Ks old STi');colorbar;caxis([0 1]);
xticks([1 2 3 4 5]);
xticklabels({'Bear','Blackw','Happy','Pohono','Trinity'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});
subplot (2, 2, 3);
imagesc(Ks_par_new_Si); %ylim([0 1]);
title('SFDCE low Ks new Si');colorbar;caxis([0 1]);
xticks([1 2 3 4 5]);
xticklabels({'Bear','Blackw','Happy','Pohono','Trinity'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});
subplot (2, 2, 4);
imagesc(Ks_par_new_STi); %ylim([0 1]);
title('SFDCE low Ks new STi');colorbar;caxis([0 1]);
xticks([1 2 3 4 5]);
xticklabels({'Bear','Blackw','Happy','Pohono','Trinity'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Comparing all parameters to observe changes between watersheds with KGE
%Testing every KGE parameter
Par_list=["Kq", "Ks", "Alp", "H", "B", "DDF", "TR/TT", "TS/Kf", "TM", "SCF/r"];
for i=1:10
    
Kq_par_old_Si_KGE=zeros(33,5);
load bear_lake_sens_yr_run5000_snow_old.mat
Kq_par_old_Si_KGE(:,1)=KGEyearSi(:,i);
load blackwood_sens_yr_run5000_snow_old.mat
Kq_par_old_Si_KGE(:,2)=KGEyearSi(:,i);
load merced_happy_sens_yr_run5000_snow_old.mat 
Kq_par_old_Si_KGE(:,3)=KGEyearSi(:,i);
load merced_pohono_sens_yr_run5000_snow_old.mat 
Kq_par_old_Si_KGE(:,4)=KGEyearSi(:,i);
load trinity_sens_yr_run5000_snow_old.mat
Kq_par_old_Si_KGE(:,5)=KGEyearSi(:,i);

Kq_par_old_STi_KGE=zeros(33,5);
load bear_lake_sens_yr_run5000_snow_old.mat 
Kq_par_old_STi_KGE(:,1)=KGEyearSTi(:,i);
load blackwood_sens_yr_run5000_snow_old.mat
Kq_par_old_STi_KGE(:,2)=KGEyearSTi(:,i);
load merced_happy_sens_yr_run5000_snow_old.mat 
Kq_par_old_STi_KGE(:,3)=KGEyearSTi(:,i);
load merced_pohono_sens_yr_run5000_snow_old.mat 
Kq_par_old_STi_KGE(:,4)=KGEyearSTi(:,i);
load trinity_sens_yr_run5000_snow_old.mat
Kq_par_old_STi_KGE(:,5)=KGEyearSTi(:,i);

Kq_par_new_Si_KGE=zeros(33,5);
load bear_lake_sens_yr_run5000_snow2.mat 
Kq_par_new_Si_KGE(:,1)=KGEyearSi(:,i);
load blackwood_sens_yr_run5000_snow2.mat
Kq_par_new_Si_KGE(:,2)=KGEyearSi(:,i);
load merced_happy_sens_yr_run5000_snow2.mat 
Kq_par_new_Si_KGE(:,3)=KGEyearSi(:,i);
load merced_pohono_sens_yr_run6000_snow2.mat 
Kq_par_new_Si_KGE(:,4)=KGEyearSi(:,i);
load trinity_sens_yr_run5000_snow2.mat
Kq_par_new_Si_KGE(:,5)=KGEyearSi(:,i);

Kq_par_new_STi_KGE=zeros(33,5);
load bear_lake_sens_yr_run5000_snow2.mat 
Kq_par_new_STi_KGE(:,1)=KGEyearSTi(:,i);
load blackwood_sens_yr_run5000_snow2.mat
Kq_par_new_STi_KGE(:,2)=KGEyearSTi(:,i);
load merced_happy_sens_yr_run5000_snow2.mat 
Kq_par_new_STi_KGE(:,3)=KGEyearSTi(:,i);
load merced_pohono_sens_yr_run6000_snow2.mat 
Kq_par_new_STi_KGE(:,4)=KGEyearSTi(:,i);
load trinity_sens_yr_run5000_snow2.mat
Kq_par_new_STi_KGE(:,5)=KGEyearSTi(:,i);

% figure; set(gcf,'color','w');
% subplot (2, 2, 1);
% imagesc(Kq_par_old_Si_KGE);
% title('KGE old Si');colorbar;caxis([0 1]);
% xticks([1 2 3 4 5]);
% xticklabels({'Bear','Blackw','Happy','Pohono','Trinity'});
% yticks([5 10 15 20 25 30]);
% yticklabels({'1985','1990','1995','2000','2005','2010'});
% subplot (2, 2, 2);
% imagesc(Kq_par_old_STi_KGE); 
% title('KGE old STi');colorbar;caxis([0 1]);
% xticks([1 2 3 4 5]);
% xticklabels({'Bear','Blackw','Happy','Pohono','Trinity'});
% yticks([5 10 15 20 25 30]);
% yticklabels({'1985','1990','1995','2000','2005','2010'});
% subplot (2, 2, 3);
% imagesc(Kq_par_new_Si_KGE); 
% title('KGE new Si');colorbar;caxis([0 1]);
% xticks([1 2 3 4 5]);
% xticklabels({'Bear','Blackw','Happy','Pohono','Trinity'});
% yticks([5 10 15 20 25 30]);
% yticklabels({'1985','1990','1995','2000','2005','2010'});
% subplot (2, 2, 4);
% imagesc(Kq_par_new_STi_KGE);
% title('KGE new STi');colorbar;caxis([0 1]);
% xticks([1 2 3 4 5]);
% xticklabels({'Bear','Blackw','Happy','Pohono','Trinity'});
% yticks([5 10 15 20 25 30]);
% yticklabels({'1985','1990','1995','2000','2005','2010'});
% 
% suptitle(sprintf('Parameter %s',Par_list(i)))
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sorting Kf parameter values according to precip
Kf_par_new_Si_KGE_sort=zeros(33,5);
Kf_par_new_STi_KGE_sort=zeros(33,5);
Kf_par_new_Si_KGE_sort_diff=zeros(32,5);
Kf_par_new_STi_KGE_sort_diff=zeros(32,5);

%Bear
load Data_Bear_Lake.mat; %nldas data
dataset = Data_Bear_Lake(1:12692,:);
load Data_Qflow_Bear_Lake.mat; %streamflow
W_size = 142.19; % basin size in km2
Streamflow = ((Data_Qflow_Bear_Lake(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day 
load bear_lake_sens_yr_run5000_snow2.mat %loading Si/STi
year = dataset(:,1);
month = dataset(:,2);
day = dataset(:,3);
precip=dataset(:,6);
tempaver=(dataset(:,9)+ dataset(:,10))/2;

da=0;
cnt=1;
%Finding P annual cumulative averages 
for j=1981:2013 %1980:2014
    [a, ~]=find(year==j & month == 10 & day == 1);
    [b, ~]=find(year==(j+1) & month == 9 & day == 30);
    da=da+1;
    Prec_WatY_cum(da)=sum(precip(a:b));
end
for i=2:33
    Prec_diff(cnt)=Prec_WatY_cum(i)-Prec_WatY_cum(i-1);
    cnt=cnt+1;
end

[P_val,P_index]=sort(Prec_WatY_cum,'descend');
Kf_par_new_STi_KGE_sort(:,1)=KGEyearSTi(P_index',8);
Kf_par_new_Si_KGE_sort(:,1)=KGEyearSi(P_index',8);
[P_val_diff,P_index_diff]=sort(Prec_diff,'descend');
KGEyearSTi1=KGEyearSTi(2:33,:);
KGEyearSi1=KGEyearSi(2:33,:);
Kf_par_new_STi_KGE_sort_diff(:,1)=KGEyearSTi1(P_index_diff',8);
Kf_par_new_Si_KGE_sort_diff(:,1)=KGEyearSi1(P_index_diff',8);

%Blackwood
load Data_Blackwood_Cr.mat; %nldas data
dataset = Data_Blackwood_Cr; 
load Data_Qflow_Blackwood_Cr.mat; %streamflow
W_size = 32.46; % basin size in km2
Streamflow = ((Data_Qflow_Blackwood_Cr(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day   
load blackwood_sens_yr_run5000_snow2.mat
year = dataset(:,1);
month = dataset(:,2);
day = dataset(:,3);
precip=dataset(:,6);
tempaver=(dataset(:,9)+ dataset(:,10))/2;

da=0;
cnt=1;
%Finding P annual cumulative averages 
for j=1981:2013 %1980:2014
    [a, ~]=find(year==j & month == 10 & day == 1);
    [b, ~]=find(year==(j+1) & month == 9 & day == 30);
    da=da+1;
    Prec_WatY_cum(da)=sum(precip(a:b));
end
for i=2:33
    Prec_diff(cnt)=Prec_WatY_cum(i)-Prec_WatY_cum(i-1);
    cnt=cnt+1;
end
[P_val,P_index]=sort(Prec_WatY_cum,'descend');
Kf_par_new_STi_KGE_sort(:,2)=KGEyearSTi(P_index',8);
Kf_par_new_Si_KGE_sort(:,2)=KGEyearSi(P_index',8);
[P_val_diff,P_index_diff]=sort(Prec_diff,'descend');
KGEyearSTi1=KGEyearSTi(2:33,:);
KGEyearSi1=KGEyearSi(2:33,:);
Kf_par_new_STi_KGE_sort_diff(:,2)=KGEyearSTi1(P_index_diff',8);
Kf_par_new_Si_KGE_sort_diff(:,2)=KGEyearSi1(P_index_diff',8);

%Merced Happy
load Data_Merced_Happy.mat; %nldas data
dataset = Data_Merced_Happy; 
load Data_Qflow_Merced_Happy.mat; %streamflow
W_size = 472.3; % basin size in km2
Streamflow = ((Data_Qflow_Merced_Happy(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
load merced_happy_sens_yr_run5000_snow2.mat 
year = dataset(:,1);
month = dataset(:,2);
day = dataset(:,3);
precip=dataset(:,6);
tempaver=(dataset(:,9)+ dataset(:,10))/2;

da=0;
cnt=1;
%Finding P annual cumulative averages 
for j=1981:2013 %1980:2014
    [a, ~]=find(year==j & month == 10 & day == 1);
    [b, ~]=find(year==(j+1) & month == 9 & day == 30);
    da=da+1;
    Prec_WatY_cum(da)=sum(precip(a:b));
end
for i=2:33
    Prec_diff(cnt)=Prec_WatY_cum(i)-Prec_WatY_cum(i-1);
    cnt=cnt+1;
end
[P_val,P_index]=sort(Prec_WatY_cum,'descend');
Kf_par_new_STi_KGE_sort(:,3)=KGEyearSTi(P_index',8);
Kf_par_new_Si_KGE_sort(:,3)=KGEyearSi(P_index',8);
[P_val_diff,P_index_diff]=sort(Prec_diff,'descend');
KGEyearSTi1=KGEyearSTi(2:33,:);
KGEyearSi1=KGEyearSi(2:33,:);
Kf_par_new_STi_KGE_sort_diff(:,3)=KGEyearSTi1(P_index_diff',8);
Kf_par_new_Si_KGE_sort_diff(:,3)=KGEyearSi1(P_index_diff',8);

%Merced Pohono
load Data_Merced_Pohono.mat; %data nldas
dataset = Data_Merced_Pohono; 
load Data_Qflow_Merced_Pohono.mat; %streamflow
W_size = 836.15; % basin size in km2
Streamflow = ((Data_Qflow_Merced_Pohono(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day   
load merced_pohono_sens_yr_run6000_snow2.mat 
year = dataset(:,1);
month = dataset(:,2);
day = dataset(:,3);
precip=dataset(:,6);
tempaver=(dataset(:,9)+ dataset(:,10))/2;

da=0;
cnt=1;
%Finding P annual cumulative averages 
for j=1981:2013 %1980:2014
    [a, ~]=find(year==j & month == 10 & day == 1);
    [b, ~]=find(year==(j+1) & month == 9 & day == 30);
    da=da+1;
    Prec_WatY_cum(da)=sum(precip(a:b));
end
for i=2:33
    Prec_diff(cnt)=Prec_WatY_cum(i)-Prec_WatY_cum(i-1);
    cnt=cnt+1;
end
[P_val,P_index]=sort(Prec_WatY_cum,'descend');
Kf_par_new_STi_KGE_sort(:,4)=KGEyearSTi(P_index',8);
Kf_par_new_Si_KGE_sort(:,4)=KGEyearSi(P_index',8);
[P_val_diff,P_index_diff]=sort(Prec_diff,'descend');
KGEyearSTi1=KGEyearSTi(2:33,:);
KGEyearSi1=KGEyearSi(2:33,:);
Kf_par_new_STi_KGE_sort_diff(:,4)=KGEyearSTi1(P_index_diff',8);
Kf_par_new_Si_KGE_sort_diff(:,4)=KGEyearSi1(P_index_diff',8);

%Trinity
load Data_Trinity_R.mat; %nldas data
dataset = Data_Trinity_R; 
load Data_Qflow_Trinity_R.mat; %streamflow
W_size = 385.08; % basin size in km2
Streamflow = ((Data_Qflow_Trinity_R(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day 
load trinity_sens_yr_run5000_snow2.mat
year = dataset(:,1);
month = dataset(:,2);
day = dataset(:,3);
precip=dataset(:,6);
tempaver=(dataset(:,9)+ dataset(:,10))/2;

da=0;
cnt=1;
%Finding P annual cumulative averages 
for j=1981:2013 %1980:2014
    [a, ~]=find(year==j & month == 10 & day == 1);
    [b, ~]=find(year==(j+1) & month == 9 & day == 30);
    da=da+1;
    Prec_WatY_cum(da)=sum(precip(a:b));
end
for i=2:33
    Prec_diff(cnt)=Prec_WatY_cum(i)-Prec_WatY_cum(i-1);
    cnt=cnt+1;
end
[P_val,P_index]=sort(Prec_WatY_cum,'descend');
Kf_par_new_STi_KGE_sort(:,5)=KGEyearSTi(P_index',8);
Kf_par_new_Si_KGE_sort(:,5)=KGEyearSi(P_index',8);
[P_val_diff,P_index_diff]=sort(Prec_diff,'descend');
KGEyearSTi1=KGEyearSTi(2:33,:);
KGEyearSi1=KGEyearSi(2:33,:);
Kf_par_new_STi_KGE_sort_diff(:,5)=KGEyearSTi1(P_index_diff',8);
Kf_par_new_Si_KGE_sort_diff(:,5)=KGEyearSi1(P_index_diff',8);

figure; set(gcf,'color','w');
imagesc(Kf_par_new_Si_KGE_sort);
title('KGE Kf new Si (sort by P)');colorbar;caxis([0 1]);
xticks([1 2 3 4 5]);
xticklabels({'Bear','Blackw','Happy','Pohono','Trinity'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});

figure; set(gcf,'color','w');
imagesc(Kf_par_new_STi_KGE_sort);
title('KGE Kf new STi (sort by P)');colorbar;caxis([0 1]);
xticks([1 2 3 4 5]);
xticklabels({'Bear','Blackw','Happy','Pohono','Trinity'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});

figure; set(gcf,'color','w');
imagesc(Kf_par_new_Si_KGE_sort_diff);
title('KGE Kf new Si (sort by P diff)');colorbar;caxis([0 1]);
xticks([1 2 3 4 5]);
xticklabels({'Bear','Blackw','Happy','Pohono','Trinity'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});

figure; set(gcf,'color','w');
imagesc(Kf_par_new_STi_KGE_sort_diff);
title('KGE Kf new STi (sort by P diff)');colorbar;caxis([0 1]);
xticks([1 2 3 4 5]);
xticklabels({'Bear','Blackw','Happy','Pohono','Trinity'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});