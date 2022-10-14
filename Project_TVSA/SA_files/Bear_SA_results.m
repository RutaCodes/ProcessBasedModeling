%Loading data variables and creating data figures
clear all;
%Checking KGE and SFDCE run values 
load bear_lake_hymod_5000hyd_objFun_snow_Newrun1.mat

%Calculating top percentage of KGE values 
per=1; %top percent
Per_len=length(KGEyear)*0.01*per;
KGEtop_values_year=zeros(Per_len,33);
KGEtop_index_year=zeros(Per_len,33);
for i=1:33
    KGEyear_val=KGEyear(:,i);
    [a,b]=sort(KGEyear_val,'descend'); %a values, b index
    KGEtop_values_year(:,i)=a(1:(length(KGEyear_val)*0.01*per));%top per percent
    KGEtop_index_year(:,i)=b(1:(length(KGEyear_val)*0.01*per));%top per percent
end

[a1,b1]=sort(KGE_whole,'descend'); %a values, b index
KGEtop_values_whole=a1(1:(length(KGEyear_val)*0.01*per));%top per percent
KGEtop_index_whole=b1(1:(length(KGEyear_val)*0.01*per));%top per percent

%Finding maximum and average values for top percent model runs
Max_KGE_whole=max(KGEtop_values_whole);%top percentage KGE values
Max_KGE_year=max(KGEtop_values_year);
Aver_KGE_whole=mean(KGEtop_values_whole);
Aver_KGE_year=mean(KGEtop_values_year);
Med_KGE_whole=median(KGEtop_values_whole);
Med_KGE_year=median(KGEtop_values_year);

%Figure 1 - obs vs Sim
load bear_lake_SA_5000sim_val_snow_Newrun1.mat % best run
load bear_Streamflow.mat 
figure; set(gcf,'color','w');
plot(Best_KGE_run); hold on; xlim([1 12418]);
plot(Streamflow);legend('Simulated','Observed');
xticks([1554 3380 5206 7032 8859 10685]);
xticklabels({'1985','1990','1995','2000','2005','2010'});
title('Best KGE value'); %xlim([1 365]);

%Figure 2 - SA heat maps
load bear_lake_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat
load bear_lake_sens_yr_run5000_snow_Newrun1.mat
figure; set(gcf,'color','w');
subplot(2,2,1);imagesc(KGEyearSi);
title('KGE Si');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});hold on;
subplot(2,2,2);imagesc(SFDCE_low_yearSi);
title('SFDCE low Si');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});hold on;
subplot(2,2,3);imagesc(KGEyearSTi);
title('KGE STi');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});hold on;
subplot(2,2,4);imagesc(SFDCE_low_yearSTi);
title('SFDCE low STi');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([5 10 15 20 25 30]);
yticklabels({'1985','1990','1995','2000','2005','2010'});

%Figure 3 - SA boxplots
figure; set(gcf,'color','w');
subplot(2,2,1);boxplot(KGEyearSi);
title('KGE Si'); ylim([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot(2,2,2);boxplot(SFDCE_low_yearSi);
title('SFDCE low Si'); ylim([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot(2,2,3);boxplot(KGEyearSTi);
title('KGE STi');ylim([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot(2,2,4);boxplot(SFDCE_low_yearSTi);
title('SFDCE low STi');ylim([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});

%Figure 4 - Monthly heat maps
load bear_lake_sens_yr_hyd_mo_SFDCE_run5000_snow_Newrun1.mat
load bear_lake_sens_mo_run5000_snow_Newrun1.mat
figure; set(gcf,'color','w');
subplot(2,2,1);imagesc(KGEmoSi);
title('KGE Si');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([40 100 160 220 280 340]);
yticklabels({'1985','1990','1995','2000','2005','2010'});hold on;
subplot(2,2,2);imagesc(SFDCE_low_mo_yearSi);
title('SFDCE low Si');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([40 100 160 220 280 340]);
yticklabels({'1985','1990','1995','2000','2005','2010'});hold on;
subplot(2,2,3);imagesc(KGEmoSTi);
title('KGE STi');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([40 100 160 220 280 340]);
yticklabels({'1985','1990','1995','2000','2005','2010'});hold on;
subplot(2,2,4);imagesc(SFDCE_low_mo_yearSTi);
title('SFDCE low STi');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([40 100 160 220 280 340]);
yticklabels({'1985','1990','1995','2000','2005','2010'});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Figure 5,6,7 - sorting Si & STi by AT and P
load Data_Bear_Lake.mat % P and AT data
dataset=Data_Bear_Lake(275:12692,:);
year = dataset(:,1);
month = dataset(:,2);
day = dataset(:,3);
precip=dataset(:,6);
tempaver=(dataset(:,9)+ dataset(:,10))/2;%calculating average
count=0;
AT_ann_val=zeros(33,1);
P_ann_val_mean=zeros(33,1);
P_ann_val_cum=zeros(33,1);
%calculate annual averages
for i=1981:2013
    [ind1,~]=find(year==i & month==10 & day ==1);
    [ind2,~]=find(year==(i+1) & month==9 & day ==30);
    
    count=count+1;
    
    AT_ann_val(count)=mean(tempaver(ind1:ind2));
    P_ann_val_mean(count)=mean(precip(ind1:ind2));
    P_ann_val_cum(count)=sum(precip(ind1:ind2));
    
end

[AT_val_sort,AT_ind_sort]=sort(AT_ann_val,'descend');
[P_mean_val_sort,P_mean_ind_sort]=sort(P_ann_val_mean,'descend');
[P_cum_val_sort,P_cum_ind_sort]=sort(P_ann_val_cum,'descend');

for i=1:10
    KGEyearSi_sort_AT(:,i)=KGEyearSi(AT_ind_sort,i);
    KGEyearSTi_sort_AT(:,i)=KGEyearSTi(AT_ind_sort,i);
    KGEyearSi_sort_Pcum(:,i)=KGEyearSi(P_cum_ind_sort,i);
    KGEyearSTi_sort_Pcum(:,i)=KGEyearSTi(P_cum_ind_sort,i);
    KGEyearSi_sort_Pmean(:,i)=KGEyearSi(P_mean_ind_sort,i);
    KGEyearSTi_sort_Pmean(:,i)=KGEyearSTi(P_mean_ind_sort,i);
    
    SFDCE_low_yearSi_sort_AT(:,i)=SFDCE_low_yearSi(AT_ind_sort,i);
    SFDCE_low_yearSTi_sort_AT(:,i)=SFDCE_low_yearSTi(AT_ind_sort,i);
    SFDCE_low_yearSi_sort_Pcum(:,i)=SFDCE_low_yearSi(P_cum_ind_sort,i);
    SFDCE_low_yearSTi_sort_Pcum(:,i)=SFDCE_low_yearSTi(P_cum_ind_sort,i);
    SFDCE_low_yearSi_sort_Pmean(:,i)=SFDCE_low_yearSi(P_mean_ind_sort,i);
    SFDCE_low_yearSTi_sort_Pmean(:,i)=SFDCE_low_yearSTi(P_mean_ind_sort,i);
end

%Heat map with AT sorting
figure; set(gcf,'color','w');
subplot(2,2,1);imagesc(KGEyearSi_sort_AT);
title('KGE Si');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot(2,2,2);imagesc(SFDCE_low_yearSi_sort_AT);
title('SFDCE low Si');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot(2,2,3);imagesc(KGEyearSTi_sort_AT);
title('KGE STi');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot(2,2,4);imagesc(SFDCE_low_yearSTi_sort_AT);
title('SFDCE low STi');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
suptitle('Sorted by AT (descending order)');

%Heat map with P cum sorting
figure; set(gcf,'color','w');
subplot(2,2,1);imagesc(KGEyearSi_sort_Pcum);
title('KGE Si');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot(2,2,2);imagesc(SFDCE_low_yearSi_sort_Pcum);
title('SFDCE low Si');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot(2,2,3);imagesc(KGEyearSTi_sort_Pcum);
title('KGE STi');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot(2,2,4);imagesc(SFDCE_low_yearSTi_sort_Pcum);
title('SFDCE low STi');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
suptitle('Sorted by P cum (descending order)');

%Heat map with P mean sorting
figure; set(gcf,'color','w');
subplot(2,2,1);imagesc(KGEyearSi_sort_Pmean);
title('KGE Si');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot(2,2,2);imagesc(SFDCE_low_yearSi_sort_Pmean);
title('SFDCE low Si');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot(2,2,3);imagesc(KGEyearSTi_sort_Pmean);
title('KGE STi');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot(2,2,4);imagesc(SFDCE_low_yearSTi_sort_Pmean);
title('SFDCE low STi');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
suptitle('Sorted by P mean (descending order)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Figure 8,9 - what is the different between dry years and wet years?    
N=length(P_mean_val_sort);

KGEyearSi_sort_Pcum_dry=KGEyearSi_sort_Pcum(1:10,:);
KGEyearSi_sort_Pcum_wet=KGEyearSi_sort_Pcum(((N-9):N),:);
KGEyearSTi_sort_Pcum_dry=KGEyearSTi_sort_Pcum(1:10,:);
KGEyearSTi_sort_Pcum_wet=KGEyearSTi_sort_Pcum(((N-9):N),:);

SFDCE_low_yearSi_sort_Pcum_dry=SFDCE_low_yearSi_sort_Pcum(1:10,:);
SFDCE_low_yearSi_sort_Pcum_wet=SFDCE_low_yearSi_sort_Pcum(((N-9):N),:);
SFDCE_low_yearSTi_sort_Pcum_dry=SFDCE_low_yearSTi_sort_Pcum(1:10,:);
SFDCE_low_yearSTi_sort_Pcum_wet=SFDCE_low_yearSTi_sort_Pcum(((N-9):N),:);

figure; set(gcf,'color','w');
subplot(2,2,1);boxplot(KGEyearSi_sort_Pcum_dry);
title('KGE Si'); ylim([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot(2,2,2);boxplot(SFDCE_low_yearSi_sort_Pcum_dry);
title('SFDCE low Si'); ylim([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot(2,2,3);boxplot(KGEyearSTi_sort_Pcum_dry);
title('KGE STi');ylim([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot(2,2,4);boxplot(SFDCE_low_yearSTi_sort_Pcum_dry);
title('SFDCE low STi');ylim([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
suptitle('10 driest years');

figure; set(gcf,'color','w');
subplot(2,2,1);boxplot(KGEyearSi_sort_Pcum_wet);
title('KGE Si'); ylim([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot(2,2,2);boxplot(SFDCE_low_yearSi_sort_Pcum_wet);
title('SFDCE low Si'); ylim([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot(2,2,3);boxplot(KGEyearSTi_sort_Pcum_wet);
title('KGE STi');ylim([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
subplot(2,2,4);boxplot(SFDCE_low_yearSTi_sort_Pcum_wet);
title('SFDCE low STi');ylim([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
suptitle('10 wettest years');