clear all; 
global Data

my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

%define varaibe that can be used for confidence interval
Si_Ks=zeros(33,21);
STi_Ks=zeros(33,21);
KGE_STi_DDF=zeros(33,21);
KGE_STi_TT=zeros(33,21);
KGE_STi_Kf=zeros(33,21);
KGE_STi_TM=zeros(33,21);
Prec_WatY_cum=zeros(33,21); %annual P data in all sites
Temp_WatY_aver=zeros(33,21);
da=0;
for i=1:21
    switch i
        case 1
            load Data_NFCache.mat;
            dataset = Data_NFCache;
            year = dataset(:,1);
            month = dataset(:,2);
            day = dataset(:,3);
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load NFCache_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat; %SFDCE values
            %load NFCache_sens_yr_run5000_snow_Newrun1.mat; %KGE values
        case 2
            load Data_Noyo.mat;
            dataset = Data_Noyo;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load noyo_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat; 
            %load noyo_sens_yr_run5000_snow_Newrun1.mat;
        case 3
            load Data_MFEel.mat;
            dataset = Data_MFEel;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load mfeel_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat; 
            %load mfeel_sens_yr_run5000_snow_Newrun1.mat;
        case 4 
            load Data_Salmon.mat;
            dataset = Data_Salmon;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load salmon_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load salmon_sens_yr_run5000_snow_Newrun1.mat;
        case 5
            load Data_SFTrinity.mat;
            dataset = Data_SFTrinity;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load SFTrinity_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load SFTrinity_sens_yr_run5000_snow_Newrun1.mat;
        case 6 
            load Data_Bull.mat;
            dataset = Data_Bull;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load bull_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load bull_sens_yr_run5000_snow_Newrun1.mat;
        case 7
            load Data_Little.mat;
            dataset = Data_Little;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load little_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load little_sens_yr_run5000_snow_Newrun1.mat;
        case 8
            load Data_VanDuzen.mat;
            dataset = Data_VanDuzen;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load VanDuzen_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load VanDuzen_sens_yr_run5000_snow_Newrun1.mat;
        case 9
            load Data_Redwood.mat;
            dataset = Data_Redwood;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load redwood_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load redwood_sens_yr_run5000_snow_Newrun1.mat;
        case 10
            load Data_Smith.mat;
            dataset = Data_Smith;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load smith_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load smith_sens_yr_run5000_snow_Newrun1.mat;
        case 11
            load Data_Mill.mat;
            dataset = Data_Mill;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load mill_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load mill_sens_yr_run5000_snow_Newrun1.mat;
        case 12
            load Data_Trinity_R.mat;
            dataset = Data_Trinity_R;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load trinity_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load trinity_sens_yr_run5000_snow_Newrun1.mat;
        case 13
            load Data_Deer.mat;
            dataset = Data_Deer;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load deer_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load deer_sens_yr_run5000_snow_Newrun1.mat;
        case 14
            load Data_Pitman.mat;
            dataset = Data_Pitman;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load pitman_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load pitman_sens_yr_run5000_snow_Newrun1.mat;
        case 15
            load Data_Bear_Lake.mat;
            dataset = Data_Bear_Lake;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load bear_lake_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load bear_lake_sens_yr_run5000_snow_Newrun1.mat;
        case 16
            load Data_Merced_Happy.mat;
            dataset = Data_Merced_Happy;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load merced_happy_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load merced_happy_sens_yr_run5000_snow_Newrun1.mat;
        case 17
            load Data_Merced_Pohono.mat;
            dataset = Data_Merced_Pohono;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load merced_pohono_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load merced_pohono_sens_yr_run5000_snow_Newrun1.mat;
        case 18
            load Data_Lopez.mat;
            dataset = Data_Lopez;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load lopez_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load lopez_sens_yr_run5000_snow_Newrun1.mat;
        case 19
            load Data_Pescadero.mat;
            dataset = Data_Pescadero;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load pescadero_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load pescadero_sens_yr_run5000_snow_Newrun1.mat;
        case 20
            load Data_BigSur.mat;
            dataset = Data_BigSur;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load big_sur_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load big_sur_sens_yr_run5000_snow_Newrun1.mat;
        case 21
            load Data_DelPuerto.mat;
            dataset = Data_DelPuerto;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load del_puerto_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat;
            %load del_puerto_sens_yr_run5000_snow_Newrun1.mat;
    end
    
    for j=1981:2013 %1980:2014
        [x, ~]=find(year==j & month == 10 & day == 1);
        [y, ~]=find(year==(j+1) & month == 9 & day == 30);
        da=da+1;
        Prec_WatY_cum(da,i)=sum(precip(x:y,1));
        Temp_WatY_aver(da,i)=mean(tempaver(x:y,1));
    end
    da=0;
    
    C_m=corrcoef(SFDCE_low_yearSTi(:,2),Prec_WatY_cum(:,i));
    R2_val(i)=C_m(1,2);
    
end