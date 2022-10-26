%Ruta Basijokaite

clear all;
load blackwood_sens_yr_run5000_test6.mat
load blackwood_sens_yr_hyd_run5000_test6.mat

figure; set(gcf,'color','w');
subplot(3,3,[1 3]);
plot(SFDCE_high_yearSTi(:,1)); hold on;
plot(SFDCE_high_yearSTi(:,2)); hold on;
plot(SFDCE_high_yearSTi(:,3)); hold on;
plot(SFDCE_high_yearSTi(:,6)); hold on;
plot(SFDCE_high_yearSTi(:,9)); hold on; xlim([1 33]);ylim([-0.1 0.8]);
title('SFDCE high STi'); legend ('Kq','Ks','Alp','DDF','TM','location','eastoutside');
xticks([5 10 15 20 25 30]);xticklabels({'1985','1990','1995','2000','2005','2010'});
subplot(3,3,[4 6]);
plot(SFDCE_mid_yearSTi(:,1)); hold on;
plot(SFDCE_mid_yearSTi(:,2)); hold on;
plot(SFDCE_mid_yearSTi(:,3)); hold on;
plot(SFDCE_mid_yearSTi(:,6)); hold on;
plot(SFDCE_mid_yearSTi(:,9)); hold on; xlim([1 33]);ylim([-0.1 0.8]);
title('SFDCE mid STi'); legend ('Kq','Ks','Alp','DDF','TM','location','eastoutside');
xticks([5 10 15 20 25 30]);xticklabels({'1985','1990','1995','2000','2005','2010'});
subplot(3,3,[7 9]);
plot(SFDCE_low_yearSTi(:,1)); hold on;
plot(SFDCE_low_yearSTi(:,2)); hold on;
plot(SFDCE_low_yearSTi(:,3)); hold on;
plot(SFDCE_low_yearSTi(:,6)); hold on;
plot(SFDCE_low_yearSTi(:,9)); hold on; xlim([1 33]);ylim([-0.1 0.8]);
title('SFDCE low STi'); legend ('Kq','Ks','Alp','DDF','TM','location','eastoutside');
xticks([5 10 15 20 25 30]);xticklabels({'1985','1990','1995','2000','2005','2010'});

figure; set(gcf,'color','w');
subplot(3,3,[1 3]);
plot(SFDCE_high_yearSi(:,1)); hold on;
plot(SFDCE_high_yearSi(:,2)); hold on;
plot(SFDCE_high_yearSi(:,3)); hold on;
plot(SFDCE_high_yearSi(:,6)); hold on;
plot(SFDCE_high_yearSi(:,9)); hold on; xlim([1 33]);ylim([-0.1 0.6]);
title('SFDCE high Si'); legend ('Kq','Ks','Alp','DDF','TM','location','eastoutside');
xticks([5 10 15 20 25 30]);xticklabels({'1985','1990','1995','2000','2005','2010'});
subplot(3,3,[4 6]);
plot(SFDCE_mid_yearSi(:,1)); hold on;
plot(SFDCE_mid_yearSi(:,2)); hold on;
plot(SFDCE_mid_yearSi(:,3)); hold on;
plot(SFDCE_mid_yearSi(:,6)); hold on;
plot(SFDCE_mid_yearSi(:,9)); hold on; xlim([1 33]);ylim([-0.1 0.6]);
title('SFDCE mid Si'); legend ('Kq','Ks','Alp','DDF','TM','location','eastoutside');
xticks([5 10 15 20 25 30]);xticklabels({'1985','1990','1995','2000','2005','2010'});
subplot(3,3,[7 9]);
plot(SFDCE_low_yearSi(:,1)); hold on;
plot(SFDCE_low_yearSi(:,2)); hold on;
plot(SFDCE_low_yearSi(:,3)); hold on;
plot(SFDCE_low_yearSi(:,6)); hold on;
plot(SFDCE_low_yearSi(:,9)); hold on; xlim([1 33]);ylim([-0.1 0.6]);
title('SFDCE low Si'); legend ('Kq','Ks','Alp','DDF','TM','location','eastoutside');
xticks([5 10 15 20 25 30]);xticklabels({'1985','1990','1995','2000','2005','2010'});


