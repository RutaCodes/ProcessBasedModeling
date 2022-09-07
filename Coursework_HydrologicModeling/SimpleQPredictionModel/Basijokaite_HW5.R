#Ruta Basijokaite
#Mar/20/2019
#ERE645 Hydrologic Modeling Spring 2019
#Homework Nr5

#This code predicts streamflow using simple Q=P-E model and calculates 
#variuous statistics to estimate its accuracy. Evaporatraspiration
#is calculated using Hamon method

#-----------------
#Variables
#Climate - climate data downloaded from NOAA website
#Climate_data - date, temp and precip values extracted from original dataset
#L1, L2 - min and max date values 
#Clim_compl - data frame that includes all days in period of interest
#Clim_all - dataset with identified, but not corrected missing date values
#len - length of dataset
#Precip - precipitation values in inches
#T_max - T max values in F
#T_min - T min values in F
#Genesee_data - observed dataset
#Discharge_obs - observed discharge
#date - dates
#T_max_cor - corrected T max values
#T_min_cor - corrected T min values
#P_cor - corrected precip values
#mini - value holder
#Precip_cm - precipitation values in cm
#Temp - average temp in F
#Temp_C - average temp in C
#E_calcul - estimated evapotranspiration values using Hamon method
#Area - watershed area
#Q_cal - predicted streaflow in cm3/day
#Q_cfs - predicted streaflow in cfs
#Ann_obs - annual observed streamflow statistics
#Yearly_aver_obs - observed yearly average
#Yearly_max_obs - observed yearly max
#Min7_10_obs - observed 7day min
#Ann_pred - annual predicted streamflow statistics
#Yearly_aver_pred - predicted yearly average
#Yearly_max_pred - predicted yearly max
#Min7_10_pred - predicted 7day min
#Mon_obs - monthly observed streamflow statistics
#Mon_pred - monthly predicted streamflow statistics
#Mon_aver - monthly predicted streamflow statistics in array
#Mon_aver_obs - monthly observed streamflow statistics in array
#Aver_daily - predicted monthly average daily streamflow
#Aver_daily_obs - observed monthly average daily streamflow
#l - number of months
#Wat_Y - water years
#Mon - months
#bias_ann_v - bias of annual averages
#bias_mon_v - bias of monthly daily averages
#NSE_ann_v - NSE of annual averages
#NSE_mon_v - NSE of monthly daily averages
#Q_sort - Q values sorted in decreasing order
#rank - rank
#Ex_p - exceedence probability
#percent - percentiles of interest
#i1 - estimated rank at certain percentile
#theta - estimator
#Q_f - Q at specified percentiles
#Q_f_r - Q at specified percentiles rounded to first integer
#FDC - flow duration curve variables 
#-----------------

#Uploading file to use from predicting streamflow values
Climate<-read.csv(file="Climate_data.csv",sep=",",header=T)
Climate_data=Climate[,c("DATE","PRCP","TMAX","TMIN")]
Climate_data$DATE=as.Date(Climate_data$DATE,format="%Y-%m-%d")
#Creating new data frame with all days
L1=min(Climate_data$DATE)
LL=max(Climate_data$DATE)
Clim_compl=data.frame(DATE=seq(L1,LL,by="day"))
#Merging incoplete and complete dataframes to correct missing days
Clim_all=merge(Clim_compl,Climate_data,by="DATE",all.x=TRUE)
len=dim(Clim_all)[1]

Precip=Clim_all$PRCP #inches
T_max=Clim_all$TMAX #F
T_min=Clim_all$TMIN #F

#Observed values
Genesee_data<-read.csv(file="Genesee_data.csv",sep=",",header=F)
Discharge_obs<-Genesee_data[,2]
date=as.POSIXlt(Genesee_data[,1], format="%m/%d/%y")

#Correcting NA values
source("NA_cor_fun.R")
T_max_cor=NA_correct(T_max)
T_min_cor=NA_correct(T_min)
P_cor=NA_correct(Precip)

#Replacing values where Tmin is > than Tmax
mini=0
for (i in seq(1,len)){
  if (T_max_cor[i]<T_min_cor[i]){
    mini=T_min_cor[i]
    T_min_cor[i]=T_max_cor[i]
    T_max_cor[i]=mini
  }
}
#Converting units
Precip_cm=P_cor*2.54 #in cm
Temp=(T_max_cor+T_min_cor)/2 #F
Temp_C=(Temp-32)*(5/9)

source("E_cal_fun.R")
E_calcul=E_cal(date,Temp_C)

#Calculating/Predicting Streamflow assuming Q=P-E
Area=984*2.59*10^10 #mi2 to cm2
Q_cal=(Precip_cm-E_calcul)*Area #cm3/day
Q_cfs=Q_cal*4.08734569*10^(-10) #cfs

#Calculate mean annual daily average, annual maximum, 7-day annual minimum, 
#monthly average daily,streamflow, and average monthly streamflow
source("Average_fun.R")
#Observed Annual averages
Ann_obs=Annual_loop(date,Discharge_obs)
Yearly_aver_obs=Ann_obs[,1]
Yearly_max_obs=Ann_obs[,2]
Min7_10_obs=Ann_obs[,3]
#Predicted Annual averages
Ann_pred=Annual_loop(date,Q_cfs)
Yearly_aver_pred=Ann_pred[,1]
Yearly_max_pred=Ann_pred[,2]
Min7_10_pred=Ann_pred[,3]

#Monthly averages
Mon_obs=Monthly_loop(date,Discharge_obs)
Mon_pred=Monthly_loop(date,Q_cfs)

#Changing matrix dimentions
Mon_aver=matrix(Mon_pred,,1)
Mon_aver_obs=matrix(Mon_obs,,1)

#Monthly average daily streamflow
Aver_daily=0.0
Aver_daily_obs=0.0
l=dim(Mon_obs)[1]
for (i in seq (1,l)){
  Aver_daily[i]=mean(Mon_pred[i,])
  Aver_daily_obs[i]=mean(Mon_obs[i,])
}

#Bias and Nash Sutcliffe Efficiency
source("Bias_NSE.R")
bias_ann_v=Bias_v(Yearly_aver_pred,Yearly_aver_obs)
bias_mon_v=Bias_v(Mon_aver,Mon_aver_obs)
NSE_ann_v=NSE_v(Yearly_aver_pred,Yearly_aver_obs)
NSE_mon_v=NSE_v(Mon_aver,Mon_aver_obs)

#Comparing observed and simulated streamflow
par(mfrow=c(1,1))
Wat_Y=c("1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")
Mon=c("Oct","Nov","Dec","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep")
plot(1:12,Aver_daily_obs,xaxt = "n",xlab=paste("Month"),ylab=paste("Q (cfs)"),ylim=c(min(Aver_daily),max(Aver_daily_obs)),main="Observed vs predicted montly \ndaily average streamflow (1998-2017)",pch=1,cex=1)
points(1:12,Aver_daily,col = "red",pch=17,cex=0.75)
axis(1, at=1:12, labels=Mon)
legend(x="bottomleft",legend=c("Observed","Predicted"),col=c("black","red"),pch=c(1,17),cex=0.65)
legend(x="topright",legend=paste("NSE= ",NSE_mon_v,"\nBias= ",bias_mon_v),cex=0.65,bty = "n")

plot(Wat_Y,Yearly_aver_obs,xlab=paste("Years"),ylab=paste("Q (cfs)"),ylim=c(-800,max(Yearly_aver_obs)),main="Observed vs predicted annual \ndaily average streamflow (1998-2017)",pch=16,cex=0.75)
points(Wat_Y,Yearly_aver_pred,col = "red",pch=17,cex=0.75)
legend(x="bottomleft",legend=c("Observed","Predicted"),col=c("black","red"),pch=c(16,17),cex=0.65)
legend(x="topright",legend=paste("NSE= ",NSE_ann_v,"\nBias= ",bias_ann_v),cex=0.65,bty = "n")

#Flow Duration curve
Q_sort=sort(Discharge_obs,decreasing=TRUE)
rank=1:len
Ex_p=(rank/(1+len))#*100
#FDC quantiles with specified exceedance probability
percent=c(0.01,0.05,0.1,0.25,0.5,0.75,0.9,0.95,0.99)
i1=floor((len+1)*percent)
theta=((len+1)*percent-i1)
Q_f=(1-theta)*Q_sort[i1]+theta*Q_sort[i1+1]
Q_f_r=round(Q_f,0)
FDC=cbind(percent,Q_f_r)
colnames(FDC)=c("Exceedence Probability","Streamflow(cfs)")
print(FDC)

plot(log="y",Ex_p,Q_sort,type="l",xlab=paste("Exceedance probability"),ylab=paste("Streamflow (cfs)"),main="Flow Duration Curve")
points(percent,Q_f,col = "red",pch=16,cex=0.8)
legend(x="topright",legend=c("Specified \nquantiles"),col=c("red"),pch=16,cex=0.65,bty = "n")
