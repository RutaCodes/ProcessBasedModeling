my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

% test vfector length
load Data_Bear_Lake.mat
dataset = Data_Bear_Lake;%(1:12692,:);
year = dataset(:,1);
month = dataset(:,2);
day = dataset(:,3);
[a, xx]=find(year==1981 & month == 10 & day == 1);
[b, yy]=find(year==2013 & month == 9 & day == 30);
precip_test=dataset(a:b,6);
dataset_test=dataset(a:b,:);

%precip=zeros(length(precip_test),5);
da = 0; %annual averages
% Prec_WatY=zeros(33,365);
for x=1:5
    switch x
        case 1
            load Data_Bear_Lake.mat
            dataset = Data_Bear_Lake;
            year = dataset(:,1);
            month = dataset(:,2);
            day = dataset(:,3);
            [a, xx]=find(year==1981 & month == 10 & day == 1);
            [b, yy]=find(year==2013 & month == 9 & day == 30);
            %precip(:,x)=dataset(a:b,6);
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            for j=1981:2013 %1980:2014
                [a, ~]=find(year==j & month == 10 & day == 1);
                [b, ~]=find(year==(j+1) & month == 9 & day == 30);
                
                da=da+1;
                Prec_WatY_aver(da,x)=mean(precip(a:b,1));
                Prec_WatY_cum(da,x)=sum(precip(a:b,1));
                AT_aver(da,x)=mean(tempaver(a:b,1));
            end
        case 2
            load Data_Blackwood_Cr.mat
            dataset = Data_Blackwood_Cr;
            year = dataset(:,1);
            month = dataset(:,2);
            day = dataset(:,3);
            [a, xx]=find(year==1981 & month == 10 & day == 1);
            [b, yy]=find(year==2013 & month == 9 & day == 30);
%             precip(:,x)=dataset(a:b,6);
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            for j=1981:2013 %1980:2014
                [a, ~]=find(year==j & month == 10 & day == 1);
                [b, ~]=find(year==(j+1) & month == 9 & day == 30);
                
                da=da+1;
                Prec_WatY_aver(da,x)=mean(precip(a:b,1));
                Prec_WatY_cum(da,x)=sum(precip(a:b,1));
                AT_aver(da,x)=mean(tempaver(a:b,1));
            end
        case 3
            load Data_Merced_Happy.mat
            dataset = Data_Merced_Happy;
            year = dataset(:,1);
            month = dataset(:,2);
            day = dataset(:,3);
            [a, xx]=find(year==1981 & month == 10 & day == 1);
            [b, yy]=find(year==2013 & month == 9 & day == 30);
            %precip(:,x)=dataset(a:b,6);
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            for j=1981:2013 %1980:2014
                [a, ~]=find(year==j & month == 10 & day == 1);
                [b, ~]=find(year==(j+1) & month == 9 & day == 30);
                
                da=da+1;
                Prec_WatY_aver(da,x)=mean(precip(a:b,1));
                Prec_WatY_cum(da,x)=sum(precip(a:b,1));
                AT_aver(da,x)=mean(tempaver(a:b,1));
            end
        case 4
            load Data_Merced_Pohono.mat
            dataset = Data_Merced_Pohono;
            year = dataset(:,1);
            month = dataset(:,2);
            day = dataset(:,3);
            [a, xx]=find(year==1981 & month == 10 & day == 1);
            [b, yy]=find(year==2013 & month == 9 & day == 30);
            %precip(:,x)=dataset(a:b,6);
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            for j=1981:2013 %1980:2014
                [a, ~]=find(year==j & month == 10 & day == 1);
                [b, ~]=find(year==(j+1) & month == 9 & day == 30);
                
                da=da+1;
                Prec_WatY_aver(da,x)=mean(precip(a:b,1));
                Prec_WatY_cum(da,x)=sum(precip(a:b,1));
                AT_aver(da,x)=mean(tempaver(a:b,1));
            end
        case 5
            load Data_Trinity_R.mat
            dataset = Data_Trinity_R;
            year = dataset(:,1);
            month = dataset(:,2);
            day = dataset(:,3);
            [a, xx]=find(year==1981 & month == 10 & day == 1);
            [b, yy]=find(year==2013 & month == 9 & day == 30);
            %precip(:,x)=dataset(a:b,6);
            precip=dataset(:,6);
            tempaver=(dataset(:,9)+ dataset(:,10))/2;
            for j=1981:2013 %1980:2014
                [a, ~]=find(year==j & month == 10 & day == 1);
                [b, ~]=find(year==(j+1) & month == 9 & day == 30);
                
                da=da+1;
                Prec_WatY_aver(da,x)=mean(precip(a:b,1));
                Prec_WatY_cum(da,x)=sum(precip(a:b,1));
                AT_aver(da,x)=mean(tempaver(a:b,1));
            end
    end
    da=0;
end

WS_name=["Bear","Blackwood","M.Happy","M.Pohono","Trinity"]
figure; set(gcf,'color','w');
for i=1:5
   subplot (1, 5, i);
   plot(Prec_WatY_cum(:,i),1:33);hold on;
   xlabel('Cum. P'); ylim([1 33]);
   title(sprintf('%s',WS_name(i)));
   yticks([5 10 15 20 25 30]);
   yticklabels({'1985','1990','1995','2000','2005','2010'});
end

figure; set(gcf,'color','w');
for i=1:5
   subplot (1, 5, i);
   plot(AT_aver(:,i),1:33);hold on;
   xlabel('Aver AT'); ylim([1 33]);
   title(sprintf('%s',WS_name(i)));
   yticks([5 10 15 20 25 30]);
   yticklabels({'1985','1990','1995','2000','2005','2010'});
end
%ylabel('Cumulative precipitation');% xlim([1 33]);
% xticks([1189 3015 4841 6667 8494 10320]);
% yticks([5 10 15 20 25 30]);
% yticklabels({'1985','1990','1995','2000','2005','2010'});
%legend('Bear','Blackwood','M. Happy','M.Pohono','Trinity');

figure; set(gcf,'color','w');
plot(Prec_WatY_cum);
ylabel('Cumulative precipitation'); xlim([1 33]);
% xticks([1189 3015 4841 6667 8494 10320]);
xticks([5 10 15 20 25 30]);
xticklabels({'1985','1990','1995','2000','2005','2010'});
legend('Bear','Blackwood','M. Happy','M.Pohono','Trinity');
            
% figure; set(gcf,'color','w');
% boxplot(Prec_WatY_cum);
% ylabel('Cumulative precipitation'); 
% xticks([1 2 3 4 5]);
% xticklabels({'Bear','Blackwood','M. Happy','M. Pohono','Trinity'});           
            
            
            