#Ruta Basijokaite
#ERE645 Hydrologic Modeling 

#This code reads in data and calulated average discharge for 20 year period
#as well as yearly averages

#Variables:
# Genesee_data - data file containing year, month, day, discharge in separate columns
# Year - variable of just years from the dataset
# Month - variable of just months from the dataset
# Day - variable of just days from the dataset
# Discharge - varaible of discharge measurements
# Average_20y - average daily streamflow across the entire 20 year period
# n_1 - dimension of the dataset
# n - number of rows in the dataset
# Start_year - beggining year in the dataset
# Last_year - ending year in the datset
# Yearly_aver - average daily streamflow for each of the individual 20 water years using file containing date separated into different columns
# count - counter
# x - start of the water year index
# y - end of the water year index
# Year_aver - average daily streamflow for each of the individual 20 water years rounded to 2 significant figures
# Yearly_aver_data2 - average daily streamflow for each of the individual 20 water years using file containing date in m/d/y format
# Yr_aver_data2 - Yearly_aver_data2 rounded to 2 significant figures
# Start_year_data2 - beggining year in the dataset
# Last_year_data2 - ending year in the datset

# Genesee - data file containing date in the format of m/d/y
# date - date in POSIXlt format 

#USGS measures discharge in cubic feet per second
#Uploading dataset to R
Genesee_data<-read.csv(file="Genesee_River_Discharge.csv",sep=",",header=T)

#Defining variables of interest
Year<-Genesee_data$Year
Month<-Genesee_data$Month
Day<-Genesee_data$Day
Discharge<-Genesee_data[,4]

#Fnding average daily streamflow across the entire 20 year period
#4th column in dataset - discharge values
Average_20y<-round(mean(Discharge),2)

#Finding average daily streamflow for each of the individual 20 water years
 
#finding length of the dataset
n_1<-dim(Genesee_data)
n=n_1[1]
#finding year values
Start_year<-Year[1]
Last_year<-Year[n]
#Yearly average variable defined
Yearly_aver=0.0
#Defining count variable
count=0.0
#Using for loop to estimate the streamflow average in year year
for (i in seq(Start_year,Last_year-1)){
  
  #Finding index of start of the year in the dataset
  x<-which(Year==i & Month==10 & Day==1)
  #Finding the index of the end of the year in dataset
  y<-which(Year==i+1 & Month==9 & Day==30)
  
  #Computing average
  count=count+1
  Yearly_aver[count]=mean(Discharge[x:y])
  
}
#Rounding up the final values to two significant digits
Year_aver=round(Yearly_aver,2) 

#Another version to get yearly averages without initial pre-processing of dates in excel prior to uploading dataset in R

#Uploading file
Genesee<-read.csv(file="Genesee_data2.csv",sep=",",header=F)
# Changing date format
date=as.POSIXlt(Genesee[,1], format="%m/%d/%y")

Start_year_data2<-date$year[1]+1900
Last_year_data2<-date$year[n]+1900

Yearly_aver_data2=0.0
count=0.0
#Using for loop to estimate the streamflow average in year year
for (i in seq(Start_year_data2,Last_year_data2-1)){
  
  #Finding index of start of the year in the dataset
  x<-which((date$year+1900)==i & (date$mon+1)==10 & (date$mday)==1)
  #Finding the index of the end of the year in dataset
  y<-which((date$year+1900)==i+1 & (date$mon+1)==9 & (date$mday)==30)
  
  #Computing average
  count=count+1
  Yearly_aver_data2[count]=mean(Discharge[x:y])
  
}

Yr_aver_data2=round(Yearly_aver_data2,2)
