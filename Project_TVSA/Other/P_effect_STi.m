clear all; 
global Data

my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

%define varaibe that can be used for confidence interval
STi_Ks=zeros(33,10);
Precip_Ks=zeros(33,10);
load Precip_sort.mat %pull precip values
load NFCache_KGEyearSTi_sort_Pcum.mat %pull STi values
STi_Ks(:,1)=KGEyearSTi_sort_Pcum(:,2);%Ks
Precip_Ks(:,1)=Precip_sort(:,1);
load Noyo_KGEyearSTi_sort_Pcum.mat
STi_Ks(:,2)=KGEyearSTi_sort_Pcum(:,2);%Ks
Precip_Ks(:,2)=Precip_sort(:,2);
load MFEel_KGEyearSTi_sort_Pcum.mat
STi_Ks(:,3)=KGEyearSTi_sort_Pcum(:,2);%Ks
Precip_Ks(:,3)=Precip_sort(:,3);
load Salmon_KGEyearSTi_sort_Pcum.mat
STi_Ks(:,4)=KGEyearSTi_sort_Pcum(:,2);%Ks
Precip_Ks(:,4)=Precip_sort(:,4);
load SFTrinity_KGEyearSTi_sort_Pcum.mat
STi_Ks(:,5)=KGEyearSTi_sort_Pcum(:,2);%Ks
Precip_Ks(:,5)=Precip_sort(:,5);
load Bull_KGEyearSTi_sort_Pcum.mat
STi_Ks(:,6)=KGEyearSTi_sort_Pcum(:,2);%Ks
Precip_Ks(:,6)=Precip_sort(:,6);
load Little_KGEyearSTi_sort_Pcum.mat
STi_Ks(:,7)=KGEyearSTi_sort_Pcum(:,2);%Ks
Precip_Ks(:,7)=Precip_sort(:,7);
load VanDuzen_KGEyearSTi_sort_Pcum.mat
STi_Ks(:,8)=KGEyearSTi_sort_Pcum(:,2);%Ks
Precip_Ks(:,8)=Precip_sort(:,8);
load Redwood_KGEyearSTi_sort_Pcum.mat
STi_Ks(:,9)=KGEyearSTi_sort_Pcum(:,2);%Ks
Precip_Ks(:,9)=Precip_sort(:,9);
load Smith_KGEyearSTi_sort_Pcum.mat
STi_Ks(:,10)=KGEyearSTi_sort_Pcum(:,2);%Ks
Precip_Ks(:,10)=Precip_sort(:,10);

%Matrix to verctor
% % STi_Ks_vec=reshape(STi_Ks,[330,1]);
% % Precip_Ks_vec=reshape(Precip_Ks,[330,1]);

%Computing confidence interval

% [p,t,stats]=anova1(Precip_Ks,STi_Ks,'Off');
% [c,m,h,nms]=multcompare(stats);

% N=size(Precip_Ks,1);
% Precip_mean=mean(Precip_Ks);
% Precip_SEM=std(Precip_Ks)/sqrt(N);
% CI95=tinv([0.025 0.975],N-1);
% yCI95=bsxfun(@times, Precip_SEM, CI95(:));

% figure; set(gcf,'color','w');
% plot(mean(STi_Ks),Precip_mean);
% hold on; 
% plot(mean(STi_Ks),yCI95+Precip_mean);
% grid;
% 
% prec_Ks=Precip_Ks';
% STi_Ks_rev=STi_Ks';
% 
% N=size(prec_Ks,1);
% Precip_mean=mean(prec_Ks);
% Precip_SEM=std(prec_Ks)/sqrt(N);
% CI95=tinv([0.025 0.975],N-1);
% yCI95=bsxfun(@times, Precip_SEM, CI95(:));
% 
% figure; set(gcf,'color','w');
% plot(mean(STi_Ks_rev),Precip_mean);
% hold on; 
% plot(mean(STi_Ks_rev),yCI95+Precip_mean);
% grid;

%%%%%%%%%%%%%%%%%% Ks H B group %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure; set(gcf,'color','w');
% sz=25;
% load Precip_sort.mat %pull precip values
% load NFCache_KGEyearSTi_sort_Pcum.mat %pull STi values
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,1),sz,'filled','r'); hold on;
% clear STi_val;
% load Noyo_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,2),sz,'filled','g'); hold on;
% clear STi_val;
% load MFEel_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,3),sz,'filled','b'); hold on;
% clear STi_val;
% load Salmon_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,4),sz,'filled','y'); hold on;
% clear STi_val;
% load SFTrinity_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,5),sz,'filled','k'); hold on;
% legend('NF Cache','Noyo','MF Eel','Salmon','SF Trinity');
% ylabel('Cumulative Annual Precipitation (mm)');
% xlabel('Ks KGE STi');

% figure; set(gcf,'color','w');
% sz=25;
% load Precip_sort.mat %pull precip values
% load NFCache_KGEyearSTi_sort_Pcum.mat %pull STi values
% STi_val=KGEyearSTi_sort_Pcum(:,4);%H
% scatter(STi_val,Precip_sort(:,1),sz,'filled','r'); hold on;
% clear STi_val;
% load Noyo_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,4);
% scatter(STi_val,Precip_sort(:,2),sz,'filled','g'); hold on;
% clear STi_val;
% load MFEel_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,4);
% scatter(STi_val,Precip_sort(:,3),sz,'filled','b'); hold on;
% clear STi_val;
% load Salmon_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,4);
% scatter(STi_val,Precip_sort(:,4),sz,'filled','y'); hold on;
% clear STi_val;
% load SFTrinity_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,4);
% scatter(STi_val,Precip_sort(:,5),sz,'filled','k'); hold on;
% legend('NF Cache','Noyo','MF Eel','Salmon','SF Trinity');
% ylabel('Cumulative Annual Precipitation (mm)');
% xlabel('H KGE STi');

% figure; set(gcf,'color','w');
% sz=25;
% load Precip_sort.mat %pull precip values
% load NFCache_KGEyearSTi_sort_Pcum.mat %pull STi values
% STi_val=KGEyearSTi_sort_Pcum(:,5);%B
% scatter(STi_val,Precip_sort(:,1),sz,'filled','r'); hold on;
% clear STi_val;
% load Noyo_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,5);
% scatter(STi_val,Precip_sort(:,2),sz,'filled','g'); hold on;
% clear STi_val;
% load MFEel_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,5);
% scatter(STi_val,Precip_sort(:,3),sz,'filled','b'); hold on;
% clear STi_val;
% load Salmon_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,5);
% scatter(STi_val,Precip_sort(:,4),sz,'filled','y'); hold on;
% clear STi_val;
% load SFTrinity_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,5);
% scatter(STi_val,Precip_sort(:,5),sz,'filled','k'); hold on;
% legend('NF Cache','Noyo','MF Eel','Salmon','SF Trinity');
% ylabel('Cumulative Annual Precipitation (mm)');
% xlabel('B KGE STi');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Ks group
% figure; set(gcf,'color','w');
% load Bull_KGEyearSTi_sort_Pcum.mat %pull STi values
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% %scatter(STi_val,Precip_sort(:,6),'+','r'); hold on;
% scatter(STi_val,Precip_sort(:,6),sz,'filled','r'); hold on;
% clear STi_val;
% load Little_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,7),sz,'filled','g'); hold on;
% clear STi_val;
% load VanDuzen_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,8),sz,'filled','b'); hold on;
% clear STi_val;
% load Redwood_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,9),sz,'filled','y'); hold on;
% clear STi_val;
% load Smith_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,10),sz,'filled','k'); hold on;
% legend('Bull','Little','Van Duzen','Redwood','Smith','Location','northeastoutside');
% legend('boxoff');
% ylabel('Cumulative Annual Precipitation (mm)');
% xlabel('Ks KGE STi');
% 
% figure; set(gcf,'color','w');
% load Bull_KGEyearSTi_sort_Pcum.mat %pull STi values
% STi_val=KGEyearSTi_sort_Pcum(:,4);%H
% %scatter(STi_val,Precip_sort(:,6),'+','r'); hold on;
% scatter(STi_val,Precip_sort(:,6),sz,'filled','r'); hold on;
% clear STi_val;
% load Little_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,4);
% scatter(STi_val,Precip_sort(:,7),sz,'filled','g'); hold on;
% clear STi_val;
% load VanDuzen_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,4);
% scatter(STi_val,Precip_sort(:,8),sz,'filled','b'); hold on;
% clear STi_val;
% load Redwood_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,4);
% scatter(STi_val,Precip_sort(:,9),sz,'filled','y'); hold on;
% clear STi_val;
% load Smith_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,4);
% scatter(STi_val,Precip_sort(:,10),sz,'filled','k'); hold on;
% legend('Bull','Little','Van Duzen','Redwood','Smith','Location','northeastoutside');
% legend('boxoff');
% ylabel('Cumulative Annual Precipitation (mm)');
% xlabel('H KGE STi');
% 
% figure; set(gcf,'color','w');
% load Bull_KGEyearSTi_sort_Pcum.mat %pull STi values
% STi_val=KGEyearSTi_sort_Pcum(:,5);%H
% %scatter(STi_val,Precip_sort(:,6),'+','r'); hold on;
% scatter(STi_val,Precip_sort(:,6),sz,'filled','r'); hold on;
% clear STi_val;
% load Little_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,5);
% scatter(STi_val,Precip_sort(:,7),sz,'filled','g'); hold on;
% clear STi_val;
% load VanDuzen_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,5);
% scatter(STi_val,Precip_sort(:,8),sz,'filled','b'); hold on;
% clear STi_val;
% load Redwood_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,5);
% scatter(STi_val,Precip_sort(:,9),sz,'filled','y'); hold on;
% clear STi_val;
% load Smith_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,5);
% scatter(STi_val,Precip_sort(:,10),sz,'filled','k'); hold on;
% legend('Bull','Little','Van Duzen','Redwood','Smith','Location','northeastoutside');
% legend('boxoff');
% ylabel('Cumulative Annual Precipitation (mm)');
% xlabel('B KGE STi');
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % H B group
% figure; set(gcf,'color','w');
% load Big_KGEyearSTi_sort_Pcum.mat %pull STi values
% STi_val=KGEyearSTi_sort_Pcum(:,4);%H
% scatter(STi_val,Precip_sort(:,11),sz,'filled','r'); hold on;
% clear STi_val;
% load Lopez_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,4);
% scatter(STi_val,Precip_sort(:,12),sz,'filled','g'); hold on;
% clear STi_val;
% load Pescadero_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,4);
% scatter(STi_val,Precip_sort(:,13),sz,'filled','b'); hold on;
% clear STi_val;
% load Cantua_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,4);
% scatter(STi_val,Precip_sort(:,14),sz,'filled','y'); hold on;
% clear STi_val;
% load BigSur_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,4);
% scatter(STi_val,Precip_sort(:,15),sz,'filled','k'); hold on;
% clear STi_val;
% load DelPuerto_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,4);
% scatter(STi_val,Precip_sort(:,16),sz,'filled','m'); hold on;
% clear STi_val;
% load SantaCruz_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,4);
% scatter(STi_val,Precip_sort(:,17),sz,'filled','c'); hold on;
% clear STi_val;
% load LosGatos_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,4);
% scatter(STi_val,Precip_sort(:,18),'+','r'); hold on;
% clear STi_val;
% load Arroyo_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,4);
% scatter(STi_val,Precip_sort(:,19),'+','g'); hold on;
% clear STi_val;
% load Orestimba_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,4);
% scatter(STi_val,Precip_sort(:,20),'+','b'); hold on;
% clear STi_val;
% load Nacimiento_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,4);
% scatter(STi_val,Precip_sort(:,21),'+','k'); hold on;
% clear STi_val;
% load SanLorenzo_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,4);
% scatter(STi_val,Precip_sort(:,22),'+','m'); hold on;
% legend('Big','Lopez','Pescadero','Cantua','BigSur','DelPuerto','SantaCruz','LosGatos','Arroyo','Orestimba','Nacimiento','SanLorenzo','Location','northeastoutside');
% legend('boxoff');
% ylabel('Cumulative Annual Precipitation (mm)');
% xlabel('H KGE STi');
% 
% figure; set(gcf,'color','w');
% load Big_KGEyearSTi_sort_Pcum.mat %pull STi values
% STi_val=KGEyearSTi_sort_Pcum(:,5);%B
% scatter(STi_val,Precip_sort(:,11),sz,'filled','r'); hold on;
% clear STi_val;
% load Lopez_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,5);
% scatter(STi_val,Precip_sort(:,12),sz,'filled','g'); hold on;
% clear STi_val;
% load Pescadero_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,5);
% scatter(STi_val,Precip_sort(:,13),sz,'filled','b'); hold on;
% clear STi_val;
% load Cantua_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,5);
% scatter(STi_val,Precip_sort(:,14),sz,'filled','y'); hold on;
% clear STi_val;
% load BigSur_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,5);
% scatter(STi_val,Precip_sort(:,15),sz,'filled','k'); hold on;
% clear STi_val;
% load DelPuerto_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,5);
% scatter(STi_val,Precip_sort(:,16),sz,'filled','m'); hold on;
% clear STi_val;
% load SantaCruz_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,5);
% scatter(STi_val,Precip_sort(:,17),sz,'filled','c'); hold on;
% clear STi_val;
% load LosGatos_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,5);
% scatter(STi_val,Precip_sort(:,18),'+','r'); hold on;
% clear STi_val;
% load Arroyo_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,5);
% scatter(STi_val,Precip_sort(:,19),'+','g'); hold on;
% clear STi_val;
% load Orestimba_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,5);
% scatter(STi_val,Precip_sort(:,20),'+','b'); hold on;
% clear STi_val;
% load Nacimiento_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,5);
% scatter(STi_val,Precip_sort(:,21),'+','k'); hold on;
% clear STi_val;
% load SanLorenzo_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,5);
% scatter(STi_val,Precip_sort(:,22),'+','m'); hold on;
% legend('Big','Lopez','Pescadero','Cantua','BigSur','DelPuerto','SantaCruz','LosGatos','Arroyo','Orestimba','Nacimiento','SanLorenzo','Location','northeastoutside');
% legend('boxoff');
% ylabel('Cumulative Annual Precipitation (mm)');
% xlabel('B KGE STi');

%%%%%% Combining groups %%%%%%
% figure; set(gcf,'color','w');
% sz=25;
% load Precip_sort.mat %pull precip values
% load NFCache_KGEyearSTi_sort_Pcum.mat %pull STi values
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,1),sz,'filled','r'); hold on;
% clear STi_val;
% load Noyo_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,2),sz,'filled','g'); hold on;
% clear STi_val;
% load MFEel_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,3),sz,'filled','b'); hold on;
% clear STi_val;
% load Salmon_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,4),sz,'filled','y'); hold on;
% clear STi_val;
% load SFTrinity_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,5),sz,'filled','k'); hold on;
% load Bull_KGEyearSTi_sort_Pcum.mat %pull STi values
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% %scatter(STi_val,Precip_sort(:,6),'+','r'); hold on;
% scatter(STi_val,Precip_sort(:,6),'+','r'); hold on;
% clear STi_val;
% load Little_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,7),'+','g'); hold on;
% clear STi_val;
% load VanDuzen_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,8),'+','b'); hold on;
% clear STi_val;
% load Redwood_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,9),'+','y'); hold on;
% clear STi_val;
% load Smith_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,10),'+','k'); hold on;
% legend('NF Cache','Noyo','MF Eel','Salmon','SF Trinity','Bull','Little','Van Duzen','Redwood','Smith','Location','northeastoutside');
% legend('boxoff');
% ylabel('Cumulative Annual Precipitation (mm)');
% xlabel('Ks KGE STi');

figure; set(gcf,'color','w');sz=25;sz2=22;
subplot(3,2,1);
load Precip_sort.mat %pull precip values
% load NFCache_KGEyearSTi_sort_Pcum.mat %pull STi values
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,1),sz,'filled','r'); hold on;
% clear STi_val;
% load Noyo_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,2),sz,'filled','g'); hold on;
% clear STi_val;
% load MFEel_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,3),sz,'filled','b'); hold on;
% clear STi_val;
% load Salmon_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,4),sz,'filled','y'); hold on;
% clear STi_val;
% load SFTrinity_KGEyearSTi_sort_Pcum.mat
% STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,5),sz,'filled','k'); hold on;
load Bull_KGEyearSTi_sort_Pcum.mat %pull STi values
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
%s=scatter(STi_val,Precip_sort(:,6),sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
s=scatter(Precip_sort(:,6),STi_val,sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
clear STi_val;
load Little_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
%s=scatter(STi_val,Precip_sort(:,7),sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
s=scatter(Precip_sort(:,7),STi_val,sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
clear STi_val;
load VanDuzen_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
%s=scatter(STi_val,Precip_sort(:,8),sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
s=scatter(Precip_sort(:,8),STi_val,sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
clear STi_val;
load Redwood_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
%s=scatter(STi_val,Precip_sort(:,9),sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
s=scatter(Precip_sort(:,9),STi_val,sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
clear STi_val;
load Smith_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
%s=scatter(STi_val,Precip_sort(:,10),sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
s=scatter(Precip_sort(:,10),STi_val,sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
load NFCache_KGEyearSTi_sort_Pcum.mat %pull STi values
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
% scatter(STi_val,Precip_sort(:,1),sz,'filled','r'); hold on;
scatter(Precip_sort(:,1),STi_val,sz,'filled','r'); hold on;
%p=polyfit(STi_val,Precip_sort(:,1),1);
p=polyfit(Precip_sort(:,1),STi_val,1);
%y1=[p(2),(p(1)*1.2+p(2))];line1(1,1)=p(1);line1(1,2)=p(2);
y1=[p(2),(p(1)*3500+p(2))];line1(1,1)=p(1);line1(1,2)=p(2);
%%% [r(1,2),~,~,~]=corrcoef(STi_val,Precip_sort(:,1));
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,1),STi_val);
C1_1=C(1,2);
clear STi_val;
load Noyo_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
%scatter(STi_val,Precip_sort(:,2),sz,'filled','g'); hold on;
scatter(Precip_sort(:,2),STi_val,sz,'filled','g'); hold on;
%p=polyfit(STi_val,Precip_sort(:,2),1);
p=polyfit(Precip_sort(:,2),STi_val,1);
%y2=[p(2),(p(1)*1.2+p(2))];line1(2,1)=p(1);line1(2,2)=p(2);
y2=[p(2),(p(1)*3500+p(2))];line1(2,1)=p(1);line1(2,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,2),STi_val);
C1_2=C(1,2);
clear STi_val;
load MFEel_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
%scatter(STi_val,Precip_sort(:,3),sz,'filled','b'); hold on;
scatter(Precip_sort(:,3),STi_val,sz,'filled','b'); hold on;
%p=polyfit(STi_val,Precip_sort(:,3),1);
p=polyfit(Precip_sort(:,3),STi_val,1);
%y3=[p(2),(p(1)*1.2+p(2))];line1(3,1)=p(1);line1(3,2)=p(2);
y3=[p(2),(p(1)*3500+p(2))];line1(3,1)=p(1);line1(3,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,3),STi_val);
C1_3=C(1,2);
clear STi_val;
load Salmon_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
%scatter(STi_val,Precip_sort(:,4),sz,'filled','m'); hold on;
scatter(Precip_sort(:,4),STi_val,sz,'filled','m'); hold on;
%p=polyfit(STi_val,Precip_sort(:,4),1);
p=polyfit(Precip_sort(:,4),STi_val,1);
%y4=[p(2),(p(1)*1.2+p(2))];line1(4,1)=p(1);line1(4,2)=p(2);
y4=[p(2),(p(1)*3500+p(2))];line1(4,1)=p(1);line1(4,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,4),STi_val);
C1_4=C(1,2);
clear STi_val;
load SFTrinity_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
%scatter(STi_val,Precip_sort(:,5),sz,'filled','k'); hold on;
scatter(Precip_sort(:,5),STi_val,sz,'filled','k'); hold on;
%p=polyfit(STi_val,Precip_sort(:,5),1);
p=polyfit(Precip_sort(:,5),STi_val,1);
%y5=[p(2),(p(1)*1.2+p(2))];line1(5,1)=p(1);line1(5,2)=p(2);
y5=[p(2),(p(1)*3500+p(2))];line1(5,1)=p(1);line1(5,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,5),STi_val);
C1_5=C(1,2);
% plot([0 1.2],y1,'--r');hold on;
% plot([0 1.2],y2,'--g');hold on;
% plot([0 1.2],y3,'--b');hold on;
% plot([0 1.2],y4,'--m');hold on;
% plot([0 1.2],y5,'--k');hold on;
plot([0 3500],y1,'--r');hold on;
plot([0 3500],y2,'--g');hold on;
plot([0 3500],y3,'--b');hold on;
plot([0 3500],y4,'--m');hold on;
plot([0 3500],y5,'--k');hold on;
% %legend('NF Cache','Noyo','MF Eel','Salmon','SF Trinity','Bull\newlineLittle\newlineVan Duzen\newlineRedwood\newlineSmith','Location','northeastoutside');
% %legend('Bull\newlineLittle\newlineVan Duzen\newlineRedwood\newlineSmith','NF Cache','Noyo','MF Eel','Salmon','SF Trinity','Location','northeastoutside');
%legend('Bull','Little','Van Duzen','Redwood','Smith','NF Cache','Noyo','MF Eel','Salmon','SF Trinity','A','A','A','A','A','Location','northeastoutside');
%legend('Bull','Little','Van Duzen','Redwood','Smith',['NF Cache R=', num2str(C1_1)],['Noyo R=', num2str(C1_2)],['MF Eel R=',num2str(C1_3)],['Salmon R=',num2str(C1_4)],['SF Trinity R=',num2str(C1_5)],'Location','northeastoutside');
legend('Bull','Little','Van Duzen','Redwood','Smith',['NFC R = ', num2str(C1_1)],['NOY R = ', num2str(C1_2)],['MFE R = ',num2str(C1_3)],['SAL R = ',num2str(C1_4)],['SFT R = ',num2str(C1_5)],'Location','northeastoutside');
legend('boxoff'); grid; xlim([0 3500]); ylim([0 1]); %xlim([0 1]);
% ylabel('Cumulative Annual Precipitation (mm)');% xlabel('Ks KGE STi');
xlabel('Cumulative Annual Precipitation (mm)');
ylabel('Ks KGE STi');

%p=polyfit(STi_val,Precip_sort(:,5),1)

%figure; set(gcf,'color','w');sz=25;sz2=22;
subplot(3,2,2);
load Precip_sort.mat %pull precip values
load NFCache_KGEyearSTi_sort_Pcum.mat %pull STi values
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
%%scatter(STi_val,Precip_sort(:,1),sz,'filled','r'); hold on;
%s=scatter(STi_val,Precip_sort(:,1),sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
s=scatter(Precip_sort(:,1),STi_val,sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
clear STi_val;
load Noyo_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
%%scatter(STi_val,Precip_sort(:,2),sz,'filled','g'); hold on;
%s=scatter(STi_val,Precip_sort(:,2),sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
s=scatter(Precip_sort(:,2),STi_val,sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
clear STi_val;
load MFEel_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
%%scatter(STi_val,Precip_sort(:,3),sz,'filled','b'); hold on;
%s=scatter(STi_val,Precip_sort(:,3),sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
s=scatter(Precip_sort(:,3),STi_val,sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
clear STi_val;
load Salmon_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
%%scatter(STi_val,Precip_sort(:,4),sz,'filled','y'); hold on;
%s=scatter(STi_val,Precip_sort(:,4),sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
s=scatter(Precip_sort(:,4),STi_val,sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
clear STi_val;
load SFTrinity_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
%%scatter(STi_val,Precip_sort(:,5),sz,'filled','k'); hold on;
%s=scatter(STi_val,Precip_sort(:,5),sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
s=scatter(Precip_sort(:,5),STi_val,sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
load Bull_KGEyearSTi_sort_Pcum.mat %pull STi values
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
%s=scatter(STi_val,Precip_sort(:,6),sz,'filled','r');hold on;
s=scatter(Precip_sort(:,6),STi_val,sz,'filled','r');hold on;
%p=polyfit(STi_val,Precip_sort(:,6),1);
p=polyfit(Precip_sort(:,6),STi_val,1);
%y1=[p(2),(p(1)*1.2+p(2))];line2(1,1)=p(1);line2(1,2)=p(2);
y1=[p(2),(p(1)*3500+p(2))];line2(1,1)=p(1);line2(1,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,6),STi_val);
C2_1=C(1,2);
clear STi_val;
load Little_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
%s=scatter(STi_val,Precip_sort(:,7),sz,'filled','g'); hold on;
s=scatter(Precip_sort(:,7),STi_val,sz,'filled','g'); hold on;
%p=polyfit(STi_val,Precip_sort(:,7),1);
p=polyfit(Precip_sort(:,7),STi_val,1);
%y2=[p(2),(p(1)*1.2+p(2))]; line2(2,1)=p(1);line2(2,2)=p(2);
y2=[p(2),(p(1)*3500+p(2))]; line2(2,1)=p(1);line2(2,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,7),STi_val);
C2_2=C(1,2);
clear STi_val;
load VanDuzen_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
%s=scatter(STi_val,Precip_sort(:,8),sz,'filled','b'); hold on;
s=scatter(Precip_sort(:,8),STi_val,sz,'filled','b'); hold on;
%p=polyfit(STi_val,Precip_sort(:,8),1);
p=polyfit(Precip_sort(:,8),STi_val,1);
%y3=[p(2),(p(1)*1.2+p(2))];line2(3,1)=p(1);line2(3,2)=p(2);
y3=[p(2),(p(1)*3500+p(2))];line2(3,1)=p(1);line2(3,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,8),STi_val);
C2_3=C(1,2);
clear STi_val;
load Redwood_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
%s=scatter(STi_val,Precip_sort(:,9),sz,'filled','m'); hold on;
s=scatter(Precip_sort(:,9),STi_val,sz,'filled','m'); hold on;
%p=polyfit(STi_val,Precip_sort(:,9),1);
p=polyfit(Precip_sort(:,9),STi_val,1);
%y4=[p(2),(p(1)*1.2+p(2))];line2(4,1)=p(1);line2(4,2)=p(2);
y4=[p(2),(p(1)*3500+p(2))];line2(4,1)=p(1);line2(4,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,9),STi_val);
C2_4=C(1,2);
clear STi_val;
load Smith_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,2);%Ks
%s=scatter(STi_val,Precip_sort(:,10),sz,'filled','k'); hold on;
s=scatter(Precip_sort(:,10),STi_val,sz,'filled','k'); hold on;
%p=polyfit(STi_val,Precip_sort(:,10),1);
p=polyfit(Precip_sort(:,10),STi_val,1);
%y5=[p(2),(p(1)*1.2+p(2))];line2(5,1)=p(1);line2(5,2)=p(2);
y5=[p(2),(p(1)*3500+p(2))];line2(5,1)=p(1);line2(5,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,10),STi_val);
C2_5=C(1,2);
plot([0 3500],y1,'--r');hold on;
plot([0 3500],y2,'--g');hold on;
plot([0 3500],y3,'--b');hold on;
plot([0 3500],y4,'--m');hold on;
plot([0 3500],y5,'--k');hold on;
%legend('NF Cache','Noyo','MF Eel','Salmon','SF Trinity','Bull\newlineLittle\newlineVan Duzen\newlineRedwood\newlineSmith','Location','northeastoutside');
%legend('NF Cache','Noyo','MF Eel','Salmon','SF Trinity','Bull','Little','Van Duzen','Redwood','Smith','Location','northeastoutside');
legend('NF Cache','Noyo','MF Eel','Salmon','SF Trinity',['BUL R = ',num2str(C2_1)],['LIT R = ',num2str(C2_2)],['VDU R = ',num2str(C2_3)],['RED R = ',num2str(C2_4)],['SMI R = ',num2str(C2_5)],'Location','northeastoutside');
legend('boxoff'); grid; ylim([0 1]); xlim([0 3500]);
xlabel('Cumulative Annual Precipitation (mm)');
ylabel('Ks KGE STi');

%%%%%%%%%%%%%%%%%%%%% H par %%%%%%%%%%%%%%%%%%%%%%%%%%
%figure; set(gcf,'color','w');sz=25;sz2=22;
subplot(3,2,3);
load Precip_sort.mat %pull precip values
load Lopez_KGEyearSTi_sort_Pcum.mat %pull STi values
STi_val=KGEyearSTi_sort_Pcum(:,4);
%s=scatter(STi_val,Precip_sort(:,12),sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
s=scatter(Precip_sort(:,12),STi_val,sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
clear STi_val;
load Pescadero_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,4);
%s=scatter(STi_val,Precip_sort(:,13),sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
s=scatter(Precip_sort(:,13),STi_val,sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
clear STi_val;
load BigSur_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,4);
%s=scatter(STi_val,Precip_sort(:,15),sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
s=scatter(Precip_sort(:,15),STi_val,sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
clear STi_val;
load DelPuerto_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,4);
%s=scatter(STi_val,Precip_sort(:,16),sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
s=scatter(Precip_sort(:,16),STi_val,sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
clear STi_val;
load NFCache_KGEyearSTi_sort_Pcum.mat 
STi_val=KGEyearSTi_sort_Pcum(:,4);
%scatter(STi_val,Precip_sort(:,1),sz,'filled','r'); hold on;
scatter(Precip_sort(:,1),STi_val,sz,'filled','r'); hold on;
%p=polyfit(STi_val,Precip_sort(:,1),1);
p=polyfit(Precip_sort(:,1),STi_val,1);
%y1=[p(2),(p(1)*1+p(2))];line3(1,1)=p(1);line3(1,2)=p(2);
y1=[p(2),(p(1)*3500+p(2))];line3(1,1)=p(1);line3(1,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,1),STi_val);
C3_1=C(1,2);
clear STi_val;
load Noyo_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,4);
%scatter(STi_val,Precip_sort(:,2),sz,'filled','g'); hold on;
scatter(Precip_sort(:,2),STi_val,sz,'filled','g'); hold on;
%p=polyfit(STi_val,Precip_sort(:,2),1);
p=polyfit(Precip_sort(:,2),STi_val,1);
%y2=[p(2),(p(1)*1+p(2))];line3(2,1)=p(1);line3(2,2)=p(2);
y2=[p(2),(p(1)*3500+p(2))];line3(2,1)=p(1);line3(2,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,2),STi_val);
C3_2=C(1,2);
clear STi_val;
load MFEel_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,4);
%scatter(STi_val,Precip_sort(:,3),sz,'filled','b'); hold on;
scatter(Precip_sort(:,3),STi_val,sz,'filled','b'); hold on;
%p=polyfit(STi_val,Precip_sort(:,3),1);
p=polyfit(Precip_sort(:,3),STi_val,1);
%y3=[p(2),(p(1)*1+p(2))];line3(3,1)=p(1);line3(3,2)=p(2);
y3=[p(2),(p(1)*3500+p(2))];line3(3,1)=p(1);line3(3,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,3),STi_val);
C3_3=C(1,2);
clear STi_val;
load Salmon_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,4);
%scatter(STi_val,Precip_sort(:,4),sz,'filled','m'); hold on;
scatter(Precip_sort(:,4),STi_val,sz,'filled','m'); hold on;
%p=polyfit(STi_val,Precip_sort(:,4),1);
p=polyfit(Precip_sort(:,4),STi_val,1);
%y4=[p(2),(p(1)*1+p(2))];line3(4,1)=p(1);line3(4,2)=p(2);
y4=[p(2),(p(1)*3500+p(2))];line3(4,1)=p(1);line3(4,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,4),STi_val);
C3_4=C(1,2);
clear STi_val;
load SFTrinity_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,4);
%scatter(STi_val,Precip_sort(:,5),sz,'filled','k'); hold on;
scatter(Precip_sort(:,5),STi_val,sz,'filled','k'); hold on;
%p=polyfit(STi_val,Precip_sort(:,5),1);
p=polyfit(Precip_sort(:,5),STi_val,1);
%y5=[p(2),(p(1)*1+p(2))];line3(5,1)=p(1);line3(5,2)=p(2);
y5=[p(2),(p(1)*3500+p(2))];line3(5,1)=p(1);line3(5,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,5),STi_val);
C3_5=C(1,2);
plot([0 3500],y1,'--r');hold on;
plot([0 3500],y2,'--g');hold on;
plot([0 3500],y3,'--b');hold on;
plot([0 3500],y4,'--m');hold on;
plot([0 3500],y5,'--k');hold on;
%legend('Lopez','Pescadero','Big Sur','Del Puerto','NF Cache','Noyo','MF Eel','Salmon','SF Trinity','Location','northeastoutside');
legend('Lopez','Pescadero','Big Sur','Del Puerto',['NFC R = ',num2str(C3_1)],['NOY R = ',num2str(C3_2)],['MFE R = ',num2str(C3_3)],['SAL R = ',num2str(C3_4)],['SFT R = ',num2str(C3_5)],'Location','northeastoutside');
legend('boxoff'); grid; xlim([0 3500]); ylim([0 1]);
xlabel('Cumulative Annual Precipitation (mm)');
ylabel('H KGE STi');

%figure; set(gcf,'color','w');sz=25;sz2=22;
subplot(3,2,4);
load Precip_sort.mat %pull precip values
load NFCache_KGEyearSTi_sort_Pcum.mat %pull STi values
STi_val=KGEyearSTi_sort_Pcum(:,4);
%s=scatter(STi_val,Precip_sort(:,1),sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
s=scatter(Precip_sort(:,1),STi_val,sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
clear STi_val;
load Noyo_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,4);
s=scatter(STi_val,Precip_sort(:,2),sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
clear STi_val;
load MFEel_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,4);
%s=scatter(STi_val,Precip_sort(:,3),sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
s=scatter(Precip_sort(:,3),STi_val,sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
clear STi_val;
load Salmon_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,4);
%s=scatter(STi_val,Precip_sort(:,4),sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
s=scatter(Precip_sort(:,4),STi_val,sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
clear STi_val;
load SFTrinity_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,4);
%s=scatter(STi_val,Precip_sort(:,5),sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
s=scatter(Precip_sort(:,5),STi_val,sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
load Lopez_KGEyearSTi_sort_Pcum.mat 
STi_val=KGEyearSTi_sort_Pcum(:,4);
%s=scatter(STi_val,Precip_sort(:,12),sz,'filled','r');hold on;
s=scatter(Precip_sort(:,12),STi_val,sz,'filled','r');hold on;
%p=polyfit(STi_val,Precip_sort(:,12),1);
p=polyfit(Precip_sort(:,12),STi_val,1);
%y1=[p(2),(p(1)*1+p(2))];line4(1,1)=p(1);line4(1,2)=p(2);
y1=[p(2),(p(1)*3500+p(2))];line4(1,1)=p(1);line4(1,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,12),STi_val);
C4_1=C(1,2);
clear STi_val;
load Pescadero_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,4);
%s=scatter(STi_val,Precip_sort(:,13),sz,'filled','g'); hold on;
s=scatter(Precip_sort(:,13),STi_val,sz,'filled','g'); hold on;
%p=polyfit(STi_val,Precip_sort(:,13),1);
p=polyfit(Precip_sort(:,13),STi_val,1);
%y2=[p(2),(p(1)*1+p(2))]; line4(2,1)=p(1);line4(2,2)=p(2);
y2=[p(2),(p(1)*3500+p(2))]; line4(2,1)=p(1);line4(2,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,13),STi_val);
C4_2=C(1,2);
clear STi_val;
load BigSur_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,4);
%s=scatter(STi_val,Precip_sort(:,15),sz,'filled','b'); hold on;
s=scatter(Precip_sort(:,15),STi_val,sz,'filled','b'); hold on;
%p=polyfit(STi_val,Precip_sort(:,15),1);
p=polyfit(Precip_sort(:,15),STi_val,1);
%y3=[p(2),(p(1)*1+p(2))];line4(3,1)=p(1);line4(3,2)=p(2);
y3=[p(2),(p(1)*3500+p(2))];line4(3,1)=p(1);line4(3,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,15),STi_val);
C4_3=C(1,2);
clear STi_val;
load DelPuerto_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,4);
%s=scatter(STi_val,Precip_sort(:,16),sz,'filled','m'); hold on;
s=scatter(Precip_sort(:,16),STi_val,sz,'filled','m'); hold on;
%p=polyfit(STi_val,Precip_sort(:,16),1);
p=polyfit(Precip_sort(:,16),STi_val,1);
%y4=[p(2),(p(1)*1+p(2))];line4(4,1)=p(1);line4(4,2)=p(2);
y4=[p(2),(p(1)*3500+p(2))];line4(4,1)=p(1);line4(4,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,16),STi_val);
C4_4=C(1,2);
plot([0 3500],y1,'--r');hold on;
plot([0 3500],y2,'--g');hold on;
plot([0 3500],y3,'--b');hold on;
%plot([0 1],y4,'--m');hold on;
%legend('NF Cache','Noyo','MF Eel','Salmon','SF Trinity','Lopez','Pescadero','Big Sur','Del Puerto','Location','northeastoutside');
legend('NF Cache','Noyo','MF Eel','Salmon','SF Trinity',['LOP R = ',num2str(C4_1)],['PES R = ',num2str(C4_2)],['BSU R = ',num2str(C4_3)],'DPU','Location','northeastoutside');
legend('boxoff'); grid; xlim([0 3500]); ylim([0 1]);
xlabel('Cumulative Annual Precipitation (mm)');
ylabel('H KGE STi');

%%%%%%%%%%%%%%% B par %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure; set(gcf,'color','w');sz=25;sz2=22;
subplot(3,2,5);
load Precip_sort.mat %pull precip values
load Lopez_KGEyearSTi_sort_Pcum.mat %pull STi values
STi_val=KGEyearSTi_sort_Pcum(:,5);
%s=scatter(STi_val,Precip_sort(:,12),sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
s=scatter(Precip_sort(:,12),STi_val,sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
clear STi_val;
load Pescadero_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,5);
%s=scatter(STi_val,Precip_sort(:,13),sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
s=scatter(Precip_sort(:,13),STi_val,sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
clear STi_val;
load BigSur_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,5);
%s=scatter(STi_val,Precip_sort(:,15),sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
s=scatter(Precip_sort(:,15),STi_val,sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
clear STi_val;
load DelPuerto_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,5);
%s=scatter(STi_val,Precip_sort(:,16),sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
s=scatter(Precip_sort(:,16),STi_val,sz2,[0.5 0.5 0.5],'filled'); hold on;alpha(s,.5);
clear STi_val;
load NFCache_KGEyearSTi_sort_Pcum.mat 
STi_val=KGEyearSTi_sort_Pcum(:,5);
%scatter(STi_val,Precip_sort(:,1),sz,'filled','r'); hold on;
scatter(Precip_sort(:,1),STi_val,sz,'filled','r'); hold on;
%p=polyfit(STi_val,Precip_sort(:,1),1);
p=polyfit(Precip_sort(:,1),STi_val,1);
%y1=[p(2),(p(1)+p(2))];line5(1,1)=p(1);line5(1,2)=p(2);
y1=[p(2),(p(1)*3500+p(2))];line5(1,1)=p(1);line5(1,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,1),STi_val);
C5_1=C(1,2);
clear STi_val;
load Noyo_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,5);
%scatter(STi_val,Precip_sort(:,2),sz,'filled','g'); hold on;
scatter(Precip_sort(:,2),STi_val,sz,'filled','g'); hold on;
%p=polyfit(STi_val,Precip_sort(:,2),1);
p=polyfit(Precip_sort(:,2),STi_val,1);
%y2=[p(2),(p(1)+p(2))];line5(2,1)=p(1);line5(2,2)=p(2);
y2=[p(2),(p(1)*3500+p(2))];line5(2,1)=p(1);line5(2,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,2),STi_val);
C5_2=C(1,2);
clear STi_val;
load MFEel_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,5);
%scatter(STi_val,Precip_sort(:,3),sz,'filled','b'); hold on;
scatter(Precip_sort(:,3),STi_val,sz,'filled','b'); hold on;
%p=polyfit(STi_val,Precip_sort(:,3),1);
p=polyfit(Precip_sort(:,3),STi_val,1);
%y3=[p(2),(p(1)+p(2))];line5(3,1)=p(1);line5(3,2)=p(2);
y3=[p(2),(p(1)*3500+p(2))];line5(3,1)=p(1);line5(3,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,3),STi_val);
C5_3=C(1,2);
clear STi_val;
load Salmon_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,5);
%scatter(STi_val,Precip_sort(:,4),sz,'filled','m'); hold on;
scatter(Precip_sort(:,4),STi_val,sz,'filled','m'); hold on;
%p=polyfit(STi_val,Precip_sort(:,4),1);
p=polyfit(Precip_sort(:,4),STi_val,1);
%y4=[p(2),(p(1)+p(2))];line5(4,1)=p(1);line5(4,2)=p(2);
y4=[p(2),(p(1)*3500+p(2))];line5(4,1)=p(1);line5(4,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,4),STi_val);
C5_4=C(1,2);
clear STi_val;
load SFTrinity_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,5);
%scatter(STi_val,Precip_sort(:,5),sz,'filled','k'); hold on;
scatter(Precip_sort(:,5),STi_val,sz,'filled','k'); hold on;
%p=polyfit(STi_val,Precip_sort(:,5),1);
p=polyfit(Precip_sort(:,5),STi_val,1);
%y5=[p(2),(p(1)+p(2))];line5(5,1)=p(1);line5(5,2)=p(2);
y5=[p(2),(p(1)*3500+p(2))];line5(5,1)=p(1);line5(5,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,5),STi_val);
C5_5=C(1,2);
plot([0 3500],y1,'--r');hold on;
plot([0 3500],y2,'--g');hold on;
plot([0 3500],y3,'--b');hold on;
plot([0 3500],y4,'--m');hold on;
plot([0 3500],y5,'--k');hold on;
%legend('Lopez','Pescadero','Big Sur','Del Puerto','NF Cache','Noyo','MF Eel','Salmon','SF Trinity','Location','northeastoutside');
legend('Lopez','Pescadero','Big Sur','Del Puerto',['NFC R = ',num2str(C5_1)],['NOY R = ',num2str(C5_2)],['MFE R = ',num2str(C5_3)],['SAL R = ',num2str(C5_4)],['SFT R = ',num2str(C5_5)],'Location','northeastoutside');
legend('boxoff'); grid; xlim([0 3500]); ylim([0 1]);
xlabel('Cumulative Annual Precipitation (mm)');
ylabel('B KGE STi');

%figure; set(gcf,'color','w');sz=25;sz2=22;
subplot(3,2,6);
load Precip_sort.mat %pull precip values
load NFCache_KGEyearSTi_sort_Pcum.mat %pull STi values
STi_val=KGEyearSTi_sort_Pcum(:,5);
%s=scatter(STi_val,Precip_sort(:,1),sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
s=scatter(Precip_sort(:,1),STi_val,sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
clear STi_val;
load Noyo_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,5);
%s=scatter(STi_val,Precip_sort(:,2),sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
s=scatter(Precip_sort(:,2),STi_val,sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
clear STi_val;
load MFEel_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,5);
%s=scatter(STi_val,Precip_sort(:,3),sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
s=scatter(Precip_sort(:,3),STi_val,sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
clear STi_val;
load Salmon_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,5);
%s=scatter(STi_val,Precip_sort(:,4),sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
s=scatter(Precip_sort(:,4),STi_val,sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
clear STi_val;
load SFTrinity_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,5);
%s=scatter(STi_val,Precip_sort(:,5),sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
s=scatter(Precip_sort(:,5),STi_val,sz2,[0.5 0.5 0.5],'filled');hold on;alpha(s,.5);
load Lopez_KGEyearSTi_sort_Pcum.mat 
STi_val=KGEyearSTi_sort_Pcum(:,5);
%s=scatter(STi_val,Precip_sort(:,12),sz,'filled','r');hold on;
s=scatter(Precip_sort(:,12),STi_val,sz,'filled','r');hold on;
%p=polyfit(STi_val,Precip_sort(:,12),1);
p=polyfit(Precip_sort(:,12),STi_val,1);
%y1=[p(2),(p(1)+p(2))];line6(1,1)=p(1);line6(1,2)=p(2);
y1=[p(2),(p(1)*3500+p(2))];line6(1,1)=p(1);line6(1,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,12),STi_val);
C6_1=C(1,2);
clear STi_val;
load Pescadero_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,5);
%s=scatter(STi_val,Precip_sort(:,13),sz,'filled','g'); hold on;
s=scatter(Precip_sort(:,13),STi_val,sz,'filled','g'); hold on;
%p=polyfit(STi_val,Precip_sort(:,13),1);
p=polyfit(Precip_sort(:,13),STi_val,1);
%y2=[p(2),(p(1)+p(2))]; line6(2,1)=p(1);line6(2,2)=p(2);
y2=[p(2),(p(1)*3500+p(2))]; line6(2,1)=p(1);line6(2,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,13),STi_val);
C6_2=C(1,2);
clear STi_val;
load BigSur_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,5);
%s=scatter(STi_val,Precip_sort(:,15),sz,'filled','b'); hold on;
s=scatter(Precip_sort(:,15),STi_val,sz,'filled','b'); hold on;
%p=polyfit(STi_val,Precip_sort(:,15),1);
p=polyfit(Precip_sort(:,15),STi_val,1);
%y3=[p(2),(p(1)+p(2))];line6(3,1)=p(1);line6(3,2)=p(2);
y3=[p(2),(p(1)*3500+p(2))];line6(3,1)=p(1);line6(3,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,15),STi_val);
C6_3=C(1,2);
clear STi_val;
load DelPuerto_KGEyearSTi_sort_Pcum.mat
STi_val=KGEyearSTi_sort_Pcum(:,5);
%s=scatter(STi_val,Precip_sort(:,16),sz,'filled','m'); hold on;
s=scatter(Precip_sort(:,16),STi_val,sz,'filled','m'); hold on;
%p=polyfit(STi_val,Precip_sort(:,16),1);
p=polyfit(Precip_sort(:,16),STi_val,1);
%y4=[p(2),(p(1)+p(2))];line6(4,1)=p(1);line6(4,2)=p(2);
y4=[p(2),(p(1)*3500+p(2))];line6(4,1)=p(1);line6(4,2)=p(2);
%C=corrcoef(STi_val,Precip_sort(:,1));
C=corrcoef(Precip_sort(:,16),STi_val);
C6_4=C(1,2);
plot([0 3500],y1,'--r');hold on;
plot([0 3500],y2,'--g');hold on;
plot([0 3500],y3,'--b');hold on;
%plot([0 0.8],y4,'--m');hold on;
%legend('NF Cache','Noyo','MF Eel','Salmon','SF Trinity','Lopez','Pescadero','Big Sur','Del Puerto','Location','northeastoutside');
legend('NF Cache','Noyo','MF Eel','Salmon','SF Trinity',['LOP R = ',num2str(C6_1)],['PES R = ',num2str(C6_2)],['BSU R = ',num2str(C6_3)],'DPU','Location','northeastoutside');
legend('boxoff'); grid; xlim([0 3500]); ylim([0 1]);
xlabel('Cumulative Annual Precipitation (mm)');
ylabel('B KGE STi');
