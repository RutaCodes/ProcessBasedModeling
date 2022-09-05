#Logonomial distribution
LN3 <- function(mini, perc){
  #Zp
  zp<-qnorm(perc)
  if (min(mini)+max(mini)-2*median(mini)<=0) {
    
    Y_bar=sum(log(mini))/length(mini)
    Sy=sqrt(sum((log(mini)-Y_bar)^2))/(length(mini)-1)
    Q7_10=exp(Y_bar+zp*Sy)
  }
  else {
    #Lower bound
    LB_est<-(min(mini)*max(mini)-median(mini)^2)/(min(mini)+max(mini)-(2*median(mini)))
    #Y
    Y_ap=log(mini-LB_est)
    Y_bar=sum(Y_ap)/length(Y_ap)
    Sy=sum((Y_ap-Y_bar)^2)/(length(Y_ap)-1)
    #100 year flood
    Q7_10=LB_est+exp(Y_bar+zp*Sy)
  }
  return(Q7_10)  
}

#log_Pearson III
LP3<-function(maxi,per){
  zp<-qnorm(per)
  Y<-log(maxi)
  N=length(maxi)
  Y_bar<-mean(Y) # Y_bar=sum(log(x_dis))/N
  Sy<-sd(Y) # Sy=sqrt(sum((log(x_dis)-Y_bar)^2)/(N-1))
  Gy=(N*sum((Y-Y_bar)^3))/((N-1)*(N-2)*Sy^3)
  Gy_ap=(1+6/N)*Gy
  Kp=(2/Gy_ap)*((1+(zp*Gy_ap/6)-((Gy_ap^2)/36))^3)-(2/Gy_ap)
  Q_LP3=exp(Y_bar+Kp*Sy)
  return(Q_LP3)
}
