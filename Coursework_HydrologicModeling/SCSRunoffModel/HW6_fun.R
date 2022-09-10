#Ruta Basijokaite

#Variables used:
#Climate_data - date, temp and precip values extracted from original dataset
#L1, L2 - min and max date values 
#Clim_compl - data frame that includes all days in period of interest
#Clim_all - dataset with identified, but not corrected missing date values
#Precip - precipitation values in inches
#T_max - T max values in F
#T_min - T min values in F
#ind - index values where Tmin>Tmax
#Data_Roch - climate data from Rochester site
#Data_Buff - climate data from Buffalo site
#T_min_Buff - temperature min from Buffalo site
#T_min_Roch - temperature min from Rochester site
#T_max_Buff - temperature max from Buffalo site
#T_max_Roch - temperature max from Rochester site
#P_Buff - precipitation data from Buffalo site
#P_Roch - precipitation data from Rochester site
#Dist_Roch - distance from Rochester to Dansville
#Dist_Buff - distance from Buffalo to Dansville
#Mon_Dan - daily month averages for each month for Dansville site
#Mon_Roch - daily month averages for each month for Rochester site
#Mon_Buff - daily month averages for each month for Buffalo site
#Months - months in order for water year

HW6_loop<-function(Climate,Data_Roch,Data_Buff){

Climate_data=Climate[,c("DATE","PRCP","TMAX","TMIN")]
Climate_data$DATE=as.Date(Climate_data$DATE,format="%Y-%m-%d")
#Creating new data frame with all days
L1=min(Climate_data$DATE)
LL=max(Climate_data$DATE)
Clim_compl=data.frame(DATE=seq(L1,LL,by="day"))
#Merging incoplete and complete dataframes to correct missing days
Clim_all=merge(Clim_compl,Climate_data,by="DATE",all.x=TRUE)
len2=dim(Clim_all)[1]

Precip=Clim_all$PRCP #inches
T_max=Clim_all$TMAX #F
T_min=Clim_all$TMIN #F

ind=which(T_max<T_min)
T_min[ind]=NA
T_max[ind]=NA

#data from rochester and buffalo
T_min_Buff=Data_Buff$TMIN #F
T_min_Roch=Data_Roch$TMIN #F
T_max_Buff=Data_Buff$TMAX #F
T_max_Roch=Data_Roch$TMAX #F
P_Buff=Data_Buff$PRCP #inches
P_Roch=Data_Roch$PRCP #inches
Dist_Roch=61384 #m
Dist_Buff=93231 #m

for (i in seq(1,len2-1)){
  if (is.na(T_min[i])){
    T_min[i]=((1/Dist_Buff^2)*T_min_Buff[i]+(1/Dist_Roch^2)*T_min_Roch[i])/((1/Dist_Buff^2)+(1/Dist_Roch^2))
  }
}
for (i in seq(1,len2-1)){
  if (is.na(T_max[i])){
    T_max[i]=((1/Dist_Buff^2)*T_max_Buff[i]+(1/Dist_Roch^2)*T_max_Roch[i])/((1/Dist_Buff^2)+(1/Dist_Roch^2))
  }
}

#Getting Average daily precipitation values for each month
source("Monthly_fun.R")
Mon_Dan=Monthly_loop2(date,Precip)
Mon_Roch=Monthly_loop2(date,P_Roch)
Mon_Buff=Monthly_loop2(date,P_Buff)

Months=c(10,11,12,1,2,3,4,5,6,7,8,9)

for (i in seq(1,len2-1)){
  if (is.na(Precip[i])){
    mo=date[i]$mon+1
    s_mo=which(Months==mo)
    Precip[i]=(Mon_Dan[s_mo]/Mon_Buff[s_mo]*P_Buff[i]+Mon_Dan[s_mo]/Mon_Roch[s_mo]*P_Roch[i])/2
  }
}

Max_Min_P=data.frame(T_max,T_min,Precip)

return(Max_Min_P)

}
