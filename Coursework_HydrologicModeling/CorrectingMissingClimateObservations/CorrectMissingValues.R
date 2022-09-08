#Ruta Basijokaite
#ERE645 Hydrologic Modeling

#This code fills in the missing precipitaion, Tmin and Tmax data using two sites closeby
#taking into consideration the distance between them

#-------------------
#Genesee_data - observed dataset (full)
#date - dates
#Climate - climate data downloaded from NOAA website
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
#mo - month number identifier 
#s_mo - month number for water years
#Mon_n - Month names for tables
#date2007 - index for 2007 water year
#Tmin_2007 - Tmin values for 2007 water year
#Tmax_2007 - Tmax values for 2007 water year
#P_2007 - precipitaion values or 2007 water year
#Tmin_aver - Tmin daily month averages for 2007 water year
#Tmax_aver - Tmax daily month averages for 2007 water year
#P_aver - precipitation month averages for 2007 water year
#-------------------

Genesee_data<-read.csv(file="Genesee_data.csv",sep=",",header=F) #full dataset
date=as.POSIXlt(Genesee_data[,1], format="%m/%d/%y")
Climate<-read.csv(file="Climate_data.csv",sep=",",header=T)
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

#data from Rochester and Buffalo
Data_Roch<-read.csv(file="Rochester.csv",sep=",",header=T)
Data_Buff<-read.csv(file="Buffalo.csv",sep=",",header=T)
T_min_Buff=Data_Buff$TMIN #F
T_min_Roch=Data_Roch$TMIN #F
T_max_Buff=Data_Buff$TMAX #F
T_max_Roch=Data_Roch$TMAX #F
P_Buff=Data_Buff$PRCP #inches
P_Roch=Data_Roch$PRCP #inches
#Distances
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
Mon_Dan=Monthly_loop(date,Precip)
Mon_Roch=Monthly_loop(date,P_Roch)
Mon_Buff=Monthly_loop(date,P_Buff)

Months=c(10,11,12,1,2,3,4,5,6,7,8,9)

for (i in seq(1,len2-1)){
  if (is.na(Precip[i])){
    mo=date[i]$mon+1
    s_mo=which(Months==mo)
    Precip[i]=(Mon_Dan[s_mo]/Mon_Buff[s_mo]*P_Buff[i]+Mon_Dan[s_mo]/Mon_Roch[s_mo]*P_Roch[i])/2
  }
}

Mon_n=c("Oct","Nov","Dec","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep")
Table2=data.frame(Mon_n,round(Mon_Dan,3),round(Mon_Roch,3),round(Mon_Buff,3))
colnames(Table2)[1] <- "Month"
colnames(Table2)[2] <- "Aver P Dansville (in)"
colnames(Table2)[3] <- "Aver P Rochester (in)"
colnames(Table2)[4] <- "Aver P Buffalo (in)"

#Results from 2007 water year after data fill
x=which((date$year+1900)==2006 & (date$mon+1)==10 & (date$mday)==1)
y=which((date$year+1900)==2007 & (date$mon+1)==9 & (date$mday)==30)
date2007=date[x:y]
Tmin_2007=T_min[x:y]
Tmax_2007=T_max[x:y]
P_2007=Precip[x:y]
Tmin_aver=0
Tmax_aver=0
P_aver=0
for(j in seq(1:12)){
  m=which((date2007$mon+1)==Months[j])
  Tmin_aver[j]=mean(Tmin_2007[m])
  Tmax_aver[j]=mean(Tmax_2007[m])
  P_aver[j]=mean(P_2007[m])
}

Table3=data.frame(Mon_n,round(P_aver,3),round(Tmax_aver,3),round(Tmin_aver,3))
colnames(Table3)[1] <- "Month"
colnames(Table3)[2] <- "Aver P (in)"
colnames(Table3)[3] <- "Aver T max (F)"
colnames(Table3)[4] <- "Aver T min (F)"

