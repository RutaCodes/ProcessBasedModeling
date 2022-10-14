clear all; 
global Data

my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

for i=1:4
    switch i
        case 1
            load Data_Bear_Lake.mat;
            dataset = Data_Bear_Lake;
            year = dataset(:,1);
            month = dataset(:,2);
            day = dataset(:,3);
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load bear_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load bear_sens_yr_run5000_snow_HydSigRun2.mat;
            load bear_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load bear_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 2
            load Data_Merced_Happy.mat;
            dataset = Data_Merced_Happy;
            year = dataset(:,1);
            month = dataset(:,2);
            day = dataset(:,3);
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load merced_happy_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load merced_happy_sens_yr_run5000_snow_HydSigRun2.mat;
            load merced_happy_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load merced_happy_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 3
            load Data_Merced_Pohono.mat;
            dataset = Data_Merced_Pohono;
            year = dataset(:,1);
            month = dataset(:,2);
            day = dataset(:,3);
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load merced_pohono_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load merced_pohono_sens_yr_run5000_snow_HydSigRun2.mat;
            load merced_pohono_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load merced_pohono_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
        case 4
            load Data_Pitman.mat;
            dataset = Data_Pitman;
            year = dataset(:,1);
            month = dataset(:,2);
            day = dataset(:,3);
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            load pitman_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat;
            load pitman_sens_yr_run5000_snow_HydSigRun2.mat;
            load pitman_hymod_5000hyd_objFun_snow_HydSigRun2.mat;
            load pitman_sens_yr_run5000_hydr_sig_HydSigRun2.mat;
    end
    
    KGE_yr_val_TM(:,i)=KGEyearSTi(:,9);
    KGE_yr_val_Kf(:,i)=KGEyearSTi(:,8);
    
    da=0;
    for j=1981:2013 %1980:2014
        [x, ~]=find(year==j & month == 10 & day == 1);
        [y, ~]=find(year==(j+1) & month == 9 & day == 30);
        da=da+1;
        Prec_WatY_cum(da,i)=sum(precip(x:y,1));
        Temp_WatY_aver(da,i)=mean(tempaver(x:y,1));
    end
    
end

figure; set(gcf,'color','w'); sz=25;sz2=22;
scatter(Temp_WatY_aver(:,1),KGE_yr_val_Kf(:,1),sz,'filled','g');hold on;
p=polyfit(Temp_WatY_aver(:,1),KGE_yr_val_Kf(:,1),1);
y1=[(p(1)*(-1)+p(2)),(p(1)*7+p(2))];line1(4,1)=p(1);line1(4,2)=p(2);
C=corrcoef(Temp_WatY_aver(:,1),KGE_yr_val_Kf(:,1));
C1=C(1,2);

scatter(Temp_WatY_aver(:,2),KGE_yr_val_Kf(:,2),sz,'filled','b');hold on;
p=polyfit(Temp_WatY_aver(:,2),KGE_yr_val_Kf(:,2),1);
y2=[(p(1)*(-1)+p(2)),(p(1)*7+p(2))];line1(4,1)=p(1);line1(4,2)=p(2);
C=corrcoef(Temp_WatY_aver(:,2),KGE_yr_val_Kf(:,2));
C2=C(1,2);

scatter(Temp_WatY_aver(:,3),KGE_yr_val_Kf(:,3),sz,'filled','m');hold on;
p=polyfit(Temp_WatY_aver(:,3),KGE_yr_val_Kf(:,3),1);
y3=[(p(1)*(-1)+p(2)),(p(1)*7+p(2))];line1(4,1)=p(1);line1(4,2)=p(2);
C=corrcoef(Temp_WatY_aver(:,3),KGE_yr_val_Kf(:,3));
C3=C(1,2);

scatter(Temp_WatY_aver(:,4),KGE_yr_val_Kf(:,4),sz,'filled','r');hold on;
p=polyfit(Temp_WatY_aver(:,4),KGE_yr_val_Kf(:,4),1);
y4=[(p(1)*(-1)+p(2)),(p(1)*7+p(2))];line1(4,1)=p(1);line1(4,2)=p(2);
C=corrcoef(Temp_WatY_aver(:,4),KGE_yr_val_Kf(:,4));
C4=C(1,2);

plot([-1 7],y1,'--g');hold on;
plot([-1 7],y2,'--b');hold on;
plot([-1 7],y3,'--m');hold on;
plot([-1 7],y4,'--r');

legend(['BEA R = ', num2str(C1)],['MHA R = ', num2str(C2)],['MPO R = ',num2str(C3)],['PIT R = ',num2str(C4)],'Location','northeastoutside');
legend('boxoff'); grid;
xlabel('Mean Annual Temperature'); ylabel('Kf STi');
ylim([0 0.6]); xlim([-1 7]);

figure; set(gcf,'color','w'); sz=25;sz2=22;
scatter(Temp_WatY_aver(:,1),KGE_yr_val_TM(:,1),sz,'filled','g');hold on;
p=polyfit(Temp_WatY_aver(:,1),KGE_yr_val_TM(:,1),1);
y1=[(p(1)*(-1)+p(2)),(p(1)*7+p(2))];line1(4,1)=p(1);line1(4,2)=p(2);
C=corrcoef(Temp_WatY_aver(:,1),KGE_yr_val_TM(:,1));
C1=C(1,2);

scatter(Temp_WatY_aver(:,2),KGE_yr_val_TM(:,2),sz,'filled','b');hold on;
p=polyfit(Temp_WatY_aver(:,2),KGE_yr_val_TM(:,2),1);
y2=[(p(1)*(-1)+p(2)),(p(1)*7+p(2))];line1(4,1)=p(1);line1(4,2)=p(2);
C=corrcoef(Temp_WatY_aver(:,2),KGE_yr_val_TM(:,2));
C2=C(1,2);

scatter(Temp_WatY_aver(:,3),KGE_yr_val_TM(:,3),sz,'filled','m');hold on;
p=polyfit(Temp_WatY_aver(:,3),KGE_yr_val_TM(:,3),1);
y3=[(p(1)*(-1)+p(2)),(p(1)*7+p(2))];line1(4,1)=p(1);line1(4,2)=p(2);
C=corrcoef(Temp_WatY_aver(:,3),KGE_yr_val_TM(:,3));
C3=C(1,2);

scatter(Temp_WatY_aver(:,4),KGE_yr_val_TM(:,4),sz,'filled','r');hold on;
p=polyfit(Temp_WatY_aver(:,4),KGE_yr_val_TM(:,4),1);
y4=[(p(1)*(-1)+p(2)),(p(1)*7+p(2))];line1(4,1)=p(1);line1(4,2)=p(2);
C=corrcoef(Temp_WatY_aver(:,4),KGE_yr_val_TM(:,4));
C4=C(1,2);

plot([-1 7],y1,'--g');hold on;
plot([-1 7],y2,'--b');hold on;
plot([-1 7],y3,'--m');hold on;
plot([-1 7],y4,'--r');

legend(['BEA R = ', num2str(C1)],['MHA R = ', num2str(C2)],['MPO R = ',num2str(C3)],['PIT R = ',num2str(C4)],'Location','northeastoutside');
legend('boxoff'); grid;
xlabel('Mean Annual Temperature'); ylabel('TM STi');
ylim([0 0.6]); xlim([-1 7]);

