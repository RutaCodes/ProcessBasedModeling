clear all; 
global Data

my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

%define varaibe that can be used for confidence interval
Par_STi_aver_KGE=zeros(10,10);
Par_STi_std_KGE=zeros(10,10);
Par_STi_aver_mo_RMSE=zeros(10,10);
Par_STi_aver_we_RMSE=zeros(10,10);
Par_STi_std_mo_RMSE=zeros(10,10);
Par_STi_std_we_RMSE=zeros(10,10);
da=0;
for i=1:10
    switch i
        case 1
            load Data_BigSur.mat;
            dataset = Data_BigSur;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load big_sur_sub_sens_yr_hyd_SFDCE_run5000_snow_test1s.mat;
            load big_sur_sub_sens_yr_run5000_snow_test1s.mat;
            load big_sur_sub_sens_mo_run5000_snow_test1s.mat;
        case 2
            load Data_Pescadero.mat;
            dataset = Data_Pescadero;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load pescadero_sub_sens_yr_hyd_SFDCE_run5000_snow_test1s.mat;
            load pescadero_sub_sens_yr_run5000_snow_test1s.mat;
            load pescadero_sub_sens_mo_run5000_snow_test1s.mat;
        case 3
            load Data_SFTrinity.mat;
            dataset = Data_SFTrinity;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load sf_trinity_sub_sens_yr_hyd_SFDCE_run5000_snow_test1s.mat;
            load sf_trinity_sub_sens_yr_run5000_snow_test1s.mat;
            load sf_trinity_sub_sens_mo_run5000_snow_test1s.mat;
        case 4
            load Data_Noyo.mat;
            dataset = Data_Noyo;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load noyo_sub_sens_yr_hyd_SFDCE_run5000_snow_test1s.mat; 
            load noyo_sub_sens_yr_run5000_snow_test1s.mat;
            load noyo_sub_sens_mo_run5000_snow_test1s.mat;
        case 5
            load Data_Redwood.mat;
            dataset = Data_Redwood;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load redwood_sub_sens_yr_hyd_SFDCE_run5000_snow_test1s.mat;
            load redwood_sub_sens_yr_run5000_snow_test1s.mat;
            load redwood_sub_sens_mo_run5000_snow_test1s.mat;
        case 6
            load Data_Smith.mat;
            dataset = Data_Smith;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load smith_sub_sens_yr_hyd_SFDCE_run5000_snow_test1s.mat;
            load smith_sub_sens_yr_run5000_snow_test1s.mat;
            load smith_sub_sens_mo_run5000_snow_test1s.mat;
        case 7
            load Data_Trinity_R.mat;
            dataset = Data_Trinity_R;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load trinity_sub_sens_yr_hyd_SFDCE_run5000_snow_test1s.mat;
            load trinity_sub_sens_yr_run5000_snow_test1s.mat;
            load trinity_sub_sens_mo_run5000_snow_test1s.mat;
        case 8
            load Data_Mill.mat;
            dataset = Data_Mill;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load mill_sub_sens_yr_hyd_SFDCE_run5000_snow_test1s.mat;
            load mill_sub_sens_yr_run5000_snow_test1s.mat;
            load mill_sub_sens_mo_run5000_snow_test1s.mat;
        case 9
            load Data_Pitman.mat;
            dataset = Data_Pitman;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load pitman_sub_sens_yr_hyd_SFDCE_run5000_snow_test1s.mat;
            load pitman_sub_sens_yr_run5000_snow_test1s.mat;
            load pitman_sub_sens_mo_run5000_snow_test1s.mat;
        case 10
            load Data_Merced_Pohono.mat;
            dataset = Data_Merced_Pohono;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load merced_pohono_sub_sens_yr_hyd_SFDCE_run5000_snow_test1s.mat;
            load merced_pohono_sub_sens_yr_run5000_snow_test1s.mat;
            load merced_pohono_sub_sens_mo_run5000_snow_test1s.mat;
    end
    
    KGEyearSTi(KGEyearSTi < 0) = 0;
    SFDCE_low_yearSTi(SFDCE_low_yearSTi < 0) = 0;
    
    for j=1:10
        Par_STi_aver_KGE(i,j)=mean(KGEyearSTi(:,j));
        Par_STi_std_KGE(i,j)=std(KGEyearSTi(:,j));
        Par_STi_aver_mo_RMSE(i,j)=mean(RSME_moSTi(:,j));
        Par_STi_aver_we_RMSE(i,j)=mean(RSME_weSTi(:,j));
        Par_STi_std_mo_RMSE(i,j)=std(RSME_moSTi(:,j));
        Par_STi_std_we_RMSE(i,j)=std(RSME_weSTi(:,j));
    end
%     for j=1981:2013 %1980:2014
%         [x, ~]=find(year==j & month == 10 & day == 1);
%         [y, ~]=find(year==(j+1) & month == 9 & day == 30);
%         da=da+1;
%         Prec_WatY_cum(da,i)=sum(precip(x:y,1));
%         Temp_WatY_aver(da,i)=mean(tempaver(x:y,1));
%     end
    da=0;

end

%Averages and STD of total order indices
figure; set(gcf,'color','w');
subplot(3,2,1);
imagesc(Par_STi_aver_KGE);
title('Average annual KGE');colormap(flipud(gray));colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10]);
yticklabels({'BSU','PES','SFT','NOY','RED','SMI','TRI','MIL','PIT','MPO'});
subplot(3,2,2);
imagesc(Par_STi_std_KGE);
title('STD annual KGE');colormap(flipud(gray));colorbar;caxis([0 0.5]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10]);
yticklabels({'BSU','PES','SFT','NOY','RED','SMI','TRI','MIL','PIT','MPO'});
subplot(3,2,3);
imagesc(Par_STi_aver_mo_RMSE);
title('Average mothly RMSE');colormap(flipud(gray));colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10]);
yticklabels({'BSU','PES','SFT','NOY','RED','SMI','TRI','MIL','PIT','MPO'});
subplot(3,2,4);
imagesc(Par_STi_std_mo_RMSE);
title('STD mothly RMSE');colormap(flipud(gray));colorbar;caxis([0 0.5]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10]);
yticklabels({'BSU','PES','SFT','NOY','RED','SMI','TRI','MIL','PIT','MPO'});
subplot(3,2,5);
imagesc(Par_STi_aver_we_RMSE);
title('Average weekly RMSE');colormap(flipud(gray));colorbar;caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10]);
yticklabels({'BSU','PES','SFT','NOY','RED','SMI','TRI','MIL','PIT','MPO'});
subplot(3,2,6);
imagesc(Par_STi_std_we_RMSE);
title('STD weekly RMSE');colormap(flipud(gray));colorbar;caxis([0 0.5]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3 4 5 6 7 8 9 10]);
yticklabels({'BSU','PES','SFT','NOY','RED','SMI','TRI','MIL','PIT','MPO'});