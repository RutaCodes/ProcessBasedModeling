load bear_lake_SA_5000ofs_yr_snow2.mat %KGEyear
%load trinity_SA_5000sim_val_test4.mat %KGEtop_val

for i=1:60000
    KGEyear_aver_new(i,1)=nanmean(KGEyear(i,:));
end

per=1; %percent
[a,b]=sort(KGEyear_aver_new,'descend'); %a values, b index
KGEtop_values_new=a(1:(length(KGEyear_aver_new)*0.01*per));%top per percent
KGEtop_index_new=b(1:(length(KGEyear_aver_new)*0.01*per));%top per percent

clear KGEyear
load bear_lake_SA_5000ofs_yr_snow_old.mat %KGEyear

for i=1:60000
    KGEyear_aver_old(i,1)=nanmean(KGEyear(i,:));
end

per=1; %percent
[a,b]=sort(KGEyear_aver_old,'descend'); %a values, b index
KGEtop_values_old=a(1:(length(KGEyear_aver_old)*0.01*per));%top per percent
KGEtop_index_old=b(1:(length(KGEyear_aver_old)*0.01*per));%top per percent

figure;set(gcf,'color','w');
subplot(2,2,1);
edges=[min(KGEyear_aver_new):0.075:max(KGEyear_aver_new)];
%nbins=10;
%histogram(KGEyear_aver,edges,nbins);
histogram(KGEyear_aver_new,edges);
title('All KGE values (new snow)');
subplot(2,2,2);
histogram(KGEtop_values_new);
title('Top 1% KGE (new snow)');
subplot(2,2,3);
edges_old=[min(KGEyear_aver_old):0.075:max(KGEyear_aver_old)];
%nbins=10;
%histogram(KGEyear_aver,edges,nbins);
histogram(KGEyear_aver_old,edges_old);
title('All KGE values (old snow)');
subplot(2,2,4);
histogram(KGEtop_values_old);
title('Top 1% KGE (old snow)');

