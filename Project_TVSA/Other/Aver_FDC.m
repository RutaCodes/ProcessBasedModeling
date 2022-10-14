clear all; 

my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

%percent=[0.01,0.05,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,0.95,0.99];
percent=0.01:0.01:0.99;
alpha=0.1;
Nr_years=33;
Len_per=length(percent);
Med_FDC_allWS=zeros(Len_per,21);

%Defining upper and lower limits
i_low=floor((Nr_years+1)*alpha/2);
theta_low=(Nr_years+1)*alpha/2-i_low;
i_up=floor((Nr_years+1)*(1-alpha/2));
theta_up=(Nr_years+1)*(1-alpha/2)-i_up;
per_2=[theta_low,0.5,theta_up];

for i=1:21
    switch i
        case 1
            load NFCache_Streamflow2.mat
        case 2
            load SFTrinity_Streamflow2.mat
        case 3
            load noyo_Streamflow2.mat
        case 4
            load salmon_Streamflow2.mat
        case 5
            load mfeel_Streamflow2.mat
        case 6
            load VanDuzen_Streamflow2.mat
        case 7
            load little_Streamflow2.mat
        case 8
            load bull_Streamflow2.mat
        case 9
            load redwood_Streamflow2.mat
        case 10
            load smith_Streamflow2.mat
        case 11
            load trinity_Streamflow2.mat
        case 12
            load deer_Streamflow2.mat
        case 13
            load mill_Streamflow2.mat
        case 14
            load bear_Streamflow2.mat
        case 15
            load merced_happy_Streamflow2.mat
        case 16
            load merced_pohono_Streamflow2.mat
        case 17
            load pitman_Streamflow2.mat
        case 18
            load delpuerto_Streamflow2.mat
        case 19
            load lopez_Streamflow2.mat
        case 20
            load pescadero_Streamflow2.mat
        case 21
            load big_sur_Streamflow2.mat
    end

count=0;
Yrly_Q_per=zeros(Len_per,Nr_years);
year=Data_Qflow(:,1);
month=Data_Qflow(:,2);
day=Data_Qflow(:,3);
Streamflow=Data_Qflow(:,4);
for j=1981:2013 %1980:2014
    [x, xx]=find(year==j & month == 10 & day == 1);
    [y, yy]=find(year==(j+1) & month == 9 & day == 30);
    
    count=count+1;
    q_yr_val = Streamflow(x:y);
    Q_f=FDC_loop(q_yr_val,percent);
    Yrly_Q_per(:,count)=Q_f;
end

FDC_lim=zeros(Len_per,length(per_2));
for a=1:Len_per
  FDC_lim(a,:)=FDC_loop(Yrly_Q_per(a,:),per_2);
end

%saving median FDC values for each watershed
Med_FDC_allWS(:,i)=FDC_lim(:,2);

end

figure; set(gcf,'color','w');%set(gca, 'YScale', 'log');
%Group1
%subplot(5,1,1);
for i=1:21
    %plot(Med_FDC_allWS(:,i),'Color',[0.5 0.5 0.5]); hold on;
    semilogy(Med_FDC_allWS(:,i),'Color',[0.5 0.5 0.5]); hold on;
    xlim([1 99]);
end
str = '#E41A1C';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
for i=1:4
semilogy(Med_FDC_allWS(:,(22-i)),'Color',color,'LineWidth',2.5); hold on;
end
xlabel('Exceedance Probablity %');
ylabel('33-year Average Daily Streamflow (mm/day)');
title('Group 1');

figure; set(gcf,'color','w');%set(gca, 'YScale', 'log');
%Group2
%subplot(5,1,1);
for i=1:21
    %plot(Med_FDC_allWS(:,i),'Color',[0.5 0.5 0.5]); hold on;
    semilogy(Med_FDC_allWS(:,i),'Color',[0.5 0.5 0.5]); hold on;
    xlim([1 99]);
end
str = '#FF7F00';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
for i=1:5
semilogy(Med_FDC_allWS(:,i),'Color',color,'LineWidth',2.5); hold on;
end
xlabel('Exceedance Probablity %');
ylabel('33-year Average Daily Streamflow (mm/day)');
title('Group 2');

figure; set(gcf,'color','w');%set(gca, 'YScale', 'log');
%Group3
%subplot(5,1,1);
for i=1:21
    %plot(Med_FDC_allWS(:,i),'Color',[0.5 0.5 0.5]); hold on;
    semilogy(Med_FDC_allWS(:,i),'Color',[0.5 0.5 0.5]); hold on;
    xlim([1 99]);
end
str = '#4DAF4A';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
for i=1:5
semilogy(Med_FDC_allWS(:,(i+5)),'Color',color,'LineWidth',2.5); hold on;
end
xlabel('Exceedance Probablity %');
ylabel('33-year Average Daily Streamflow (mm/day)');
title('Group 3');

figure; set(gcf,'color','w');%set(gca, 'YScale', 'log');
%Group4
%subplot(5,1,1);
for i=1:21
    %plot(Med_FDC_allWS(:,i),'Color',[0.5 0.5 0.5]); hold on;
    semilogy(Med_FDC_allWS(:,i),'Color',[0.5 0.5 0.5]); hold on;
    xlim([1 99]);
end
str = '#984EA3';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
for i=1:3
semilogy(Med_FDC_allWS(:,(i+10)),'Color',color,'LineWidth',2.5); hold on;
end
xlabel('Exceedance Probablity %');
ylabel('33-year Average Daily Streamflow (mm/day)');
title('Group 4');

figure; set(gcf,'color','w');%set(gca, 'YScale', 'log');
%Group5
%subplot(5,1,1);
for i=1:21
    %plot(Med_FDC_allWS(:,i),'Color',[0.5 0.5 0.5]); hold on;
    semilogy(Med_FDC_allWS(:,i),'Color',[0.5 0.5 0.5]); hold on;
    xlim([1 99]);
end
str = '#377EB8';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
for i=1:4
semilogy(Med_FDC_allWS(:,(i+13)),'Color',color,'LineWidth',2.5); hold on;
end
xlabel('Exceedance Probablity %');
ylabel('33-year Average Daily Streamflow (mm/day)');
title('Group 5');
