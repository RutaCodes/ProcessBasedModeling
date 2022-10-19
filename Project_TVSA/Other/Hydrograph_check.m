%Ruta Basijokaite

load merced_pohono_Streamflow.mat %Streamflow

figure; set(gcf,'color','w');
for j=1981:2013 %1980:2014
        [x, xx]=find(year==j & month == 10 & day == 1);
        [y, yy]=find(year==(j+1) & month == 9 & day == 30);
        
        da = da+1;
        qoyr = Streamflow(x:y);
        plot(qoyr); hold on; xlim([1 365]);
end
ylabel('Q'); title('Merced Pohono');
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

clear Streamflow;

load merced_happy_Streamflow.mat

figure; set(gcf,'color','w');
for j=1981:2013 %1980:2014
        [x, xx]=find(year==j & month == 10 & day == 1);
        [y, yy]=find(year==(j+1) & month == 9 & day == 30);
        
        da = da+1;
        qoyr = Streamflow(x:y);
        plot(qoyr); hold on; xlim([1 365]);
end
ylabel('Q'); title('Merced Happy');
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

clear Streamflow;

load pitman_Streamflow.mat

figure; set(gcf,'color','w');
for j=1981:2013 %1980:2014
        [x, xx]=find(year==j & month == 10 & day == 1);
        [y, yy]=find(year==(j+1) & month == 9 & day == 30);
        
        da = da+1;
        qoyr = Streamflow(x:y);
        plot(qoyr); hold on; xlim([1 365]);
end
ylabel('Q'); title('Pitman');
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

clear Streamflow;

load bear_Streamflow.mat

figure; set(gcf,'color','w');
for j=1981:2013 %1980:2014
        [x, xx]=find(year==j & month == 10 & day == 1);
        [y, yy]=find(year==(j+1) & month == 9 & day == 30);
        
        da = da+1;
        qoyr = Streamflow(x:y);
        plot(qoyr); hold on; xlim([1 365]);
end
ylabel('Q'); title('Bear');
xticks([32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
