#Bias and Nash Sutcliffe Efficiency

#Aver_v - predicted average values
#Aver_v_obs - observed average values
#sum_bias - numerator of bias formula
#N - lenght of dataset
#bias_val - bias value
#sum_den - denominator of NSE formula
#sum_num - numerator of NSE formula
#NSE_val - NSE value

Bias_v <- function(Aver_v,Aver_v_obs){
  sum_bias=0
  N=length(Aver_v)
  for (i in seq(1,N)){
    sum_bias=sum_bias+(Aver_v[i]-Aver_v_obs[i])
  }
  bias_val=round(sum_bias/N,5)
  #bias_val=sum_bias/N
  return(bias_val)
}

NSE_v <- function(Aver_v,Aver_v_obs){
  sum_den=0
  sum_num=0
  N=length(Aver_v)
  for (i in seq(1,N)){
    sum_num=sum_num+(Aver_v[i]-Aver_v_obs[i])^2
    sum_den=sum_den+(Aver_v_obs[i]-mean(Aver_v_obs))^2
  }
  NSE_val=round(1-sum_num/sum_den,5)
  #NSE_val=1-sum_num/sum_den
  return(NSE_val)
}
