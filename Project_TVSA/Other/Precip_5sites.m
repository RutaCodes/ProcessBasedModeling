%Ruta Basijokaite

my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

Stream_val=zeros(12418,5);
load big_sur_Streamflow.mat
Stream_val(:,1)=Streamflow;
load SFTrinity_Streamflow.mat
Stream_val(:,2)=Streamflow;
load redwood_Streamflow.mat
Stream_val(:,3)=Streamflow;
load trinity_Streamflow.mat
Stream_val(:,4)=Streamflow(275:12692);
load pitman_Streamflow.mat
Stream_val(:,5)=Streamflow;

da = 0; %annual averages
precip_vals=zeros(12418,5);
% Prec_WatY=zeros(33,365);
for x=1:5
    switch x
        case 1 % Group 1 (H + B)
            load Data_BigSur.mat
            dataset = Data_BigSur;
            year = dataset(275:12692,1);
            month = dataset(275:12692,2);
            day = dataset(275:12692,3);
            precip=dataset(275:12692,6);
            tempaver=(dataset(275:12692,9)+ dataset(275:12692,10))/2;
        case 2 %Group 2 (Ks + H + B)
            load Data_SFTrinity.mat
            dataset = Data_SFTrinity;
            precip=dataset(275:12692,6);
            tempaver=(dataset(275:12692,9)+ dataset(275:12692,10))/2;
        case 3 %Group 3 (Ks)
            load Data_Redwood.mat
            dataset = Data_Redwood;
            precip=dataset(275:12692,6);
            tempaver=(dataset(275:12692,9)+ dataset(275:12692,10))/2;
        case 4 %Group 4 (Multiple)
            load Data_Trinity_R.mat
            dataset = Data_Trinity_R;
            precip=dataset(275:12692,6);
            tempaver=(dataset(275:12692,9)+ dataset(275:12692,10))/2;
        case 5 %Group 5 (Snow)
            load Data_Pitman.mat
            dataset = Data_Pitman;
            precip=dataset(275:12692,6);
            tempaver=(dataset(275:12692,9)+ dataset(275:12692,10))/2;
    end
    
    precip_vals(:,x)=precip;
    for j=2004:2013 %1980:2014
        [a, ~]=find(year==j & month == 10 & day == 1);
        [b, ~]=find(year==(j+1) & month == 9 & day == 30);
        
        da=da+1;
        Prec_WatY_aver(da,x)=mean(precip(a:b,1));
        Prec_WatY_cum(da,x)=sum(precip(a:b,1));
        AT_aver(da,x)=mean(tempaver(a:b,1));
    end
    da=0;
    
end

% figure; set(gcf,'color','w');
% for i=1:5
%    plot(1:10,Prec_WatY_cum(:,i));hold on;
% end
% ylabel('Cum. P'); xlim([1 10]);
% xticks([2 3 4 5 6 7 8 9]);
% xticklabels({'2006','2007','2008','2009','2010','2011','2012','2013'});
% legend('BSU','SFT','RED','TRI','PIT');

color=zeros(5,1);
str = '#E41A1C';
color(1,1:3) = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
str = '#FF7F00';
color(2,1:3) = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
str = '#4DAF4A';
color(3,1:3) = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
str = '#984EA3';
color(4,1:3) = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
str = '#377EB8';
color(5,1:3) = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;

%Dry year vs wet year hydrographs
figure; set(gcf,'color','w');
subplot (3, 2, [1 2]);%Wet year -2006
[a, ~]=find(year==2005 & month == 10 & day == 1);
[b, ~]=find(year==2006 & month == 9 & day == 30);
for i=1:5
   plot(1:365,Stream_val(a:b,i),'Color',color(i,:),'LineWidth',1.5);hold on;
end
ylabel('Streamflow'); xlim([1 365]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

subplot (3, 2, [3 4]);
for i=1:5
   plot(1:10,Prec_WatY_cum(:,i),'Color',color(i,:),'LineWidth',1.5);hold on;
end
ylabel('Cum. P'); xlim([1 10]);
xticks([2 3 4 5 6 7 8 9]);
xticklabels({'2006','2007','2008','2009','2010','2011','2012','2013'});
legend('BSU','SFT','RED','TRI','PIT');

subplot (3, 2, [5 6]);%Dry year -2014
[a, ~]=find(year==2013 & month == 10 & day == 1);
[b, ~]=find(year==2014 & month == 9 & day == 30);
for i=1:5
   plot(1:365,Stream_val(a:b,i),'Color',color(i,:),'LineWidth',1.5);hold on;
end
ylabel('Streamflow'); xlim([1 365]); ylim([0 80]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

%Dry year
figure; set(gcf,'color','w');
subplot(5,1,1); %BSU
load big_sur_sub_sens_mo_run5000_snow_test1s.mat;
load big_sur_Streamflow.mat
[a, ~]=find(year==2013 & month == 10 & day == 1);%dry year
[b, ~]=find(year==2014 & month == 8 & day == 31);
%plotyy(1:335,Stream_val(a:b,1),1:335,precip_vals(a:b,1));hold on;
%plotyy(1:335,Stream_val(a:b,1),1:335,Dry_year_RMSE(:,1));hold on;
yyaxis left
bar(1:335,precip_vals(a:b,1),'FaceColor',color(3,:));hold on; ylim([0 50]);
plot(1:335,Stream_val(a:b,1),'Color',color(5,:),'LineWidth',1.7);
yyaxis right 
plot(1:335,Dry_year_RMSE(:,1),'k','LineWidth',1.5);ylim([0 1]);
% plotyy(1:335,precip_vals(a:b,1),1:335,Dry_year_RMSE(:,1));hold on;
%plotyy(1:335,Stream_val(a:b,1),1:335,Dry_year_RMSE(:,1),'Color',color(5,:),'LineWidth',1.5);hold on;
%plot(Dry_year_RMSE(:,1),'k','LineWidth',1.5);hold on;xlim([1 335]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);xlim([1 335]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
title('Dry year'); %ylabel('BSU');

subplot(5,1,2);
load sf_trinity_sub_sens_mo_run5000_snow_test1s.mat;
load SFTrinity_Streamflow.mat
%plotyy(1:335,precip_vals(a:b,2),1:335,Dry_year_RMSE(:,2));hold on;
yyaxis left
bar(1:335,precip_vals(a:b,2),'FaceColor',color(3,:));hold on; ylim([0 50]);
plot(1:335,Stream_val(a:b,2),'Color',color(5,:),'LineWidth',1.7);
yyaxis right 
plot(1:335,Dry_year_RMSE(:,2),'k','LineWidth',1.5);ylim([0 1]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);xlim([1 335]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

subplot(5,1,3);
load redwood_sub_sens_mo_run5000_snow_test1s.mat;
load redwood_Streamflow.mat
%plotyy(1:335,precip_vals(a:b,2),1:335,Dry_year_RMSE(:,2));hold on;
yyaxis left
bar(1:335,precip_vals(a:b,3),'FaceColor',color(3,:));hold on; ylim([0 50]);
plot(1:335,Stream_val(a:b,3),'Color',color(5,:),'LineWidth',1.7);
yyaxis right 
plot(1:335,Dry_year_RMSE(:,3),'k','LineWidth',1.5);ylim([0 1]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);xlim([1 335]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

subplot(5,1,4);
load trinity_sub_sens_mo_run5000_snow_test1s.mat;
load trinity_Streamflow.mat
%plotyy(1:335,precip_vals(a:b,2),1:335,Dry_year_RMSE(:,2));hold on;
yyaxis left
bar(1:335,precip_vals(a:b,4),'FaceColor',color(3,:));hold on; ylim([0 50]);
plot(1:335,Stream_val(a:b,4),'Color',color(5,:),'LineWidth',1.7);
yyaxis right 
plot(1:335,Dry_year_RMSE(:,4),'k','LineWidth',1.5);ylim([0 1]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);xlim([1 335]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

subplot(5,1,5);
load pitman_sub_sens_mo_run5000_snow_test1s.mat;
load pitman_Streamflow.mat
%plotyy(1:335,precip_vals(a:b,2),1:335,Dry_year_RMSE(:,2));hold on;
yyaxis left
bar(1:335,precip_vals(a:b,5),'FaceColor',color(3,:));hold on; ylim([0 50]);
plot(1:335,Stream_val(a:b,5),'Color',color(5,:),'LineWidth',1.7);
yyaxis right 
plot(1:335,Dry_year_RMSE(:,5),'k','LineWidth',1.5);ylim([0 1]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);xlim([1 335]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

%Wet year
figure; set(gcf,'color','w');
subplot(5,1,1); %BSU
load big_sur_sub_sens_mo_run5000_snow_test1s.mat;
load big_sur_Streamflow.mat
[a, ~]=find(year==2005 & month == 10 & day == 1);%dry year
[b, ~]=find(year==2006 & month == 8 & day == 31);
%plotyy(1:335,Stream_val(a:b,1),1:335,precip_vals(a:b,1));hold on;
%plotyy(1:335,Stream_val(a:b,1),1:335,Dry_year_RMSE(:,1));hold on;
yyaxis left
bar(1:335,precip_vals(a:b,1),'FaceColor',color(3,:));hold on; ylim([0 100]);
plot(1:335,Stream_val(a:b,1),'Color',color(5,:),'LineWidth',1.7);
yyaxis right 
plot(1:335,Wet_year_RMSE(:,1),'k','LineWidth',1.5);ylim([0 1]);
% plotyy(1:335,precip_vals(a:b,1),1:335,Dry_year_RMSE(:,1));hold on;
%plotyy(1:335,Stream_val(a:b,1),1:335,Dry_year_RMSE(:,1),'Color',color(5,:),'LineWidth',1.5);hold on;
%plot(Dry_year_RMSE(:,1),'k','LineWidth',1.5);hold on;xlim([1 335]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);xlim([1 335]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
title('Wet year'); %ylabel('BSU');

subplot(5,1,2);
load sf_trinity_sub_sens_mo_run5000_snow_test1s.mat;
load SFTrinity_Streamflow.mat
%plotyy(1:335,precip_vals(a:b,2),1:335,Dry_year_RMSE(:,2));hold on;
yyaxis left
bar(1:335,precip_vals(a:b,2),'FaceColor',color(3,:));hold on; ylim([0 100]);
plot(1:335,Stream_val(a:b,2),'Color',color(5,:),'LineWidth',1.7);
yyaxis right 
plot(1:335,Wet_year_RMSE(:,2),'k','LineWidth',1.5);ylim([0 1]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);xlim([1 335]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

subplot(5,1,3);
load redwood_sub_sens_mo_run5000_snow_test1s.mat;
load redwood_Streamflow.mat
%plotyy(1:335,precip_vals(a:b,2),1:335,Dry_year_RMSE(:,2));hold on;
yyaxis left
bar(1:335,precip_vals(a:b,3),'FaceColor',color(3,:));hold on; ylim([0 100]);
plot(1:335,Stream_val(a:b,3),'Color',color(5,:),'LineWidth',1.7);
yyaxis right 
plot(1:335,Wet_year_RMSE(:,3),'k','LineWidth',1.5);ylim([0 1]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);xlim([1 335]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

subplot(5,1,4);
load trinity_sub_sens_mo_run5000_snow_test1s.mat;
load trinity_Streamflow.mat
%plotyy(1:335,precip_vals(a:b,2),1:335,Dry_year_RMSE(:,2));hold on;
yyaxis left
bar(1:335,precip_vals(a:b,4),'FaceColor',color(3,:));hold on; ylim([0 100]);
plot(1:335,Stream_val(a:b,4),'Color',color(5,:),'LineWidth',1.7);
yyaxis right 
plot(1:335,Wet_year_RMSE(:,4),'k','LineWidth',1.5);ylim([0 1]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);xlim([1 335]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

subplot(5,1,5);
load pitman_sub_sens_mo_run5000_snow_test1s.mat;
load pitman_Streamflow.mat
%plotyy(1:335,precip_vals(a:b,2),1:335,Dry_year_RMSE(:,2));hold on;
yyaxis left
bar(1:335,precip_vals(a:b,5),'FaceColor',color(3,:));hold on; ylim([0 100]);
plot(1:335,Stream_val(a:b,5),'Color',color(5,:),'LineWidth',1.7);
yyaxis right 
plot(1:335,Wet_year_RMSE(:,5),'k','LineWidth',1.5);ylim([0 1]);
xticks([32 62 93 124 152 183 213 244 274 305 336]);xlim([1 335]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});


% % xlim([1 335]);ylim([0 1]);
% % xticks([32 62 93 124 152 183 213 244 274 305 336]);
% % xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
% % legend('Wet year', 'Dry year','Location','southeast'); legend('boxoff');
% % ylabel('BSU');title('STi');
% % subplot(5,1,2); %SFT
% % load sf_trinity_sub_sens_mo_run5000_snow_test1s.mat;
% % plot(RSME_moSTi((336:671),2),'b');hold on;%wet year
% % plot(RSME_moSTi(((N1-335):N1),2),'r');hold on;%dry year
% % xlim([1 335]);ylim([0 1]);
% % xticks([32 62 93 124 152 183 213 244 274 305 336]);
% % xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
% % ylabel('SFT');
% % subplot(5,1,3); %RED
% % load redwood_sub_sens_mo_run5000_snow_test1s.mat;
% % plot(RSME_moSTi((336:671),2),'b');hold on;%wet year
% % plot(RSME_moSTi(((N1-335):N1),2),'r');hold on;%dry year
% % xlim([1 335]);ylim([0 1]);
% % xticks([32 62 93 124 152 183 213 244 274 305 336]);
% % xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
% % ylabel('RED');
% % %legend('Wet year', 'Dry year','Location','northeastoutside'); legend('boxoff');
% % subplot(5,1,4); %TRI
% % load trinity_sub_sens_mo_run5000_snow_test1s.mat;
% % plot(RSME_moSTi((336:671),2),'b');hold on;%wet year
% % plot(RSME_moSTi(((N1-335):N1),2),'r');hold on;%dry year
% % xlim([1 335]);ylim([0 1]);
% % xticks([32 62 93 124 152 183 213 244 274 305 336]);
% % xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
% % ylabel('TRI');
% % subplot(5,1,5);%PIT
% % load pitman_sub_sens_mo_run5000_snow_test1s.mat;
% % plot(RSME_moSTi((336:671),2),'b');hold on;%wet year
% % plot(RSME_moSTi(((N1-335):N1),2),'r');hold on;%dry year
% % xlim([1 335]);ylim([0 1]);
% % xticks([32 62 93 124 152 183 213 244 274 305 336]);
% % xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
% % ylabel('PIT');

% figure; set(gcf,'color','w');
% subplot(5,1,1); %BSU
% load big_sur_sub_sens_mo_run5000_snow_test1s.mat;
% load big_sur_Streamflow.mat
% plot(RSME_moSTi((336:671),2),'b');hold on;%wet year
% [a, ~]=find(year==2013 & month == 10 & day == 1);
% [b, ~]=find(year==2014 & month == 8 & day == 31);
% plot(RSME_moSTi(((N1-335):N1),2),'r');hold on;%dry year
% xlim([1 335]);ylim([0 1]);
% xticks([32 62 93 124 152 183 213 244 274 305 336]);
% xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
% legend('Wet year', 'Dry year','Location','southeast'); legend('boxoff');
% ylabel('BSU');title('STi');
% subplot(5,1,2); %SFT
% load sf_trinity_sub_sens_mo_run5000_snow_test1s.mat;
% plot(RSME_moSTi((336:671),2),'b');hold on;%wet year
% plot(RSME_moSTi(((N1-335):N1),2),'r');hold on;%dry year
% xlim([1 335]);ylim([0 1]);
% xticks([32 62 93 124 152 183 213 244 274 305 336]);
% xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
% ylabel('SFT');
% subplot(5,1,3); %RED
% load redwood_sub_sens_mo_run5000_snow_test1s.mat;
% plot(RSME_moSTi((336:671),2),'b');hold on;%wet year
% plot(RSME_moSTi(((N1-335):N1),2),'r');hold on;%dry year
% xlim([1 335]);ylim([0 1]);
% xticks([32 62 93 124 152 183 213 244 274 305 336]);
% xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
% ylabel('RED');
% %legend('Wet year', 'Dry year','Location','northeastoutside'); legend('boxoff');
% subplot(5,1,4); %TRI
% load trinity_sub_sens_mo_run5000_snow_test1s.mat;
% plot(RSME_moSTi((336:671),2),'b');hold on;%wet year
% plot(RSME_moSTi(((N1-335):N1),2),'r');hold on;%dry year
% xlim([1 335]);ylim([0 1]);
% xticks([32 62 93 124 152 183 213 244 274 305 336]);
% xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
% ylabel('TRI');
% subplot(5,1,5);%PIT
% load pitman_sub_sens_mo_run5000_snow_test1s.mat;
% plot(RSME_moSTi((336:671),2),'b');hold on;%wet year
% plot(RSME_moSTi(((N1-335):N1),2),'r');hold on;%dry year
% xlim([1 335]);ylim([0 1]);
% xticks([32 62 93 124 152 183 213 244 274 305 336]);
% xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
% ylabel('PIT');

% WS_name=["BSU","SFT","RED","TRI","PIT"]
% figure; set(gcf,'color','w');
% for i=1:5
%    subplot (1, 5, i);
%    plot(AT_aver(:,i),1:33);hold on;
%    xlabel('Aver AT'); ylim([1 33]);
%    title(sprintf('%s',WS_name(i)));
%    yticks([5 10 15 20 25 30]);
%    yticklabels({'1985','1990','1995','2000','2005','2010'});
% end
% %ylabel('Cumulative precipitation');% xlim([1 33]);
% % xticks([1189 3015 4841 6667 8494 10320]);
% % yticks([5 10 15 20 25 30]);
% % yticklabels({'1985','1990','1995','2000','2005','2010'});
% %legend('Bear','Blackwood','M. Happy','M.Pohono','Trinity');
% 
% figure; set(gcf,'color','w');
% plot(Prec_WatY_cum);
% ylabel('Cumulative precipitation'); xlim([1 33]);
% % xticks([1189 3015 4841 6667 8494 10320]);
% xticks([5 10 15 20 25 30]);
% xticklabels({'1985','1990','1995','2000','2005','2010'});
% legend('Bear','Blackwood','M. Happy','M.Pohono','Trinity');
