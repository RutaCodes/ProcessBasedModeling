NSE_Bias_loop<-function(date,Discharge_obs,Q_cfs){

source("Average_fun.R")
#Observed Annual averages
Ann_obs=Annual_loop(date,Discharge_obs)
Yearly_aver_obs=Ann_obs[,1]
#Predicted Annual averages
Ann_pred=Annual_loop(date,Q_cfs)
#Ann_pred=Annual_loop(date,Q_cfs_calibrated)
Yearly_aver_pred=Ann_pred[,1]

#Monthly averages
Mon_obs=Monthly_loop(date,Discharge_obs)
Mon_pred=Monthly_loop(date,Q_cfs)

#Changing matrix dimentions
Mon_aver=matrix(Mon_pred,,1)
Mon_aver_obs=matrix(Mon_obs,,1)

#Monthly average daily streamflow
Aver_daily=0.0
Aver_daily_obs=0.0
l=dim(Mon_obs)[1]
for (i in seq (1,l)){
  Aver_daily[i]=mean(Mon_pred[i,])
  Aver_daily_obs[i]=mean(Mon_obs[i,])
}

#Bias and Nash Sutcliffe Efficiency
source("Bias_NSE.R")
bias_ann_v=Bias_v(Yearly_aver_pred,Yearly_aver_obs)
#bias_mon_v=Bias_v(Aver_daily,Aver_daily_obs)
bias_mon_v=Bias_v(Mon_aver,Mon_aver_obs)
NSE_ann_v=NSE_v(Yearly_aver_pred,Yearly_aver_obs)
#NSE_mon_v=NSE_v(Aver_daily,Aver_daily_obs)
NSE_mon_v=NSE_v(Mon_aver,Mon_aver_obs)

Bias_NSE_val=c(bias_ann_v,bias_mon_v,NSE_ann_v,NSE_mon_v)

return(Bias_NSE_val)
}