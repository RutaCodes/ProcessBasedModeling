%Ruta Basijokaite

clear all; 
global Data

my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

figure; set(gcf,'color','w');

subplot(5,1,1);
load NFCache_Streamflow.mat
% plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load SFTrinity_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load noyo_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load salmon_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load mfeel_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load VanDuzen_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load little_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load bull_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load redwood_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load smith_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load trinity_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load deer_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load mill_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load bear_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load merced_happy_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load merced_pohono_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load pitman_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load delpuerto_Streamflow.mat
str = '#E41A1C';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
load lopez_Streamflow.mat
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
load pescadero_Streamflow.mat
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
load big_sur_Streamflow.mat
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
xlim([1 365]);ylim([0 100]);set(gca,'yscale','log');
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

subplot(5,1,2);
load delpuerto_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load lopez_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load pescadero_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load big_sur_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load VanDuzen_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load little_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load bull_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load redwood_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load smith_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load trinity_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load deer_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load mill_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load bear_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load merced_happy_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load merced_pohono_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load pitman_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load NFCache_Streamflow.mat
str = '#FF7F00';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
load SFTrinity_Streamflow.mat
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
load noyo_Streamflow.mat
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
load salmon_Streamflow.mat
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
load mfeel_Streamflow.mat
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
xlim([1 365]);ylim([0 100]);set(gca,'yscale','log');
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

subplot(5,1,3);
load delpuerto_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load lopez_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load pescadero_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load big_sur_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load NFCache_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load SFTrinity_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load noyo_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load salmon_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load mfeel_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load trinity_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load deer_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load mill_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load bear_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load merced_happy_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load merced_pohono_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load pitman_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load VanDuzen_Streamflow.mat
str = '#4DAF4A';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
load little_Streamflow.mat
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
load bull_Streamflow.mat
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
load redwood_Streamflow.mat
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
load smith_Streamflow.mat
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
xlim([1 365]);ylim([0 100]);set(gca,'yscale','log');
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

subplot(5,1,4);
load delpuerto_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load lopez_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load pescadero_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load big_sur_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load NFCache_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load SFTrinity_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load noyo_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load salmon_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load mfeel_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load VanDuzen_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load little_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load bull_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load redwood_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load smith_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load bear_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load merced_happy_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load merced_pohono_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load pitman_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load trinity_Streamflow.mat
str = '#984EA3';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
load deer_Streamflow.mat
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
load mill_Streamflow.mat
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
xlim([1 365]);ylim([0 100]);set(gca,'yscale','log');
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

subplot(5,1,5);
load delpuerto_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load lopez_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load pescadero_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load big_sur_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load NFCache_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load SFTrinity_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load noyo_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load salmon_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load mfeel_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load VanDuzen_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load little_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load bull_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load redwood_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load smith_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load trinity_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load deer_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;
load mill_Streamflow.mat
plot(Streamflow(1:365),'Color',[0.5 0.5 0.5]); hold on;

load bear_Streamflow.mat
str = '#377EB8';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
load merced_happy_Streamflow.mat
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
load merced_pohono_Streamflow.mat
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
load pitman_Streamflow.mat
plot(Streamflow(1:365),'Color',color,'LineWidth',1.5); hold on;
xlim([1 365]);ylim([0 100]);set(gca,'yscale','log');
%yticks([0.1 1 10]);yticklabels({'0.1','0','1','10'});
YTick = [0.1,1,10,30];
YTickLabels = cellstr(num2str(round(log10(YTick(:))), '10^%d'));
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
