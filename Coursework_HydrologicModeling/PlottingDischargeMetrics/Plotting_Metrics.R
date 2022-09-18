#Ruta Basijokaite
#----------------
#This code calculates montly streamflow averages, annual streamflow averages, maximums and 7 day minimums. In addition,
#it uses functions to calculate 100 year flood using log-Pearson III distribution and 
#3 parameter lognormal distribution. This info was plotted using sccater plots and histograms  
#----------------

#Variables:
#Genesee_data - dataset
#date - dates in POSIXlt format
#Discharge - discharge
#n_1 - dimention of dataset
#n - length of the dataset
#Start year - starting year for the dataset
#Last year - last year in the dataset
#Nr_years - number of years in the dataset
#count, count2 - counters
#Months - vector of month numbers in order for water year
#Monthly_aver - matrix where nr of rows=months and nr of comulns=years
#Monthly_discharge - discharge values in one month
#Aver_total - average discharge values in each month
#Month_out - matrix of monthly averages required for the output
#Yearly_aver - annual yearly averages
#Max_annQ - annual daily maximums
#day7_min - annual 7day minimums
#x - start of the water year index / start of month index
#y - end of the water year index
#Yearly_discharge - discharge values in one year
#len - length of one year data
#day7_aver - 7 day averages
#per_LP3 - percentile for LP3
#per_LN3 - percentile for LN3
#LN3_val - 7-day 10-year low streamflow using a 3-parameter lognormal distribution
#LP3_val - 100 year flood using a log-Pearson III distribution using regular dataset
#Genesee_peak - data for streamflow peaks 
#Peak_v - peak streamflow values 
#LP3_val_peak - 100 year flood using a log-Pearson III distribution using peak Q dataset

#Variables from LN3 function 
#zp - p-th percentile from a standard normal distribution
#Y_bar - natural log of the data average
#N - length of input
#Sy - standard deviation of Y_ap/minimum (depending if statement is correct)
#Q7_10 - 7-day 10-year low streamflow using a 3-parameter lognormal distribution
#LB_est - lower bound
#Y_ap - latural log of the data minus lower bound
#Y_bar - mean of Y_ap

#Variables from LP3 function 
#zp - p-th percentile from a standard normal distribution
#Y - log of input
#N - length of input
#Y_bar - natural log of the data minus lower bound
#Sy - standard deviation of Y_ap
#Gy - real space coeff of skewness
#Gy_ap - unbiasing factor
#Kp - frequency factor
#Q_LP3 - 100 year flood using a log-Pearson III distribution

#Uploading file
Genesee_data<-read.csv(file="Genesee_data.csv",sep=",",header=F)
# Changing date format
date=as.POSIXlt(Genesee_data[,1], format="%m/%d/%y")
Discharge<-Genesee_data[,2]
n_1<-dim(Genesee_data)
n=n_1[1]

#Determining start and end date of the dataset 
Start_year<-date$year[1]+1900
Last_year<-date$year[n]+1900
Nr_years=Last_year-Start_year

count=0.0
count2=0.0
Months<-c(10,11,12,1,2,3,4,5,6,7,8,9)
Monthly_aver<-matrix(0, nrow=length(Months), ncol=Nr_years)
#Loops to find monthly averages
for (i in seq(Start_year,Last_year-1)){
  
  count=count+1
  for (j in seq(1,length(Months))){
    count2=count2+1
    #Finding index in the dataset
    x<-which((date$year+1900)==i & (date$mon+1)==(Months[j]))
  
  if (j>3){
    x<-which((date$year+1900)==i+1 & (date$mon+1)==(Months[j]))
  }
  
    #Computing monthly averagea (not rounding for more precise calculations)
    Monthly_discharge=Discharge[x]
    Monthly_aver[count2,count]=mean(Monthly_discharge) #annual average
  }
  Monthly_discharge=0.0
  count2=0.0
}

Aver_total=0.0
for (i in seq (1,length(Months))){
  Aver_total[i]=mean(Monthly_aver[i,])
}
Month_out=matrix(0,length(Months),5, dimnames=list(c("October","November","December","January","February","March","April","May","June","July","August","Sepember"),c("1998 Q (cfs)","1999 Q (cfs)","2000 Q (cfs)","2001 Q (cfs)","20 year Q (cfs)")))
Month_out[,1]=round(Monthly_aver[,1],0)
Month_out[,2]=round(Monthly_aver[,2],0)
Month_out[,3]=round(Monthly_aver[,3],0)
Month_out[,4]=round(Monthly_aver[,4],0)
Month_out[,5]=round(Aver_total,0)

#Loops to find annual average, 7day min, and max
Yearly_aver=0.0
Max_annQ=0.0
count=0.0
day7_min=0.0
#Using for loop to estimate the streamflow average in year year
for (i in seq(Start_year,Last_year-1)){
  
  #Finding index of start of the year in the dataset
  x<-which((date$year+1900)==i & (date$mon+1)==10 & (date$mday)==1)
  #Finding the index of the end of the year in dataset
  y<-which((date$year+1900)==i+1 & (date$mon+1)==9 & (date$mday)==30)
  
  #Computing average (not rounding for more precise calculations)
  count=count+1
  Yearly_discharge=Discharge[x:y]
  Yearly_aver[count]=mean(Yearly_discharge) #annual average
  #determining annual maximum daily streamflow
  Max_annQ[count]=max(Yearly_discharge) #annual maximum
  
  len=length(Yearly_discharge)
  count2=0.0
  day7_aver=0.0
  #running 7 day average to determine 7day annual minimum
  for (j in seq(7,len)){
    count2=count2+1
    day7_aver[count2]=mean(Yearly_discharge[(j-6):j]) #7day averages
  }
  day7_min[count]=min(day7_aver) #annual 7 day minimum
}

#load functions
source("LN3_LP3_Fun.R")
per_LP3=0.99
per_LN3=0.1
LN3_val=round(LN3(day7_min,per_LN3),2)
LP3_val=round(LP3(Max_annQ,per_LP3),2)
Genesee_peak<-read.csv(file="Genesee_peak.csv",sep=",",header=T)
Peak_v=Genesee_peak[,4]
LP3_val_peak=round(LP3(Peak_v,per_LP3),2)

#Plotting
Wat_Y=c("1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")
par(mfrow=c(1,1))
plot(log="y",Wat_Y,Yearly_aver,xlab=paste("Water Year"),ylab=paste("Q (cfs)"),ylim=c(10,max(Max_annQ)),main="Annual average, daily maximum and 7-day minimum \n streamflow (1998-2017)",pch=16,cex=0.75)
points(Wat_Y,day7_min,col = "green",pch=16,cex=0.75)
points(Wat_Y,Max_annQ,col = "red",pch=16,cex=0.75)
legend(x="bottomright",legend=c("Annual average","7day min","Daily max"),col=c("black","green","red"),pch=16,cex=0.65,title="Streamflow(cfs)")

hist(day7_min,xlab=paste("7day minimim Q (cfs)"),main="7-day annual minimum streamflow distribution 1998-2017")
points(LN3_val,6,pch=16,col="red")
legend(x="topright",legend=paste("LN3 value",round(LN3_val,0),"cfs"),col=c("red"),pch=16,cex=0.65)

hist(Max_annQ,xlab=paste("Max annual daily Q (cfs)"),ylim=c(0,10),main="Annual daily maximum streamflow distribution 1998-2017")
points(LP3_val,2,pch=16,col="red")
legend(x="topright",legend=paste("LP3 value",round(LP3_val,0),"cfs"),col=c("red"),pch=16,cex=0.65)
legend(x="topleft",legend=paste("For comparison:\nLP3 value using\npeak streamflow\nvalues",round(LP3_val_peak,0),"cfs"),cex=0.65,bty = "n")
