#Ruta Basijokaite
#----------------
#This code predicts streamflow values using SCS Runoff Model (incorporating 
#surface runoff, snow pack, and snowmelt estimates). Also two PET models are 
#used - Hammon and Oudin and their effect on streamflow predictions is analyzed
#----------------

#Variables used:
#ptm - timer start
#Climate - climate data downloaded from NOAA website
#Genesee_data - observed dataset
#Discharge_obs - observed streamflow
#date - dates
#len - length of the dataset
#jul_day - julian day
#lat - latitude of the site
#Data_Roch - dataset from Rochester
#Data_Buff - dataset from Buffalo
#HW6_out - values obtained from HW6
#Temp - average daily temperature values in F
#Temp_C - average daily temperature values in C
#ET_val_site_m - ET values using Oudin methos in m/day
#ET_val_site_cm ET values using Oudin methos in cm/day
#Prec - precipitation values in cm/day
#Kb - baseflow recession constant 
#FCAP - initial unsaturated storage at field capacity 
#UNSAT - unsaturated zone storage
#Given_CN2 - given CN2 value
#AM5 - 5 day antecedent moisture condition
#SAT - saturated zone storage
#K - constant for temp adjusting
#SN - snow
#R - rain in cm
#M - melt in cm
#P_val - rain + melt
#A1 - antecedent moisture condition 1
#A2 - antecedent moisture condition 2
#CN1 - curve number for antecedent moisture condition 1
#CN3 - curve number for antecedent moisture condition 2
#CN - curve number derived from Haith's continuous curve number method 
#S - potential retention
#I - infiltration
#SR - surface runoff in mm/day
#KU - crop cover coefficient 
#HW5_out - HW5 output
#ET - ET values using HAmmon method in cm/day
#ET_crop - ET edited to incorporate KU
#ET_cor - ET corrected based on KU
#PERC - percolation
#SD - surafce discharge
#Q_sim - calculated Q in cm/day
#Q_sim_cfs - calculated Q in cfs
#Ann_obs - annual observed values
#Yearly_aver_obs - annual average observed streamflow
#Ann_obs_sim - annual simulated stremaflow values
#Yearly_aver_sim - annual simulated average stremaflow values
#Mon_obs - monthly averages from observed data
#Mon_sim - monthly simulated averages
#error_met_new_cal - annual and monthly NSE and Bias values using ranging Kb 
#NSE_ann_new_cal - annual NSE using ranging Kb 
#NSE_mon_new_cal - monthly NSE using ranging Kb 
#Bias_ann_new_cal - annual bias using ranging Kb 
#Bias_mon_new_cal - monthly bias using ranging Kb 
#out_st - index of start date
#out_end - index of end date

#Data Input
Genesee_data<-read.csv(file="Genesee_data.csv",sep=",",header=F)
Climate<-read.csv(file="Climate_data.csv",sep=",",header=T)
Discharge_obs<-Genesee_data[,2] #cfs
date=as.POSIXlt(Genesee_data[,1], format="%m/%d/%y")
len=dim(Genesee_data)[1]
jul_day=date$yday+1
lat= 42.57028 #latitude of the site

#Values from HW6
Data_Roch<-read.csv(file="Rochester.csv",sep=",",header=T)
Data_Buff<-read.csv(file="Buffalo.csv",sep=",",header=T)
source("HW6_fun.R")
HW6_out=HW6_loop(Climate,Data_Roch,Data_Buff)

Temp=(HW6_out[,1]+HW6_out[,2])/2 #in F
Temp_C=(Temp - 32) * 5/9 # in C

#ET model
source("OudinET.R")
ET_val_site_m=Oudin_ET(jul_day,Temp_C,lat) #in m/day
ET_val_site_cm=100*ET_val_site_m #cm/day
Prec=HW6_out[,3]*2.54 #in cm

#Initial conditions:
Kb=0.930 
FCAP=10
UNSAT=0
UNSAT[1]=10 #cm
Given_CN2=65
AM5=0
SAT=0
SAT[1:len]=0
SAT[1]=5.595 #cm 
K=0.45
SN=0
SN[1]=0
R=0 #rain in cm
M=0 #melt in cm
for(i in seq(1,len-1)){
  if (Temp_C[i]<=0){
    SN[i+1]=SN[i]+Prec[i] #snowpack increases
    R[i]=0
    M[i]=0
  }
  if (Temp_C[i]>0){
    R[i]=Prec[i]
    if (SN[i]<K*Temp_C[i]){
      M[i]=SN[i]
    }else{
      M[i]=K*Temp_C[i]
    }
    SN[i+1]=SN[i]-M[i]  
  }
}
R[len]=Prec[len]
M[len]=SN[len]

Check=data.frame(date,Prec,Temp_C,R,M,SN)

P_val=0
for(i in seq(1,len)){
  P_val[i]=R[i]+M[i]
}

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

#AM1 and AM2 values
A1=c(1.3,1.3,1.3,1.3,3.6,3.6,3.6,3.6,3.6,3.6,1.3,1.3)
A2=c(2.8,2.8,2.8,2.8,5.3,5.3,5.3,5.3,5.3,5.3,2.8,2.8)
CN1=Given_CN2/(2.334-0.01334*Given_CN2)
CN3=Given_CN2/(0.4036+0.0059*Given_CN2)

#Haith's smoothed curve number approach to estimate the surface runoff
CN=0
CN[1:len]=0
for (i in seq(1,len)){
  mo_nr=date$mon[i]+1
  if(M[i]>0){
    CN[i]=CN3
  }else{
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
}

S=(2540/CN)-25.4

I=0
SR=0
SR[1:len]=0
for(i in seq(1,len)){
  if (P_val[i]<0.2*S[i]){
    SR[i]=0
  }else{
    SR[i]=((P_val[i]-0.2*S[i])^2)/(P_val[i]+0.8*S[i])
  }
  I[i]=P_val[i]-SR[i]
}

KU=c(0.78,0.82,0.82,0.79,0.89,0.91,0.93,0.98,1.03,0.97,0.72,0.61)
source("HW5_fun.R")
HW5_out=HW5_loop(HW6_out,date)
ET=HW5_out[,2]

#Unsaturated zone water storage
ET_crop=0
ET_cor=0
PERC=0
SD=0
for (i in seq(1,len-1)){
  mo_nr=date$mon[i]+1
  ET_crop[i]=ET[i]*KU[mo_nr]
  if(ET_crop[i]>UNSAT[i]){
    ET_cor[i]=UNSAT[i]
  }else{
    ET_cor[i]=ET_crop[i]
  }
  UNSAT[i+1]=UNSAT[i]+I[i]-ET_cor[i]
  if(UNSAT[i+1]>FCAP){
    PERC[i]=UNSAT[i+1]-FCAP
    UNSAT[i+1]=FCAP
  }else{
    PERC[i]=0
  }
  SD[i]=(1-Kb)*SAT[i]
  SAT[i+1]=SAT[i]+PERC[i]-SD[i]
}
SD[len]=(1-Kb)*SAT[len]

#Calculating streamflow values
Q_sim=0
for(i in seq(1,len)){
  Q_sim[i]=SR[i]+SD[i] #cm/day
}
Q_sim_cfs=Q_sim*(984*2.59*10^10)*4.08734569*10^(-10)
                  #mi2 to cm2       to cfs

Q_var=data.frame(date,SR,SAT,SD,Q_sim,Q_sim_cfs)

#Annual averages
source("Average_fun.R")
Ann_obs=Annual_loop(date,Discharge_obs)
Yearly_aver_obs=Ann_obs[,1]
Ann_obs_sim=Annual_loop(date,Q_sim_cfs)
Yearly_aver_sim=Ann_obs_sim[,1]

#Monthly value comparison
source("Monthly_fun2.R")
Mon_obs=Monthly_loop2(date,Discharge_obs)
Mon_sim=Monthly_loop2(date,Q_sim_cfs)

source("Error_met_fun.R")
error_met_new=NSE_Bias_loop(date,Discharge_obs,Q_sim_cfs)
NSE_ann_new=error_met_new[3]
NSE_mon_new=error_met_new[4]
Bias_ann_new=error_met_new[1]
Bias_mon_new=error_met_new[2]

out_st=which((date$year+1900)==1997 & (date$mon+1)==10 & (date$mday)==1)
out_end=which((date$year+1900)==1997 & (date$mon+1)==12 & (date$mday)==31)

Out_Q=Q_sim_cfs[out_st:out_end]
date_3m=date[out_st:out_end]
out_val=data.frame(date_3m,Out_Q)
colnames(out_val)[1]="Date"
colnames(out_val)[2]="Predicted Q (cfs)"

#Alternative ET model testing
#Unsaturated zone water storage
PERC2=0
SD2=0
UNSAT2=0
UNSAT2[1]=10 #cm
SAT2=0
SAT2[1]=5.595 #cm
for (i in seq(1,len-1)){
  UNSAT2[i+1]=UNSAT2[i]+I[i]-ET_val_site_cm[i] 
  if(UNSAT2[i+1]>FCAP){
    PERC2[i]=UNSAT2[i+1]-FCAP
    UNSAT2[i+1]=FCAP
  }else{
    PERC2[i]=0
  }
  SD2[i]=(1-Kb)*SAT2[i]
  SAT2[i+1]=SAT2[i]+PERC2[i]-SD2[i]
}
SD2[len]=(1-Kb)*SAT2[len]

#Calculating streamflow values
Q_sim2=0
for(i in seq(1,len)){
  Q_sim2[i]=SR[i]+SD2[i] #cm/day
}
Q_sim_cfs2=Q_sim2*(984*2.59*10^10)*4.08734569*10^(-10)

Same=data.frame(date,Q_sim_cfs,Q_sim_cfs2)

Ann_obs_sim2=Annual_loop(date,Q_sim_cfs2)
Yearly_aver_sim2=Ann_obs_sim2[,1]
Mon_sim2=Monthly_loop2(date,Q_sim_cfs2)

#Calculating error metrics
error_met_new2=NSE_Bias_loop(date,Discharge_obs,Q_sim_cfs2)
NSE_ann_new2=error_met_new2[3]
NSE_mon_new2=error_met_new2[4]
Bias_ann_new2=error_met_new2[1]
Bias_mon_new2=error_met_new2[2]

Wat_Y=c("1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")
plot(Wat_Y,Yearly_aver_obs,type="b",xlab=paste("Years"),ylab=paste("Q (cfs)"),ylim=c(min(Yearly_aver_sim2),2400),main="Observed vs predicted annual \ndaily average streamflow (1998-2017)\n(with alternative ET)",lwd=1.5,lty=1)#,pch=16,cex=0.75)
lines(Wat_Y,Yearly_aver_sim,type="b",lwd=1.5,col="blue",lty=1)
lines(Wat_Y,Yearly_aver_sim2,type="b",lwd=1.5,col="red",lty=1)
legend(x="topleft",legend=c("Observed","Hammon ET","Oudin ET"),col=c("black","blue","red"),lty=c(1,1,1),cex=0.6,bty = "n")
legend(x="topright",legend=paste("Hammon:NSE=",round(NSE_ann_new,3)," Bias= ",round(Bias_ann_new,3),"\nOudin :NSE=",round(NSE_ann_new2,3)," Bias= ",round(Bias_ann_new2,3)),cex=0.6,bty = "n")

Mon=c("Oct","Nov","Dec","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep")
plot(1:12,Mon_obs,type="b",xaxt = "n",xlab=paste("Month"),ylab=paste("Q (cfs)"),ylim=c(min(Mon_sim2),max(Mon_obs)),main="Observed vs predicted montly \ndaily average streamflow (1998-2017)\n(with alternative ET)",lwd=1.5,lty=1)#pch=16,cex=0.75)
lines(1:12,Mon_sim,type="b",lwd=1.5,col="blue",lty=1)
lines(1:12,Mon_sim2,type="b",lwd=1.5,col="red",lty=1)
axis(1, at=1:12, labels=Mon)
legend(x="topleft",legend=c("Observed","Hammon ET","Oudin ET"),col=c("black","blue","red"),lty=c(1,1,1),cex=0.6,bty = "n")
legend(x="topright",legend=paste("Hammon:NSE=",round(NSE_mon_new,3)," Bias= ",round(Bias_mon_new,3),"\nOudin :NSE=",round(NSE_mon_new2,3)," Bias= ",round(Bias_mon_new2,3)),cex=0.6,bty = "n")
