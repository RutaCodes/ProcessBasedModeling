#Ruta Basijokaite

clear all; 
global Data

my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

%define varaibe that can be used for confidence interval
Par_STi_aver_KGE=zeros(21,10);
Par_STi_aver_SFDCE=zeros(21,10);
Par_STi_aver_CoM=zeros(21,10);
Par_STi_aver_BFI=zeros(21,10);
Par_STi_aver_RR=zeros(21,10);
Par_STi_std_KGE=zeros(21,10);
Par_STi_std_SFDCE=zeros(21,10);
Par_STi_std_CoM=zeros(21,10);
Par_STi_std_BFI=zeros(21,10);
Par_STi_std_RR=zeros(21,10);
KGEwholeSTi_WS=zeros(21,10);
da=0;
for i=1:21
    switch i
        case 1 
            load Data_DelPuerto.mat;
            dataset = Data_DelPuerto;
            year = dataset(:,1);
            month = dataset(:,2);
            day = dataset(:,3);
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load del_puerto_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;%SFDCE values
            load del_puerto_sens_yr_run5000_snow_HydSigRun2.mat;%KGE STi values
            load del_puerto_hymod_5000hyd_objFun_snow_HydSigRun2.mat; %KGEwhole
            load del_puerto_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 2
            load Data_Lopez.mat;
            dataset = Data_Lopez;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load lopez_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load lopez_sens_yr_run5000_snow_HydSigRun2.mat;
            load lopez_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load lopez_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 3
            load Data_Pescadero.mat;
            dataset = Data_Pescadero;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load pescadero_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load pescadero_sens_yr_run5000_snow_HydSigRun2.mat;
            load pescadero_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load pescadero_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 4
            load Data_BigSur.mat;
            dataset = Data_BigSur;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load big_sur_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load big_sur_sens_yr_run5000_snow_HydSigRun2.mat;
            load big_sur_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load big_sur_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 5 
            load Data_NFCache.mat;
            dataset = Data_NFCache;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load NFCache_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat; 
            load NFCache_sens_yr_run5000_snow_HydSigRun2.mat; 
            load NFCache_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load NFCache_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 6
            load Data_SFTrinity.mat;
            dataset = Data_SFTrinity;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load SFTrinity_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load SFTrinity_sens_yr_run5000_snow_HydSigRun2.mat;
            load SFTrinity_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load SFTrinity_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 7
            load Data_Noyo.mat;
            dataset = Data_Noyo;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load noyo_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat; 
            load noyo_sens_yr_run5000_snow_HydSigRun2.mat;
            load noyo_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load noyo_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 8 
            load Data_Salmon.mat;
            dataset = Data_Salmon;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load salmon_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load salmon_sens_yr_run5000_snow_HydSigRun2.mat;
            load salmon_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load salmon_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 9
            load Data_MFEel.mat;
            dataset = Data_MFEel;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load mfeel_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat; 
            load mfeel_sens_yr_run5000_snow_HydSigRun2.mat;
            load mfeel_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load mfeel_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 10
            load Data_VanDuzen.mat;
            dataset = Data_VanDuzen;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load VanDuzen_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load VanDuzen_sens_yr_run5000_snow_HydSigRun2.mat;
            load VanDuzen_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load VanDuzen_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 11
            load Data_Little.mat;
            dataset = Data_Little;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load little_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load little_sens_yr_run5000_snow_HydSigRun2.mat;
            load little_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load little_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 12
            load Data_Bull.mat;
            dataset = Data_Bull;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load bull_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load bull_sens_yr_run5000_snow_HydSigRun2.mat;
            load bull_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load bull_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 13
            load Data_Redwood.mat;
            dataset = Data_Redwood;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load redwood_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load redwood_sens_yr_run5000_snow_HydSigRun2.mat;
            load redwood_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load redwood_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 14
            load Data_Smith.mat;
            dataset = Data_Smith;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load smith_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load smith_sens_yr_run5000_snow_HydSigRun2.mat;
            load smith_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load smith_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 15
            load Data_Trinity_R.mat;
            dataset = Data_Trinity_R;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load trinity_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load trinity_sens_yr_run5000_snow_HydSigRun2.mat;
            load trinity_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load trinity_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 16
            load Data_Deer.mat;
            dataset = Data_Deer;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load deer_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load deer_sens_yr_run5000_snow_HydSigRun2.mat;
            load deer_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load deer_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 17
            load Data_Mill.mat;
            dataset = Data_Mill;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load mill_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load mill_sens_yr_run5000_snow_HydSigRun2.mat;
            load mill_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load mill_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 18
            load Data_Bear_Lake.mat;
            dataset = Data_Bear_Lake;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load bear_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load bear_sens_yr_run5000_snow_HydSigRun2.mat;
            load bear_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load bear_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 19
            load Data_Merced_Happy.mat;
            dataset = Data_Merced_Happy;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load merced_happy_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load merced_happy_sens_yr_run5000_snow_HydSigRun2.mat;
            load merced_happy_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load merced_happy_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 20
            load Data_Merced_Pohono.mat;
            dataset = Data_Merced_Pohono;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load merced_pohono_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load merced_pohono_sens_yr_run5000_snow_HydSigRun2.mat;
            load merced_pohono_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load merced_pohono_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 21
            load Data_Pitman.mat;
            dataset = Data_Pitman;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load pitman_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load pitman_sens_yr_run5000_snow_HydSigRun2.mat;
            load pitman_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load pitman_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
    end
    
    KGEyearSTi(KGEyearSTi < 0) = 0;
    SFDCE_low_yearSTi(SFDCE_low_yearSTi < 0) = 0;
    i1=1:5000; i2=5001:10000; i3=10001:60000;
    [KGEwholeSi,KGEwholeSTi]=vbsa_indices(KGE_whole(i1),KGE_whole(i2),KGE_whole(i3));
    KGEwholeSTi_WS(i,:)=KGEwholeSTi;
    
    for j=1:10
        Par_STi_aver_KGE(i,j)=mean(KGEyearSTi(:,j));
        %Par_STi_aver_SFDCE(i,j)=mean(SFDCE_low_yearSTi(:,j));
        Par_STi_aver_CoM(i,j)=nanmean(CoMyearSTi(:,j));
        Par_STi_aver_SFDCE(i,j)=nanmean(SFDCyearSTi(:,j));
        Par_STi_aver_BFI(i,j)=nanmean(ArBFIyearSTi(:,j));
        Par_STi_aver_RR(i,j)=nanmean(RRyearSTi(:,j));
        
        Par_STi_std_KGE(i,j)=std(KGEyearSTi(:,j));
        %Par_STi_std_SFDCE(i,j)=std(SFDCE_low_yearSTi(:,j));
        %Par_STi_std_CoM(i,j)=std(CoMyearSTi(:,j));
        Par_STi_std_CoM(i,j)=std(CoMyearSTi(~isnan(CoMyearSTi(:,j)),j)); 
        Par_STi_std_SFDCE(i,j)=std(SFDCyearSTi(~isnan(SFDCyearSTi(:,j)),j));
        Par_STi_std_BFI(i,j)=std(ArBFIyearSTi(~isnan(ArBFIyearSTi(:,j)),j));
        Par_STi_std_RR(i,j)=std(RRyearSTi(~isnan(RRyearSTi(:,j)),j));
    end
    for j=1981:2013 %1980:2014
        [x, ~]=find(year==j & month == 10 & day == 1);
        [y, ~]=find(year==(j+1) & month == 9 & day == 30);
        da=da+1;
        Prec_WatY_cum(da,i)=sum(precip(x:y,1));
        Temp_WatY_aver(da,i)=mean(tempaver(x:y,1));
    end
    da=0;

end

for i=1:21
    Prec_aver_WS(i)=mean(Prec_WatY_cum(:,i));
end

[Prectop_val,Prectop_index]=sort(Prec_aver_WS,'ascend');
WS_names=({'DPU','LOP','PES','BSU','NFC','SFT','NOY','SAL','MFE','VDU',...
    'LIT','BUL','RED','SMI','TRI','DEE','MIL','BEA','MHA','MPO','PIT'});

%SA results
figure; set(gcf,'color','w');
subplot(2,3,1);imagesc(Par_STi_aver_SFDCE(Prectop_index,:));
title('Average SFDC');colormap(flipud(gray));colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
yticklabels(WS_names(Prectop_index));hold on;
subplot(2,3,4);imagesc(Par_STi_std_SFDCE(Prectop_index,:));
title('STD SFDC');colorbar;caxis([0 0.3]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
yticklabels(WS_names(Prectop_index));hold on;
subplot(2,3,2);imagesc(Par_STi_aver_BFI(Prectop_index,:));
title('Average ArBFI');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
yticklabels(WS_names(Prectop_index));hold on;
subplot(2,3,5);imagesc(Par_STi_std_BFI(Prectop_index,:));
title('STD ArBFI');colorbar;caxis([0 0.3]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
yticklabels(WS_names(Prectop_index));
subplot(2,3,3);imagesc(Par_STi_aver_RR(Prectop_index,:));
title('Average RR');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
yticklabels(WS_names(Prectop_index));hold on;
subplot(2,3,6);imagesc(Par_STi_std_RR(Prectop_index,:));
title('STD RR');colorbar;caxis([0 0.3]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
yticklabels(WS_names(Prectop_index));


figure; set(gcf,'color','w');
subplot(2,2,1);imagesc(Par_STi_aver_KGE(Prectop_index,:));
title('Average KGE');colormap(flipud(gray));colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
yticklabels(WS_names(Prectop_index));hold on;
subplot(2,2,2);imagesc(Par_STi_std_KGE(Prectop_index,:));
title('STD KGE');colorbar;caxis([0 0.3]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
yticklabels(WS_names(Prectop_index));hold on;
subplot(2,2,3);imagesc(Par_STi_aver_CoM(Prectop_index,:));
title('Average CoM');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
yticklabels(WS_names(Prectop_index));hold on;
subplot(2,2,4);imagesc(Par_STi_std_CoM(Prectop_index,:));
title('STD CoM');colorbar;caxis([0 0.3]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
yticklabels(WS_names(Prectop_index));

figure; set(gcf,'color','w');
subplot(1,3,1);imagesc(KGEwholeSTi_WS(Prectop_index,:));
title('Whole KGE');colormap(flipud(gray));colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
yticklabels(WS_names(Prectop_index));hold on;
subplot(1,3,2);imagesc(Par_STi_aver_KGE(Prectop_index,:));
title('Average annual KGE');colormap(flipud(gray));colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
yticklabels(WS_names(Prectop_index));hold on;
subplot(1,3,3);imagesc(Par_STi_std_KGE(Prectop_index,:));
title('SD KGE');colormap(flipud(gray));colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
yticklabels(WS_names(Prectop_index));


figure; set(gcf,'color','w');
subplot(2,2,1);imagesc(Par_STi_aver_KGE(Prectop_index,:));
title('Average KGE');colormap(flipud(gray));colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
% yticks([1 6 11 14 18]);
% yticklabels({'NF Cache','Bull','Mill','Pitman','Lopez'});hold on;
% yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
% yticklabels({'NF Cache','Noyo','MF Eel','Salmon','SF Trinity','Bull','Little','Van Duzen','Redwood','Smith',...
%     'Mill','Trinity','Deer','Pitman','Bear','M Happy','M Pohono','Lopez','Pescadero','Big Sur','Del Puerto'});hold on;
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
% yticklabels({'DPU','LOP','PES','BSU','NFC','SFT','NOY','SAL','MFE','VDU',...
%     'LIT','BUL','RED','SMI','TRI','DEE','MIL','BEA','MHA','MPO','PIT'});hold on;
yticklabels(WS_names(Prectop_index));hold on;
subplot(2,2,2);imagesc(Par_STi_std_KGE(Prectop_index,:));
title('STD KGE');colorbar;caxis([0 0.3]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
yticklabels(WS_names(Prectop_index));hold on;
subplot(2,2,3);imagesc(Par_STi_aver_SFDCE(Prectop_index,:));
title('Average SFDCE');colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
yticklabels(WS_names(Prectop_index));hold on;
subplot(2,2,4);imagesc(Par_STi_std_SFDCE(Prectop_index,:));
title('STD SFDCE');colorbar;caxis([0 0.3]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
yticklabels(WS_names(Prectop_index));

figure; set(gcf,'color','w');
bar(Prectop_val);xlim([0 22]);
xticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
xticklabels(WS_names(Prectop_index));

% Prec_aver_ws=0;
% for i=1:21
%     Prec_aver_ws(i)=mean(Prec_WatY_cum(:,i));
% end
% %Precip
% figure; set(gcf,'color','w');
% bar(Prec_aver_ws);xlim([0 22]);
% xticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
% xticklabels({'DPU','LOP','PES','BSU','NFC','SFT','NOY','SAL','MFE','VDU',...
%     'LIT','BUL','RED','SMI','TRI','DEE','MIL','BEA','MHA','MPO','PIT'});
% 
AT_aver_ws=0;
for i=1:21
    AT_aver_ws(i)=mean(Temp_WatY_aver(:,i));
end
figure; set(gcf,'color','w');
bar(AT_aver_ws(Prectop_index));xlim([0 22]);
xticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]);
xticklabels(WS_names(Prectop_index));ylim([0 20]);
% 
% figure; set(gcf,'color','w');sz=40;
% scatter(1,2437.3,sz,'filled');hold on;
% scatter(1, 3244.58,sz,'filled');hold on;
% scatter(1, 2746.07,sz,'filled');hold on;
% scatter(1, 2578.16,sz,'filled');
% xlim([0 2]); ylim([2000 3500]);
% title('Elevation comparison');

% % figure; set(gcf,'color','w');sz=40;
% % scatter(1,352,sz,'filled','r');hold on;
% % scatter(1,582,sz,'filled','r');hold on;
% % scatter(1,881,sz,'filled','r');hold on;
% % scatter(1,897,sz,'filled','r');hold on;
% % 
% % scatter(2,849,sz,'filled','m');hold on;
% % scatter(2,1189,sz,'filled','m');hold on;
% % scatter(2,1209,sz,'filled','m');hold on;
% % scatter(2,1328,sz,'filled','m');hold on;
% % scatter(2,1367,sz,'filled','m');hold on;
% % 
% % scatter(3,1485,sz,'filled','k');hold on;
% % scatter(3,1531,sz,'filled','k');hold on;
% % scatter(3,1655,sz,'filled','k');hold on;
% % scatter(3,1699,sz,'filled','k');hold on;
% % scatter(3,2571,sz,'filled','k');hold on;
% % 
% % scatter(4,849,sz,'filled','g');hold on;
% % scatter(4,1189,sz,'filled','g');hold on;
% % scatter(4,1209,sz,'filled','g');hold on;
% % 
% % scatter(5,897,sz,'filled','b');hold on;
% % scatter(5,980,sz,'filled','b');hold on;
% % scatter(5,1008,sz,'filled','b');hold on;
% % scatter(5,1063,sz,'filled','b');hold on;
% % 
% % xlim([0 6]); ylim([0 3000]);
% % ylabel('Average Precipitation mm yr -1');
% % title('Average precipitation in each watershed group');
