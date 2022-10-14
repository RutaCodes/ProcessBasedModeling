clear all; 
global Data

my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

figure; set(gcf,'color','w');
subplot(5,1,1);
load delpuerto_Streamflow.mat
plot(Streamflow(1:365)); hold on;
load lopez_Streamflow.mat
plot(Streamflow(1:365)); hold on;
load pescadero_Streamflow.mat
plot(Streamflow(1:365)); hold on;
load big_sur_Streamflow.mat
plot(Streamflow(1:365)); hold on;
title('Group 1 (H + B) Hydrographs');
legend('DPU','LOP','PES','BSU'); xlim([1 365]);ylim([0 20]);set(gca,'yscale','log');

%figure; set(gcf,'color','w');
subplot(5,1,2);
load NFCache_Streamflow.mat
plot(Streamflow(1:365)); hold on;
load SFTrinity_Streamflow.mat
plot(Streamflow(1:365)); hold on;
load noyo_Streamflow.mat
plot(Streamflow(1:365)); hold on;
load salmon_Streamflow.mat
plot(Streamflow(1:365)); hold on;
load mfeel_Streamflow.mat
plot(Streamflow(1:365)); hold on;
title('Group 2 (Ks + H + B) Hydrographs');
legend('NFC','SFT','NOY','SAL','MFE');xlim([1 365]);ylim([0 20]);set(gca,'yscale','log');

%figure; set(gcf,'color','w');
subplot(5,1,3);
load VanDuzen_Streamflow.mat
plot(Streamflow(1:365)); hold on;
load little_Streamflow.mat
plot(Streamflow(1:365)); hold on;
load bull_Streamflow.mat
plot(Streamflow(1:365)); hold on;
load redwood_Streamflow.mat
plot(Streamflow(1:365)); hold on;
load smith_Streamflow.mat
plot(Streamflow(1:365)); hold on;
title('Group 3 (Ks) Hydrographs');
legend('VDU','LIT','BUL','RED','SMI');xlim([1 365]);ylim([0 100]);set(gca,'yscale','log');

%figure; set(gcf,'color','w');
subplot(5,1,4);
load trinity_Streamflow.mat
plot(Streamflow(1:365)); hold on;
load deer_Streamflow.mat
plot(Streamflow(1:365)); hold on;
load mill_Streamflow.mat
plot(Streamflow(1:365)); hold on;
title('Group 4 (Multiple) Hydrographs');
legend('TRI','DEE','MIL');xlim([1 365]);ylim([0 20]);set(gca,'yscale','log');

%figure; set(gcf,'color','w');
subplot(5,1,5);
load bear_Streamflow.mat
plot(Streamflow(1:365)); hold on;
load merced_happy_Streamflow.mat
plot(Streamflow(1:365)); hold on;
load merced_pohono_Streamflow.mat
plot(Streamflow(1:365)); hold on;
load pitman_Streamflow.mat
plot(Streamflow(1:365)); hold on;
title('Group 5 (Snow) Hydrographs');
legend('BEA','MHA','MPO','PIT');xlim([1 365]);ylim([0 20]);set(gca,'yscale','log');


