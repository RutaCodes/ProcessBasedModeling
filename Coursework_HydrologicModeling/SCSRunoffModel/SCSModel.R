#Ruta Basijokaite
#---------------- 
#This code predict streamflow values using SCS Runoff Model (surface runoff is 
#incorporated as well as subsurface discharge)
#---------------- 

#Pseudocode for SCS Runoff model:
#1) Import data about different land cover types covering Genesee River watershed
#2) Calculate weighted CN2 number from lancover data
#3) Determine CN1 and CN3 using formulas
#4) Determine A1 and A2 antecedent moisture conditions according to growing season
#5) Calculate 5-day antecedent moisture condition (AM5) for each day
#6) Assess curve number using Haith's continuous curve number for runoff 
#7) Calculate S
#8) Create conditional statement that checks if precipitation is less than 0.2*S
#9) If conditional statement is true, then surface runoff that day is equal to 0
#10) If conditional statement is not true, use formula to calculate surface runoff
#11) Calculate infiltration I= P - SR
#12) Calculate ET values using the same method as in HW5
#13) Assign Kb a value of 0.9
#14) Calculate SD and SS using formulas in the same loop
#15) Calculate Q=SR + SD 
#16) Calculate annual and mothly NSE and Bias for Q calculated in previuous step
#17) Sample Kb across range of 0.8-1 in steps of 0.001
#18) Create a loop, that would calculate Q using new Kb from the samples range
#19) Assess annual and mothly NSE and Bias using each Kb value
#20) Identify Kb value that produced highest mothly NSE value
#21) Calculate annual and mothly NSE and Bias using Q calculate using Kb value
#    identified in previous step

#Variables
#Climate - climate data downloaded from NOAA website
#Genesee_data - observed dataset
#Discharge_obs - observed streamflow
#date - dates
#Data_Roch - dataset from Rochester
#Data_Buff - dataset from Buffalo
#HW6_out - values obtained from HW6
#HW5_out - output from HW5 (calculated)
#ET - evapotranspiration
#Soils - dataset with curve nr for different land covers
#Soils_B - CN for soil B
#Soils_C - CN for soil C
#Per_area - land cover areas
#A1 - antecedent moisture condition 1
#A2 - antecedent moisture condition 2
#N - number of different land covers
#CN2_B - curve number for soils B
#CN2_C - curve number for soils C
#Weigh_CN2 - curve number incorporating both soil types
#Given_CN2 - given CN2 value
#CN1 - curve number for antecedent moisture condition 1
#CN3 - curve number for antecedent moisture condition 2
#P_val - precipitation values in cm
#AM5 - 5 day antecedent moisture condition
#CN - curve number derived from Haith's continuous curve number method
#S - potential retention
#SR - surface runoff in mm/day
#I - infiltration
#Kb - baseflow recession constant 
#SS - surface storage
#SD - surafce discharge
#Q_pred - calculated Q in cm/day
#Q_cfs_new - calculated Q in cfs
#error_met_new - annual and monthly NSE and Bias values using Kb=0.9
#NSE_ann_new - annual NSE using Kb=0.9
#NSE_mon_new - monthly NSE using Kb=0.9
#Bias_ann_new - annual Bias using Kb=0.9
#Bias_mon_new - monthly bias using Kb=0.9
#Kb_ranges - Kb values samples through 0.8-1 range
#Q_cfs_new_cal - calculated Q in cfs using every Kb value in sampled range
#Kb_v - Kb value from samples range
#Q_pred_new - calculated Q values using Kb_v
#error_met_new_cal - annual and monthly NSE and Bias values using ranging Kb 
#NSE_ann_new_cal - annual NSE using ranging Kb 
#NSE_mon_new_cal - monthly NSE using ranging Kb 
#Bias_ann_new_cal - annual bias using ranging Kb 
#Bias_mon_new_cal - monthly bias using ranging Kb 
#index - index where monthly NSE value is the highest
#Kb_calibated - Kb value that produced highest NSE value
#Q_cfs_calibrated - calculated Q using Kb_calibated
#Mon_obs - monthly averages from observed data
#Mon_b - monthly averages using Kb=0.9
#Mon_c - monthly averages using calibrated Kb
#Mon_obs_v - average monthly averages from observed data
#Mon_b_v - average monthly averages using Kb=0.9
#Mon_c_v - average monthly averages using calibrated Kb
#Mon - months
#Ann_obs - annual observed values
#Yearly_aver_obs - annual average observed streamflow
#Ann_obs_b - annual stremaflow values using Kb=0.9
#Yearly_aver_obs_b - annual average stremaflow values using Kb=0.9
#Ann_obs_c - annual stremaflow values using calibrated Kb
#Yearly_aver_obs_c - annual average stremaflow values using calibrated Kb
#Wat_Y - water years
#yr_st_1998 - start of the water year index
#yr_end_1998 - end of the water year index
#Hydro1 - observed streamflow for 1998 water year
#Hydro2 - calculated streamflow using Kb=0.9  for 1998 water year
#Hydro3 - calculated streamflow using calibrated Kb  for 1998 water year
#len_1998 - number of days in 1998 water year

#Uploading data
Climate<-read.csv(file="Climate_data.csv",sep=",",header=T)
Genesee_data<-read.csv(file="Genesee_data.csv",sep=",",header=F)
Discharge_obs<-Genesee_data[,2]
date=as.POSIXlt(Genesee_data[,1], format="%m/%d/%y")
len=dim(Genesee_data)[1]
Data_Roch<-read.csv(file="Rochester.csv",sep=",",header=T)
Data_Buff<-read.csv(file="Buffalo.csv",sep=",",header=T)

#Incorporating Soil data
Soils=read.csv(file="Soil_data.csv",sep=",",header=T)
Soils_B=Soils[,5]
Soils_C=Soils[,6]
Per_area=Soils[,4]

#Determining AM1 and AM2 values
A1=c(1.3,1.3,1.3,1.3,3.6,3.6,3.6,3.6,3.6,3.6,1.3,1.3)
A2=c(2.8,2.8,2.8,2.8,5.3,5.3,5.3,5.3,5.3,5.3,2.8,2.8)

N=dim(Soils)[1]
CN2_B=0
CN2_C=0
for (i in seq(1,N)){
  CN2_B=CN2_B+Per_area[i]/100*Soils_B[i]
  CN2_C=CN2_C+Per_area[i]/100*Soils_C[i]
}
Weigh_CN2=0.5*CN2_B+0.5*CN2_C #CN2 value calculated

Given_CN2=55 

CN1=Given_CN2/(2.334-0.01334*Given_CN2)
CN3=Given_CN2/(0.4036+0.0059*Given_CN2)

#Values from HW6
source("HW6_fun.R")
HW6_out=HW6_loop(Climate,Data_Roch,Data_Buff)

P_val=HW6_out[,3]*2.54 #in cm
AM5=0 #Precipitation from 5 previous days
AM5[1:len]=0
AM5[2]=P_val[1]
AM5[3]=P_val[1]+P_val[2]
AM5[4]=P_val[1]+P_val[2]+P_val[3]
AM5[5]=P_val[1]+P_val[2]+P_val[3]+P_val[4]
for (i in seq(6,len)){
  for (j in seq(1,5)){
    AM5[i]=AM5[i]+P_val[i-j]
  }
}

CN=0
CN[1:len]=0
for (i in seq(1,len)){
  mo_nr=date$mon[i]+1
  if (AM5[i]<A1[mo_nr]){
    CN[i]=CN1+((Given_CN2-CN1)/(A1[mo_nr]-0))*AM5[i]
  }
  if (A1[mo_nr]<=AM5[i] & AM5[i]<=A2[mo_nr]){
    CN[i]=Given_CN2+((CN3-Given_CN2)/(A2[mo_nr]-A1[mo_nr]))*(AM5[i]-A1[mo_nr])
  }
  if (AM5[i]>A2[mo_nr]){
    CN[i]=CN3
  } 
}

S=(2540/CN)-25.4

#IF P is < than 0.2*S, then Runoff=0
SR=0
I=0
SR[1:len]=0
I[1:len]=0
for(i in seq(1,len)){
  if (P_val[i]<0.2*S[i]){
    SR[i]=0
  }else{
    SR[i]=((P_val[i]-0.2*S[i])^2)/(P_val[i]+0.8*S[i])
  }
  I[i]=P_val[i]-SR[i]
}

#Values from HW5
source("HW5_fun.R")
HW5_out=HW5_loop(HW6_out,date)
ET=HW5_out[,2]

Kb=0.9
SS=0
SD=0
SD[1:len]=0
SS[1:len]=0
SS[1]=4.04 #cm
for (i in seq(2,len)){
  if (SS[i-1]<ET[i-1]){
    SS[i]=I[i-1]
    SD[i-1]=0
  }
  else{
    SD[i-1]=(1-Kb)*(SS[i-1]-ET[i-1])
    SS[i]=SS[i-1]+I[i-1]-ET[i-1]-SD[i-1]
  }
}
SD[len]=0

#Calculated Q
Q_pred=0
Q_pred[1:len]=0
for(i in seq(1,len)){
  Q_pred[i]=SR[i]+SD[i] #cm/day
}
Q_cfs_new=Q_pred*(984*2.59*10^10)*4.08734569*10^(-10)
#mi2 to cm2       to cfs

#Error metrics (newly calculated Q)
source("Error_met_fun.R")
error_met_new=NSE_Bias_loop(date,Discharge_obs,Q_cfs_new)
NSE_ann_new=error_met_new[3]
NSE_mon_new=error_met_new[4]
Bias_ann_new=error_met_new[1]
Bias_mon_new=error_met_new[2]

#Kb Calibration
Kb_ranges=seq(from=0.8,to=0.999,by=0.001)
Q_cfs_new_cal=matrix(0,len,length(Kb_ranges))
Q_pred_new=0
SDn=0
SSn=0
SSn[1]=4.04
for (j in seq(1,length(Kb_ranges))){
  Kb_v=Kb_ranges[j]
  for (i in seq(2,len)){
    if (SSn[i-1]<ET[i-1]){
      SSn[i]=I[i-1]
      SDn[i-1]=0
    }
    else{
      SDn[i-1]=(1-Kb_v)*(SSn[i-1]-ET[i-1])
      SSn[i]=SSn[i-1]+I[i-1]-ET[i-1]-SDn[i-1]
    }
  } 
  if (SSn[len]<ET[len]){
    SDn[len]=0
  }
  else {
    SDn[len]=(1-Kb_v)*(SSn[len]-ET[len])
  }
  for(a in seq(1,len)){
    Q_pred_new[a]=SR[a]+SDn[a] #cm/day
  }
  Q_cfs_new_cal[,j]=Q_pred_new*(984*2.59*10^10)*4.08734569*10^(-10)
}

NSE_ann_new_cal=0
NSE_mon_new_cal=0
Bias_ann_new_cal=0
Bias_mon_new_cal=0
for(i in seq(1,length(Kb_ranges))){
  error_met_new_cal=NSE_Bias_loop(date,Discharge_obs,Q_cfs_new_cal[,i])
  NSE_ann_new_cal[i]=error_met_new_cal[3]
  NSE_mon_new_cal[i]=error_met_new_cal[4]
  Bias_ann_new_cal[i]=error_met_new_cal[1]
  Bias_mon_new_cal[i]=error_met_new_cal[2]
}

Error_cal=cbind(Kb_ranges,NSE_ann_new_cal,NSE_mon_new_cal,Bias_ann_new_cal,Bias_mon_new_cal)
colnames(Error_cal)[1]="Calibrated Kb"
colnames(Error_cal)[2]="Annual NSE"
colnames(Error_cal)[3]="Monthly NSE"
colnames(Error_cal)[4]="Annual Bias"
colnames(Error_cal)[5]="Monthly Bias"

index=which.max(NSE_mon_new_cal)
Kb_calibated=Kb_ranges[index]
Q_cfs_calibrated=Q_cfs_new_cal[,index]

#Monthly value comparison
source("Monthly_fun.R")
Mon_obs=Monthly_loop2(date,Discharge_obs)
Mon_b=Monthly_loop2(date,Q_cfs_new)
Mon_c=Monthly_loop2(date,Q_cfs_calibrated)

Mon=c("Oct","Nov","Dec","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep")
plot(1:12,Mon_obs,type="b",xaxt = "n",xlab=paste("Month"),ylab=paste("Q (cfs)"),ylim=c(min(Mon_c),max(Mon_obs)),main="Observed vs predicted montly \ndaily average streamflow (1998-2017)",lwd=1.5,lty=1)#pch=16,cex=0.75)
lines(1:12,Mon_b,type="b",lwd=1.5,col="red",lty=1)
lines(1:12,Mon_c,type="b",lwd=1.5,col="green",lty=1)
axis(1, at=1:12, labels=Mon)
legend(x="topleft",legend=c("Observed","Predicted (part b)","Predicted (part c)"),col=c("black","red","green"),lty=c(1,1,1),cex=0.6,bty = "n")
legend(x="topright",legend=paste("Part B:NSE=",round(NSE_mon_new,3)," Bias= ",round(Bias_mon_new,3),"\nPart C :NSE= ",round(Error_cal[index,3],3)," Bias= ",round(Error_cal[index,5],3)),cex=0.6,bty = "n")

#Annual averages
source("Average_fun.R")
Ann_obs=Annual_loop(date,Discharge_obs)
Yearly_aver_obs=Ann_obs[,1]
Ann_obs_b=Annual_loop(date,Q_cfs_new)
Yearly_aver_obs_b=Ann_obs_b[,1]
Ann_obs_c=Annual_loop(date,Q_cfs_calibrated)
Yearly_aver_obs_c=Ann_obs_c[,1]

Wat_Y=c("1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")
plot(Wat_Y,Yearly_aver_obs,type="b",xlab=paste("Years"),ylab=paste("Q (cfs)"),ylim=c(min(Yearly_aver_obs_c),2300),main="Observed vs predicted annual \ndaily average streamflow (1998-2017)",lwd=1.5,lty=1)#,pch=16,cex=0.75)
lines(Wat_Y,Yearly_aver_obs_b,type="b",lwd=1.5,col="red",lty=1)
lines(Wat_Y,Yearly_aver_obs_c,type="b",lwd=1.5,col="green",lty=1)
legend(x="topleft",legend=c("Observed","Predicted (part b)","Predicted (part c)"),col=c("black","red","green"),lty=c(1,1,1),cex=0.6,bty = "n")
legend(x="topright",legend=paste("Part B:NSE=",round(NSE_ann_new,3)," Bias= ",round(Bias_ann_new,3),"\nPart C :NSE= ",round(Error_cal[index,2],3)," Bias= ",round(Error_cal[index,4],3)),cex=0.6,bty = "n")

yr_st_1998=which((date$year+1900)==1997 & (date$mon+1)==10 & (date$mday)==1)
yr_end_1998=which((date$year+1900)==1998 & (date$mon+1)==9 & (date$mday)==30)

Hydro1=Discharge_obs[yr_st_1998:yr_end_1998]
Hydro2=Q_cfs_new[yr_st_1998:yr_end_1998]
Hydro3=Q_cfs_calibrated[yr_st_1998:yr_end_1998]
len_1998=length(Hydro1)
plot(1:len_1998,Hydro1,type="l",xlab=paste("Days in water year"),ylab=paste("Q (cfs)"),ylim=c(min(Hydro1),max(Hydro1)),main="Observed vs predicted streamflow \nhydrograph (1998)",pch=16,cex=0.75)
points(1:len_1998,Hydro2,type="l",col = "red",cex=0.75)
points(1:len_1998,Hydro3,type="l",col = "green",cex=0.75)
legend(x="topleft",legend=c("Observed","Part B","Part C"),col=c("black","red","green"),lty=c(1,1,1),cex=0.65,bty = "n")

Q_comp=data.frame(date,Discharge_obs,Q_cfs_new,Q_cfs_calibrated,Q_cfs_new_cal[,178])

#Print Kb value picked after calibration 
print(round(Error_cal[index,],3))
