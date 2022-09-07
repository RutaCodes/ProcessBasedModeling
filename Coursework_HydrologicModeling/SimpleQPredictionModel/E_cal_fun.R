#Calculating ET

#date - dates
#Temp_C - temperature values in C
#N - number of daylight hours
#len - length of dataset
#E - predicted evapotraspiration
#month - month identified
#est - saturated vapor pressure

E_cal <- function(date,Temp_C){
  N=c(9.3,10.4,11.7,13.1,14.3,15.0,14.6,13.6,12.3,10.9,9.7,9.0)
  len=length(Temp_C)
  E=matrix(0,len,1) #cm/day
  for (i in seq(1,len)){
    if (Temp_C[i]>0){
      month=date$mon[i]+1
      est=6.108*exp(17.27*Temp_C[i]/(237.3+Temp_C[i]))
      E[i]=0.021*(N[month])^2*est/(Temp_C[i]+273)
    } else{
      E[i]=0
    }
  }
  return(E)
}

