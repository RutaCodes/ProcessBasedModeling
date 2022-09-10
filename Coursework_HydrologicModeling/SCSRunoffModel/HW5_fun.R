#Ruta Basijokaite

#Variables used:
#Climate_data - date, temp and precip values extracted from original dataset
#L1, L2 - min and max date values 
#Clim_compl - data frame that includes all days in period of interest
#Clim_all - dataset with identified, but not corrected missing date values
#len - length of dataset
#Precip - precipitation values in inches
#T_max - T max values in F
#T_min - T min values in F
#Discharge_obs - observed discharge
#date - dates
#T_max_cor - corrected T max values
#T_min_cor - corrected T min values
#mini - value holder
#Precip_cm - precipitation values in cm
#Temp - average temp in F
#Temp_C - average temp in C
#E_calcul - estimated evapotranspiration values using Hamon method
#Area - watershed area
#Q_cal - predicted streaflow in cm3/day
#Q_cfs - predicted streaflow in cfs

HW5_loop <- function (Climate_TP,date){
  
  #Climate_data=Climate[,c("DATE","PRCP","TMAX","TMIN")]
  #Climate_data$DATE=as.Date(Climate_data$DATE,format="%Y-%m-%d")
  #Creating new data frame with all days
  #L1=min(Climate_data$DATE)
  #LL=max(Climate_data$DATE)
  #Clim_compl=data.frame(DATE=seq(L1,LL,by="day"))
  #Merging incoplete and complete dataframes to correct missing days
  #Clim_all=merge(Clim_compl,Climate_data,by="DATE",all.x=TRUE)
  #len=dim(Clim_all)[1]
  
  #Precip=Clim_all$PRCP #inches
  #T_max=Clim_all$TMAX #F
  #T_min=Clim_all$TMIN #F
  
  Precip=Climate_TP[,3] #inches
  T_max=Climate_TP[,1] #F
  T_min=Climate_TP[,2] #F
  len=length(Precip)
  #Temp_uncor=(Clim_all$TMAX+Clim_all$TMIN)/2 #F
  
  #Observed values
  #Discharge_obs<-Genesee_data[,2]
  #date=as.POSIXlt(Genesee_data[,1], format="%m/%d/%y")
  
  #Correcting NA values
  source("NA_cor_fun.R")
  T_max_cor=NA_correct(T_max)
  T_min_cor=NA_correct(T_min)
  
  for (i in seq(1,len)){
    if (is.na(Precip[i])){
      Precip[i]=0
    }
  }
  
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
  Precip_cm=Precip*2.54 #in cm
  Temp=(T_max_cor+T_min_cor)/2 #F
  Temp_C=(Temp-32)*(5/9)
  
  source("E_cal_fun.R")
  E_calcul=E_cal(date,Temp_C)
  
  #Calculating/Predicting Streamflow assuming Q=P-E
  Area=984*2.59*10^10 #mi2 to cm2
  Q_cal=(Precip_cm-E_calcul)*Area #cm3/day
  Q_cfs=Q_cal*4.08734569*10^(-10) #cfs
  
  #Final=data.frame(date,Discharge_obs,Precip_cm,Clim_all$PRCP,Temp_C,E_calcul,Q_cfs)
  #Final=data.frame(date,Clim_all$PRCP,Precip_cm,Clim_all$TMAX,Clim_all$TMIN,Temp_C,E_calcul,Q_cfs,HW5_out_pr[,2])
  #write.csv(Final,"Output_comp.csv")
  HW5_out=data.frame(Q_cfs,E_calcul)
  
  return(HW5_out)
  
}
