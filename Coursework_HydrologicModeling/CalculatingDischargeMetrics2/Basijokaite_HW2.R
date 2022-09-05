#Ruta Basijokaite
#Feb/5/2019
#ERE645 Hydrologic Modeling Spring 2019
#Homework Nr2

#This code determines annual streamflow averages, maximums and 7 day minimums. In addition,
#it uses functions to calculate 100 year flood using log-Pearson III distribution and 
#3 parameter lognormal distribution

#Variables:
#Genesee_data - dataset
#date - dates in POSIXlt format
#Discharge - discharge
#n_1 - dimention of dataset
#n - length of the dataset
#Start year - starting year for the dataset
#Last year - last year in the dataset
#Yearly_aver - annual yearly averages
#Max_annQ - annual daily maximums
#day7_min - annual 7day minimums
#count,count2 - counter
#x - start of the water year index
#y - end of the water year index
#Yearly_discharge - discharge values in one year
#len - length of one year data
#day7_aver - 7 day averages
#mean_ann_aver - mean annual average discharge
#st_dev_ann_aver - standard deviation of annual average discharge
#mean_ann_max - mean annual maximum
#st_dev_ann_max - standard deviation of annual maximum
#mean_ann_7day_min - mean annual 7 day minimum
#st_dev_ann_7day_min - standard deviation of annual 7 day minimum
#per_LP3 - percentile for LP3
#per_LN3 - percentile for LN3
#LN3_val - 7-day 10-year low streamflow using a 3-parameter lognormal distribution
#LP3_val - 100 year flood using a log-Pearson III distribution

#Variables from LN3 function 
#zp - p-th percentile from a standard normal distribution
#Y_bar - natural log of the data average
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
#finding length of the dataset
n_1<-dim(Genesee_data)
n=n_1[1]

#Determining start and end date of the dataset 
Start_year<-date$year[1]+1900
Last_year<-date$year[n]+1900

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

#Mean and standard deviation of annual averages
mean_ann_aver=round(mean(Yearly_aver),2)
st_dev_ann_aver=round(sd(Yearly_aver),2)

#Mean and standard deviation of annual maximums
mean_ann_max=round(mean(Max_annQ),2)
st_dev_ann_max=round(sd(Max_annQ),2)

#Mean and standard deviation of annual 7day minimums
mean_ann_7day_min=round(mean(day7_min),2)
st_dev_ann_7day_min=round(sd(day7_min),2)

#load all function in this file
source("Basijokaite_HW2_Fun.R")
per_LP3=0.99
per_LN3=0.1
#LN3_val=round(LN3(mean_ann_7day_min,mean_ann_max,mean_ann_aver,per_LN3,Yearly_aver),2)
LN3_val=round(LN3(day7_min,per_LN3),2)
LP3_val=round(LP3(Max_annQ,per_LP3),2)

write("Ruta Basijokaite","Basijokaite_HW2.out")
write("ERE445/645 HW2","Basijokaite_HW2.out",append=T)
write("Feb 5, 2019","Basijokaite_HW2.out",append=T)
write("  ","Basijokaite_HW2.out",append=T)
write("Annual average, maximum, and 7day minimum discharge values from Genesee River:","Basijokaite_HW2.out",append=T)
write(paste(1998:2017,"annual average =", round(Yearly_aver,0),"cfs; maximum =",Max_annQ,"cfs; minimum =",round(day7_min,0),"cfs"),"Basijokaite_HW2.out",append=T)
write("  ","Basijokaite_HW2.out",append=T)
write(paste("Mean of annual averages =",mean_ann_aver,"cfs"),"Basijokaite_HW2.out",append=T)
write(paste("Standard deviation of annual averages =",st_dev_ann_aver,"cfs"),"Basijokaite_HW2.out",append=T)
write(paste("Mean of annual maximums =",mean_ann_max,"cfs"),"Basijokaite_HW2.out",append=T)
write(paste("Standard deviation of annual maximums =",st_dev_ann_max,"cfs"),"Basijokaite_HW2.out",append=T)
write(paste("Mean of annual 7day minimums =",mean_ann_7day_min,"cfs"),"Basijokaite_HW2.out",append=T)
write(paste("Standard deviation of annual 7day minimums =",st_dev_ann_7day_min,"cfs"),"Basijokaite_HW2.out",append=T)
write("  ","Basijokaite_HW2.out",append=T)
write(paste("100 year flood using a log-Pearson III distribution =",LP3_val,"cfs"),"Basijokaite_HW2.out",append=T)
write(paste("7-day 10-year low streamflow using a 3-parameter lognormal distribution =",LN3_val,"cfs"),"Basijokaite_HW2.out",append=T)
