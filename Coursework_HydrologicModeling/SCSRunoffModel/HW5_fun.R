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
  
  Precip=Climate_TP[,3] #inches
  T_max=Climate_TP[,1] #F
  T_min=Climate_TP[,2] #F
  len=length(Precip)
  
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
  
  HW5_out=data.frame(Q_cfs,E_calcul)
  
  return(HW5_out)
  
}
