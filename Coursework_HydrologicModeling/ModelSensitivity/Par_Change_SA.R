#Ruta Basijokaite

HW_8_look <- function (Pars){
  
  Given_CN2=Pars[1]
  Kb=Pars[2]
  M=Pars[3]
  
  Climate<-read.csv(file="Climate_data.csv",sep=",",header=T)
  Genesee_data<-read.csv(file="Genesee_data.csv",sep=",",header=F)
  Discharge_obs<-Genesee_data[,2]
  date=as.POSIXlt(Genesee_data[,1], format="%m/%d/%y")
  len=length(Discharge_obs)
  
  #Values from HW6
  Data_Roch<-read.csv(file="Rochester.csv",sep=",",header=T)
  Data_Buff<-read.csv(file="Buffalo.csv",sep=",",header=T)
  source("HW6_fun.R")
  HW6_out=HW6_loop(Climate,Data_Roch,Data_Buff)
  
  #Values from HW5
  source("HW5_fun.R")
  HW5_out=HW5_loop(HW6_out,date)
  Q_cfs=HW5_out[,1]
  ET=M*HW5_out[,2] # add in ET multiplier
  
  CN1=Given_CN2/(2.334-0.01334*Given_CN2)
  CN3=Given_CN2/(0.4036+0.0059*Given_CN2)
  
  #Determining AM1 and AM2 values
  A1=c(1.3,1.3,1.3,1.3,3.6,3.6,3.6,3.6,3.6,3.6,1.3,1.3)
  A2=c(2.8,2.8,2.8,2.8,5.3,5.3,5.3,5.3,5.3,5.3,2.8,2.8)
  
  P_val=HW6_out[,3]*2.54 #in cm
  AM5=0 #Precipitation on 5 previous days
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
  
  return(Q_cfs_new)
}
