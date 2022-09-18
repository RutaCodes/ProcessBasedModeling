#Ruta Basijokaite
#----------------
#This code calculates median flow duration curve and 90% confidence intervals
#----------------

#Variables used:
#Genesee_data - observed dataset
#Discharge_obs - observed discharge
#date - dates
#len,len1,len2 - length of dataset
#Start_year - start year in the datset
#Last_year - last year in the dataset
#Nr_years - nr of years in the dataset
#percent - specified percentiles
#alpha - confidence level
#Len_per - number of specified percentiles
#Yrly_Q_per - calculated streamflow at specified percentiles
#x, y - index 
#count - counter
#Yearly_discharge - yearly discharge values
#Q_f - sorted Q values from highest to lowest
#i_low - rank of the lower percentile
#theta_low - percentile of the lower bound
#i_up - rank of the upper percentile
#theta_up - percentile of the upper bound
#per_2 - percentiles for the upper, lower and median bounds
#FDC_lim - matrix with streamflows for upper, lower and median -
#percetiles for the specified confidence interval

#Observed values from Genesee River at Portageville
Genesee_data<-read.csv(file="Genesee_data.csv",sep=",",header=F)
Discharge_obs<-Genesee_data[,2]
date=as.POSIXlt(Genesee_data[,1], format="%m/%d/%y")
len1=dim(Genesee_data)[1]

Start_year<-date$year[1]+1900
Last_year<-date$year[len1]+1900
Nr_years=Last_year-Start_year  

percent=c(0.01,0.05,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,0.95,0.99)
alpha=0.1
Len_per=length(percent)
source("FDC_fun.R")

count=0
Yrly_Q_per=matrix(0,nrow=Len_per,ncol=Nr_years)
for (i in seq(Start_year,Last_year-1)){
  
  #Finding index of start of the year in the dataset
  x<-which((date$year+1900)==i & (date$mon+1)==10 & (date$mday)==1)
  #Finding the index of the end of the year in dataset
  y<-which((date$year+1900)==i+1 & (date$mon+1)==9 & (date$mday)==30)
  
  #Computing average (not rounding for more precise calculations)
  count=count+1
  Yearly_discharge=Discharge_obs[x:y]
  Q_f=FDC_loop(Yearly_discharge,percent)
  Yrly_Q_per[,count]=Q_f
}

#Defining upper and lower limits
i_low=floor((Nr_years+1)*alpha/2)
theta_low=(Nr_years+1)*alpha/2-i_low
i_up=floor((Nr_years+1)*(1-alpha/2))
theta_up=(Nr_years+1)*(1-alpha/2)-i_up
per_2=c(theta_low,0.5,theta_up)

FDC_lim=matrix(0,Len_per,length(per_2))
for(i in seq(1,Len_per)){
  FDC_lim[i,]=FDC_loop(Yrly_Q_per[i,],per_2)
}

Table1=data.frame(percent,FDC_lim[,2],FDC_lim[,1],FDC_lim[,3])
colnames(Table1)[1] <- "Ex Prob"
colnames(Table1)[2] <- "Median Ann FDC"
colnames(Table1)[3] <- "Upper 90% CI"
colnames(Table1)[4] <- "Lower 90% CI"

par(mfrow=c(1,1))
plot(log="y",percent,FDC_lim[,2],type="l",xlab=paste("Exceedance probability"),ylab=paste("Streamflow (cfs)"),ylim=c(min(FDC_lim[,3]),max(FDC_lim[,1])),main="Median FDC with 90% \nconfidence intervals")
points(percent,FDC_lim[,1],type="l",lty=2)
points(percent,FDC_lim[,3],type="l",lty=2)
legend(x="topright",legend=c("Median Annual FDC","90% Confidence Interval"),col=c("black","black"),lty=c(1,2),cex=0.65,bty = "n")
