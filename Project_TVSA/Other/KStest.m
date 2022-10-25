%Ruta Basijokaite

clear all; 
global Data

my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

%define varaibe that can be used for confidence interval
sig_WS_KGE=zeros(21,10);
sig_WS_SFDCE=zeros(21,10);
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
%             load NFCache_sens_yr_hyd_SFDCE_run5000_snow_Newrun1.mat; %SFDCE values
%             load NFCache_sens_yr_run5000_snow_Newrun1.mat; %KGE values
            load NFCache_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat; %SFDCE values
            load NFCache_sens_yr_run5000_snow_HydSigRun2.mat; %KGE values
            load NFCache_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 2
            load Data_Noyo.mat;
            dataset = Data_Noyo;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load noyo_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat; 
            load noyo_sens_yr_run5000_snow_HydSigRun2.mat;
            load noyo_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 3
            load Data_MFEel.mat;
            dataset = Data_MFEel;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load mfeel_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat; 
            load mfeel_sens_yr_run5000_snow_HydSigRun2.mat;
            load mfeel_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 4 
            load Data_Salmon.mat;
            dataset = Data_Salmon;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load salmon_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load salmon_sens_yr_run5000_snow_HydSigRun2.mat;
            load salmon_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 5
            load Data_SFTrinity.mat;
            dataset = Data_SFTrinity;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load SFTrinity_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load SFTrinity_sens_yr_run5000_snow_HydSigRun2.mat;
            load SFTrinity_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 6 
            load Data_Bull.mat;
            dataset = Data_Bull;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load bull_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load bull_sens_yr_run5000_snow_HydSigRun2.mat;
            load bull_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 7
            load Data_Little.mat;
            dataset = Data_Little;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load little_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load little_sens_yr_run5000_snow_HydSigRun2.mat;
            load little_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 8
            load Data_VanDuzen.mat;
            dataset = Data_VanDuzen;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load VanDuzen_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load VanDuzen_sens_yr_run5000_snow_HydSigRun2.mat;
            load VanDuzen_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 9
            load Data_Redwood.mat;
            dataset = Data_Redwood;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load redwood_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load redwood_sens_yr_run5000_snow_HydSigRun2.mat;
            load redwood_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 10
            load Data_Smith.mat;
            dataset = Data_Smith;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load smith_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load smith_sens_yr_run5000_snow_HydSigRun2.mat;
            load smith_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 11
            load Data_Mill.mat;
            dataset = Data_Mill;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load mill_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load mill_sens_yr_run5000_snow_HydSigRun2.mat;
            load mill_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 12
            load Data_Trinity_R.mat;
            dataset = Data_Trinity_R;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load trinity_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load trinity_sens_yr_run5000_snow_HydSigRun2.mat;
            load trinity_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 13
            load Data_Deer.mat;
            dataset = Data_Deer;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load deer_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load deer_sens_yr_run5000_snow_HydSigRun2.mat;
            load deer_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 14
            load Data_Pitman.mat;
            dataset = Data_Pitman;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load pitman_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load pitman_sens_yr_run5000_snow_HydSigRun2.mat;
            load pitman_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 15
            load Data_Bear_Lake.mat;
            dataset = Data_Bear_Lake;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load bear_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load bear_sens_yr_run5000_snow_HydSigRun2.mat;
            load bear_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 16
            load Data_Merced_Happy.mat;
            dataset = Data_Merced_Happy;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load merced_happy_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load merced_happy_sens_yr_run5000_snow_HydSigRun2.mat;
            load merced_happy_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 17
            load Data_Merced_Pohono.mat;
            dataset = Data_Merced_Pohono;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load merced_pohono_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load merced_pohono_sens_yr_run5000_snow_HydSigRun2.mat;
            load merced_pohono_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 18
            load Data_Lopez.mat;
            dataset = Data_Lopez;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load lopez_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load lopez_sens_yr_run5000_snow_HydSigRun2.mat;
            load lopez_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 19
            load Data_Pescadero.mat;
            dataset = Data_Pescadero;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load pescadero_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load pescadero_sens_yr_run5000_snow_HydSigRun2.mat;
            load pescadero_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 20
            load Data_BigSur.mat;
            dataset = Data_BigSur;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load big_sur_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load big_sur_sens_yr_run5000_snow_HydSigRun2.mat;
            load big_sur_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
        case 21
            load Data_DelPuerto.mat;
            dataset = Data_DelPuerto;
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load del_puerto_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load del_puerto_sens_yr_run5000_snow_HydSigRun2.mat;
            load del_puerto_sens_yr_run5000_hydr_sig_HydSigRun2.mat; %CoMSTi
    end
    
    d1=0;
    d2=0;
    for j=1:33
        if (j>5) && (j<12)
            d1=d1+1;
            Par_dry_KGE(d1,:)=KGEyearSTi(j,:);
            %Par_dry_SFDCE(d1,:)=SFDCE_low_yearSTi(j,:);
            Par_dry_SFDCE(d1,:)=abs(SFDCyearSTi(j,:));
            Par_dry_CoM(d1,:)=CoMyearSTi(j,:);
            Par_dry_RR(d1,:)=RRyearSTi(j,:);
            Par_dry_BFI(d1,:)=ArBFIyearSTi(j,:);
        elseif j>30
            d1=d1+1;
            Par_dry_KGE(d1,:)=KGEyearSTi(j,:);
            %Par_dry_SFDCE(d1,:)=SFDCE_low_yearSTi(j,:);
            Par_dry_SFDCE(d1,:)=abs(SFDCyearSTi(j,:));
            Par_dry_CoM(d1,:)=CoMyearSTi(j,:);
            Par_dry_RR(d1,:)=RRyearSTi(j,:);
            Par_dry_BFI(d1,:)=ArBFIyearSTi(j,:);
        else
            d2=d2+1;
            Par_non_KGE(d2,:)=KGEyearSTi(j,:);
            %Par_non_SFDCE(d2,:)=SFDCE_low_yearSTi(j,:);
            Par_non_SFDCE(d2,:)=abs(SFDCyearSTi(j,:));
            Par_non_CoM(d2,:)=CoMyearSTi(j,:);
            Par_non_RR(d2,:)=RRyearSTi(j,:);
            Par_non_BFI(d2,:)=ArBFIyearSTi(j,:);
        end
    end
    
    for x=1:10
        [h_KGE,p_KGE]=kstest2(Par_dry_KGE(:,x),Par_non_KGE(:,x));
        [h_SFDCE,p_SFDCE]=kstest2(Par_dry_SFDCE(:,x),Par_non_SFDCE(:,x));
        [h_CoM,p_CoM]=kstest2(Par_dry_CoM(:,x),Par_non_CoM(:,x));
        [h_RR,p_RR]=kstest2(Par_dry_RR(:,x),Par_non_RR(:,x));
        [h_BFI,p_BFI]=kstest2(Par_dry_BFI(:,x),Par_non_BFI(:,x));
        sig_WS_KGE(i,x)=h_KGE;
        sig_WS_SFDCE(i,x)=h_SFDCE;
        sig_WS_KGE_p(i,x)=p_KGE;
        sig_WS_SFDCE_p(i,x)=p_SFDCE;
        sig_WS_CoM_p(i,x)=p_CoM;
        sig_WS_RR_p(i,x)=p_RR;
        sig_WS_BFI_p(i,x)=p_BFI;
    end
    
end
