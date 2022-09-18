#Ruta Basijokaite

#----------------
#This code performs a global sensitivity analysis using the Morris One-factor-At-a-Time (OAT) method on SCS Model to 
#analyze its parameter sensitivity. Parameters analyzed: CN, Kb, M(multiplier of ET).
#Elementary effect (EE) for each parameter is analyzed, where the model output (y) is the NSE of the monthly average 
#streamflows. p=5 (number of discretization of each parameter) and k=15 (number of repetitions) are used for OAT 
#technique. 
#----------------

Genesee_data<-read.csv(file="Genesee_data.csv",sep=",",header=F)
Discharge_obs<-Genesee_data[,2] #cfs

#Calculating delta values for model parameters
delta_CN=(90-25)/(5-1)
delta_Kb=(0.99-0.8)/(5-1)
delta_M=(1-0.2)/(5-1)

CN_seq=seq(25,90, by=delta_CN)
Kb_seq=seq(0.8,0.99, by=delta_Kb)
M_seq=seq(0.2,1, by=delta_M)

r_v=sample(1:4, 3, replace=T)
Main_seq=c(CN_seq[r_v[1]],Kb_seq[r_v[2]],M_seq[r_v[3]])

Seq_var=matrix(0,15,3)
R_par=0
R_seq=0
for (i in seq(1,15)){
  r_v_sample=sample(1:3, 1, replace=T)
  if (r_v_sample==1){
    A1=c(1:4)
    A1_rem=A1[A1!=r_v[1]]
    r_v_index=sample(A1_rem, 1, replace=T)
    Seq_var[i,]=c(CN_seq[r_v_index],Kb_seq[r_v[2]],M_seq[r_v[3]])
  }
  if (r_v_sample==2){
    A1=c(1:4)
    A1_rem=A1[A1!=r_v[2]]
    r_v_index=sample(A1_rem, 1, replace=T)
    Seq_var[i,]=c(CN_seq[r_v[1]],Kb_seq[r_v_index],M_seq[r_v[3]])
  }
  if (r_v_sample==3){
    A1=c(1:4)
    A1_rem=A1[A1!=r_v[3]]
    r_v_index=sample(A1_rem, 1, replace=T)
    Seq_var[i,]=c(CN_seq[r_v[1]],Kb_seq[r_v[2]],M_seq[r_v_index])
  }
  R_par[i]=r_v_sample
  R_seq[i]=r_v_index
}

source("Par_Change_SA.R") #function that use new parameter values as an input and returns Q simulated
Q_par_val=matrix(0,7305,15)
Q_par_stan=0
Q_par_stan=HW_8_look(Main_seq)
for (i in seq(1,15)){
  Q_par_val[,i]=HW_8_look(Seq_var[i,])
}
source("Error_met_fun.R") #function that calculated montly and annual Bias and NSE
error_met_new=0
NSE_mon_new=0
NSE_main=0
error_main=NSE_Bias_loop(date,Discharge_obs,Q_par_stan)
NSE_main=error_main[4]
for (i in seq(1,15)){
  error_met_new=NSE_Bias_loop(date,Discharge_obs,Q_par_val[,i])
  NSE_mon_new[i]=error_met_new[4]
}

#elemantary effect for each parameter combination
cn1=0
cn2=0
cn3=0
Par_val=0
delta=0
xi=0
SI_num=0
SI_den=0
SI_CN=0
SI_Kb=0
SI_M=0
for (i in seq(1:15)){
  if(R_par[i]==1){
    Par_val[i]=CN_seq[R_seq[i]]
    delta[i]=abs(Par_val-Main_seq[1])
    xi[i]=Main_seq[1]
    cn1=cn1+1
    SI_num=(abs(NSE_mon_new[i])-abs(NSE_main))/abs(NSE_main)
    SI_den=delta/xi
    SI_CN[cn1]=SI_num/SI_den
  }
  if(R_par[i]==2){
    Par_val[i]=Kb_seq[R_seq[i]]
    delta[i]=abs(Par_val-Main_seq[2])
    xi[i]=Main_seq[2]
    cn2=cn2+1
    SI_num=(abs(NSE_mon_new[i])-abs(NSE_main))/abs(NSE_main)
    SI_den=delta/xi
    SI_Kb[cn2]=SI_num/SI_den
  }
  if(R_par[i]==3){
    Par_val[i]=M_seq[R_seq[i]]
    delta[i]=abs(Par_val-Main_seq[3])
    xi[i]=Main_seq[3]
    cn3=cn3+1
    SI_num=(abs(NSE_mon_new[i])-abs(NSE_main))/abs(NSE_main)
    SI_den=delta/xi
    SI_M[cn3]=SI_num/SI_den
  }
}
mean_CN=mean(SI_CN)
std_CD=sd(SI_CN)
mean_Kb=mean(SI_Kb)
std_Kb=sd(SI_Kb)
mean_M=mean(SI_M)
std_M=sd(SI_M)

means=c(mean_CN,mean_Kb,mean_M)
stds=c(std_CD,std_Kb,std_M)

#Plot with mean EE values on the y-axis and the standard deviation of EE on the x-axis for all three variables
plot(stds[1],means[1],xlab=paste("St. Dev. EE"),ylab=paste("Mean EE"),xlim=c(min(stds),max(stds)),ylim=c(min(means),max(means)),main="Elementary Effect",pch=16,cex=0.75)
points(stds[2],means[2],col="blue",pch=16,cex=0.75)
points(stds[3],means[3],col="red",pch=16,cex=0.75)
legend(x="bottomright",legend=c("CN","Kb","M"),col=c("black","blue","red"),pch=c(16,16,16),cex=0.6,bty = "n")
