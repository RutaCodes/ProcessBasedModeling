clear all; 
global Data

my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

load mfeel_sens_yr_run5000_snow_Newrun1.mat;%KGE values
load mfeel_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat %SFDCE values
figure; set(gcf,'color','w');
%imagesc(KGEyearSTi);
imagesc(SFDCE_low_yearSTi);
title('MFE FDCL STi');colormap(flipud(gray));colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([4 9 14 19 24 29]);
yticklabels({'1985','1990','1995','2000','2005','2010'});

clear KGEyearSTi SFDCE_low_yearSTi;
load redwood_sens_yr_run5000_snow_Newrun1.mat;
load redwood_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat %SFDCE values
figure; set(gcf,'color','w');
%imagesc(KGEyearSTi);
imagesc(SFDCE_low_yearSTi);
title('RED FDCL STi');colormap(flipud(gray));colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([4 9 14 19 24 29]);
yticklabels({'1985','1990','1995','2000','2005','2010'});

clear KGEyearSTi SFDCE_low_yearSTi;
load deer_sens_yr_run5000_snow_Newrun1.mat;
load deer_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat %SFDCE values
figure; set(gcf,'color','w');
%imagesc(KGEyearSTi);
imagesc(SFDCE_low_yearSTi);
title('DEE FDCL STi');colormap(flipud(gray));colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([4 9 14 19 24 29]);
yticklabels({'1985','1990','1995','2000','2005','2010'});

clear KGEyearSTi SFDCE_low_yearSTi;
load bear_lake_sens_yr_run5000_snow_Newrun1.mat;
load bear_lake_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat %SFDCE values
figure; set(gcf,'color','w');
%imagesc(KGEyearSTi);
imagesc(SFDCE_low_yearSTi);
title('BEA FDCL STi');colormap(flipud(gray));colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([4 9 14 19 24 29]);
yticklabels({'1985','1990','1995','2000','2005','2010'});

clear KGEyearSTi SFDCE_low_yearSTi;
load del_puerto_sens_yr_run5000_snow_Newrun1.mat;
load del_puerto_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat %SFDCE values
figure; set(gcf,'color','w');
%imagesc(KGEyearSTi);
imagesc(SFDCE_low_yearSTi);
title('DPU FDCL STi');colormap(flipud(gray));colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([4 9 14 19 24 29]);
yticklabels({'1985','1990','1995','2000','2005','2010'});
