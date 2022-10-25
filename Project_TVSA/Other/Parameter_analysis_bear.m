%Ruta Basijokaite

clear all;
load bear_lake_SA_5000ofs_yr_test4.mat %KGEyear NSEyear
load bear_lake_SA_5000pars_test4.mat %XALL
load bear_lake_sens_yr_run5000_test4.mat WByearSi WByearSTi NSEyearSi NSEyearSTi KGEyearSi KGEyearSTi RREyearSi RREyearSTi %MyearSi MyearSTi%year nr by par nr
load bear_lake_SA_5000sim_val_test4.mat NSEtop_val NSEtop_index KGEtop_val KGEtop_index

KGEyear=KGEyear(:,1:33);
NSEyear=NSEyear(:,1:33);
KGEyearSTi=KGEyearSTi(1:33,:);
NSEyearSTi=NSEyearSTi(1:33,:);
KGEyearSi=KGEyearSi(1:33,:);
NSEyearSi=NSEyearSi(1:33,:);

load Data_Bear_Lake.mat; %data nldas
dataset = Data_Bear_Lake; 
% load Data_Qflow_Merced_Pohono.mat; %streamflow
% Streamflow = ((Data_Qflow_Merced_Pohono(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
%                                            %m3/s         m/s         mm/day ;                                                       
year = dataset(:,1);
month = dataset(:,2);
day = dataset(:,3);

precip=dataset(:,6);
tempaver=(dataset(:,9)+ dataset(:,10))/2;

da = 0; %annual averages
Prec_WatY=zeros(33,365);
Temp_WatY=zeros(33,365);
for j=1981:2013 %1980:2014
        [x, ~]=find(year==j & month == 10 & day == 1);
        [y, ~]=find(year==(j+1) & month == 9 & day == 30);
        
        da=da+1;
        Prec_WatY(da,1:length(precip(x:y)))=precip(x:y,1)';
        Prec_WatY_aver(da,1)=mean(precip(x:y,1));
        Prec_WatY_cum(da,1)=sum(precip(x:y,1));
        Temp_WatY(da,1:length(precip(x:y)))=tempaver(x:y,1)';
        Temp_WatY_aver(da,1)=mean(tempaver(x:y,1));
        
end

% da=0; %for one year - weekly averages
% [ax, ~]=find(year==1997 & month == 10 & day == 1);
% [ay, ~]=find(year==1998 & month == 9 & day == 30);
% precip_week=zeros(52,1);
% temp_week=zeros(52,1);
% for j=ax:7:ay-1 %1980:2014
%     da = da+1;
%     precip_week(da,1) = sum(precip(j:j+6));
%     temp_week(da,1) = mean(tempaver(j:j+6));
% end

per=1; %top percentage
% for i=1:52
% [a1,b1]=sort(NSEweek(:,i),'descend'); %a values, b index
% NSEtop_values(:,i)=a1(1:(length(NSEweek)*0.01*per));%top per percent
% NSEtop_index(:,i)=b1(1:(length(NSEweek)*0.01*per));%top per percent
% [a2,b2]=sort(KGEweek(:,i),'descend'); %a values, b index
% KGEtop_values(:,i)=a2(1:(length(KGEweek)*0.01*per));%top per percent
% KGEtop_index(:,i)=b2(1:(length(KGEweek)*0.01*per));%top per percent
% [a3,b3]=sort(WBweek(:,i),'descend'); %a values, b index
% WBtop_values(:,i)=a2(1:(length(WBweek)*0.01*per));%top per percent
% WBtop_index(:,i)=b2(1:(length(WBweek)*0.01*per));%top per percent
% end
for i=1:size(NSEyear,2) %for older runs
[a1,b1]=sort(NSEyear(:,i),'descend'); %a values, b index
NSEtop_values(:,i)=a1(1:(length(NSEyear)*0.01*per));%top per percent
NSEtop_indices(:,i)=b1(1:(length(NSEyear)*0.01*per));%top per percent
[a2,b2]=sort(KGEyear(:,i),'descend'); %a values, b index
KGEtop_values(:,i)=a2(1:(length(KGEyear)*0.01*per));%top per percent
KGEtop_indices(:,i)=b2(1:(length(KGEyear)*0.01*per));%top per percent
[a3,b3]=sort(WByear(:,i),'descend'); %a values, b index
WBtop_values(:,i)=a2(1:(length(WByear)*0.01*per));%top per percent
WBtop_indices(:,i)=b2(1:(length(WByear)*0.01*per));%top per percent
end

%pull out parameter values corresponding to best runs
for j=1:10 %choose parameter
    for i=1:size(NSEtop_values,2)
        Top_par_NSE(:,i,j)=XALL(NSEtop_indices(:,i),j);
        Top_par_KGE(:,i,j)=XALL(KGEtop_indices(:,i),j);
        Top_par_WB(:,i,j)=XALL(WBtop_indices(:,i),j);
%         figure;
%         scatter(Top_par_KGE(:,i,j),KGEtop_index(:,i),10,[0 0 0],'filled')
%         set(gca,'yscale','log');
    end
end

KGE_all_years=reshape(Top_par_KGE(:,:,:),[],1,10);
KGEtop_val_all_years=reshape(KGEtop_values(:,:),[],1);
KGE_Kq=KGE_all_years(:,:,1);
KGE_Alp=KGE_all_years(:,:,3);

figure; 
set(gcf,'color','w');
scatter(KGE_Kq,KGE_Alp,25,KGEtop_val_all_years,'filled');
title('Kq vs Alpha colored by KGE');colorbar;
xlabel('Kq');ylabel('Alpha');

% figure; 
% set(gcf,'color','w');
% plot(precip_week); 
% title('Precipitation'); xlim([1 52]);% ylim([0 220]);
% figure; 
% set(gcf,'color','w');
% plot(temp_week);
% title('Temperature'); xlim([1 52]); %ylim([-10 20]);

%Hydrograph
global data
figure; set(gcf,'color','w');
plot(qs(KGEtop_index(1),:)); hold on;
plot(qobs); legend('Simulated','Observed');
title('Best KGE value'); %xlim([1 365]);

figure; %parameter cahanges through years
set(gcf,'color','w');
boxplot(Top_par_NSE(:,:,1));
title('Kq (NSE)');
figure;
set(gcf,'color','w');
boxplot(Top_par_KGE(:,:,1));
title('Kq (KGE)');
% figure;
% set(gcf,'color','w');
% boxplot(Top_par_WB(:,:,1));
% title('Kq (WB)');

figure; %parameter cahanges through years
set(gcf,'color','w');
boxplot(Top_par_NSE(:,:,2));
title('Ks (NSE)');
figure;
set(gcf,'color','w');
boxplot(Top_par_KGE(:,:,2));
title('Ks (KGE)');
% figure;
% set(gcf,'color','w');
% boxplot(Top_par_WB(:,:,2));
% title('Ks (WB)');

figure; %parameter cahanges through years
set(gcf,'color','w');
boxplot(Top_par_NSE(:,:,3));
title('Alp (NSE)');
figure;
set(gcf,'color','w');
boxplot(Top_par_KGE(:,:,3));
title('Alp (KGE)');
% figure;
% set(gcf,'color','w');
% boxplot(Top_par_WB(:,:,3));
% title('Alp (WB)');

figure; %parameter cahanges through years
set(gcf,'color','w');
boxplot(Top_par_NSE(:,:,6));
title('DDF (NSE)');
figure;
set(gcf,'color','w');
boxplot(Top_par_KGE(:,:,6));
title('DDF (KGE)');
% figure;
% set(gcf,'color','w');
% boxplot(Top_par_WB(:,:,6));
% title('DDF (WB)');

figure; %parameter cahanges through years
set(gcf,'color','w');
boxplot(Top_par_NSE(:,:,9));% hold on;
%plot(Temp_WatY_aver);
title('TM (NSE)');
figure;
set(gcf,'color','w');
boxplot(Top_par_KGE(:,:,9)); %hold on;
%plot(Temp_WatY_aver);
title('TM (KGE)');
% figure;
% set(gcf,'color','w');
% boxplot(Top_par_WB(:,:,9));
% title('TM (WB)');

% KGE_all_weeks=reshape(Top_par_KGE(:,:,:),[],1,10);
% for i=1:10
%     KGE_par_comb(:,i)=KGE_all_weeks(:,:,i);
%     KGE_par_mean(i)=mean(KGE_par_comb(:,i));
% end

% [DDF_values, DDF_index]=sort(KGE_par_comb(:,6),'descend');
% figure; %no pattern, but there is inverse relationship that can be observed
% set(gcf,'color','w');
% plot(KGE_par_comb(DDF_index(1:50),9),KGE_par_comb(DDF_index(1:50),6),'+');
% title('KGE'); xlabel('TM'); ylabel('DDF');

figure; % plot main and total separately
set(gcf,'color','w');
subplot(2,2,1);
imagesc(KGEyearSi);
title('KGE (yearly Si)');colorbar;caxis([0 1]);
%X_Labels = {'Kq';'Ks';'Alp';'Huz';'B';'DDF';'TR';'TM'} ;
%xlabel(X_Labels);
hold on;
subplot(2,2,2);
imagesc(KGEyearSTi);
title('KGE (yearly STi)');colorbar;caxis([0 1]);
hold on;
subplot(2,2,3);
imagesc(NSEyearSi);
title('NSE (yearly Si)');colorbar;caxis([0 1]);
hold on;
subplot(2,2,4);
imagesc(NSEyearSTi);
title('NSE (yearly STi)');colorbar;caxis([0 1]);

figure;
set(gcf,'color','w');
plot(Temp_WatY_aver);
title('Average yearly temperature');% xlim([1 33]);
figure;
set(gcf,'color','w');
plot(Prec_WatY_cum);
title('Cumulative precipitation');% xlim([1 33]);
% 
% figure; %parameter cahanges through years
% set(gcf,'color','w');
% boxplot(Top_par_NSE(:,:,11));
% title('PCF (NSE)');
% figure;
% set(gcf,'color','w');
% boxplot(Top_par_KGE(:,:,11));
% title('PCF (KGE)');

%parameter comparison
NSE_par_all=reshape(Top_par_NSE(:,:,:),[],1,10);
KGE_par_all=reshape(Top_par_KGE(:,:,:),[],1,10);
for i=1:10
    NSE_par_comb(:,i)=NSE_par_all(:,:,i);
    KGE_par_comb(:,i)=KGE_par_all(:,:,i);
end

%normalize the parameter ranges to [0 1]
% Par_ranges  = [ 0.1 1; 0 0.2; 0 1; 5 500; 0 2; 1 10; 1 3; -3 1; -3 3; 0 0.1; 0.9 1.1; 0.9 1.1]; % Parameter ranges
Par_ranges  = [ 0.1 1; 0 0.2; 0 1; 5 500; 0 2; 1 10; 1 3; -3 1; -3 3; 0 0.1]; % Parameter ranges
for i=1:10
    NSE_par_comb_norm(:,i)=(NSE_par_comb(:,i)-Par_ranges(i,1))/(Par_ranges(i,2)-Par_ranges(i,1));
    KGE_par_comb_norm(:,i)=(KGE_par_comb(:,i)-Par_ranges(i,1))/(Par_ranges(i,2)-Par_ranges(i,1));
end

figure; %all 12 parameters
set(gcf,'color','w');
boxplot(NSE_par_comb_norm);
title('NSE');
figure; %all 12 parameters
set(gcf,'color','w');
boxplot(KGE_par_comb_norm);
title('KGE');

