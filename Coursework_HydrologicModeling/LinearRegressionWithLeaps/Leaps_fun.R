#Ruta Basijokaite

#Variables used:
#A1, A2, A3, A4, A5, A6, A7 - leaps variable
#col, col4, col5, col6, col7 - column number
#cnt1, cnt2, cnt3, cnt4, cnt5 - counter
#T_col1, T_col2, T_col3, T_col4, T_col5, T_col6, T_col7 - columns with TRUE values
#T_col5N, T_col6N, T_col7N - columns with TRUE values 
#CH1, CH2, CH3, CH4, CH5, CH6, CH7 - is any of the column values are TRUE
#A1_true, A2_true, A3_true, A4_true, A5_true, A6_true, A7_true - explanatory variables that are significant
#Data_var - all explanatory variables
#T_col12, T_col34, T_col56 - combined explanatory variables from different leaps

Leap_loop<-function(Data_n,Q_var){
  library(leaps)
  #Initial sceening for best expanatory variables for Qaver
  A1=leaps(x=Data_n[,5:34],y=Q_var,names=colnames(Data_n)[5:34],method="adjr2",nbest=1)
  A2=leaps(x=Data_n[,35:64],y=Q_var,names=colnames(Data_n)[35:64],method="adjr2",nbest=1)
  A3=leaps(x=Data_n[,65:94],y=Q_var,names=colnames(Data_n)[65:94],method="adjr2",nbest=1)
  A4=leaps(x=Data_n[,95:104],y=Q_var,names=colnames(Data_n)[95:104],method="adjr2",nbest=1)
  
  #Determining columns with at least one significant variable (leaps=TRUE) 
  col=dim(A1$which)[2]
  cnt1=0
  cnt2=0
  cnt3=0
  T_col1=0
  T_col2=0
  T_col3=0
  for (i in seq(1,col)){
    CH1=any(A1$which[1:10,i],na.rm=TRUE) #look at first 10 rows since we want max of 10 variables
    CH2=any(A2$which[1:10,i],na.rm=TRUE)
    CH3=any(A3$which[1:10,i],na.rm=TRUE)
    if (CH1==TRUE){
      cnt1=cnt1+1
      T_col1[cnt1]=i
    }
    if (CH2==TRUE){
      cnt2=cnt2+1
      T_col2[cnt2]=i
    }
    if (CH3==TRUE){
      cnt3=cnt3+1
      T_col3[cnt3]=i
    }
  }
  #loop for A4 separate since matrix dimensions are different
  cnt4=0
  T_col4=0
  col4=dim(A4$which)[2]
  for (i in seq(1,col4)){
    CH4=any(A4$which[1:10,i],na.rm=TRUE)
    if (CH4==TRUE){
      cnt4=cnt4+1
      T_col4[cnt4]=i
    }
  }
  A1_true=A1$which[1:10,T_col1]
  A2_true=A2$which[1:10,T_col2]
  A3_true=A3$which[1:10,T_col3]
  A4_true=A4$which[1:10,T_col4]
  
  #Variables are selected from 5th coloumn onwards
  Data_var=Data_n[,5:dim(Data_n)[2]]
  
  #run leaps again combining variables that were true from leap tests 1-4
  T_col12=c(T_col1, (T_col2+30)) #column tracking -> leaps are run for 30 columns at a time
  A5=leaps(x=Data_var[,T_col12],y=Q_var,names=colnames(Data_var)[T_col12],method="adjr2",nbest=1)
  T_col34=c(T_col3+60,T_col4+90)
  A6=leaps(x=Data_var[,T_col34],y=Q_var,names=colnames(Data_var)[T_col34],method="adjr2",nbest=1)
  
  #Obtaining columns that leaps identified as true at least one time
  #Variables are selected from narrowed down list since some of the variables
  #were rejected during first leaps run
  cnt5=0
  cnt6=0
  T_col5=0
  T_col6=0
  T_col5N=0
  T_col6N=0
  col5=dim(A5$which)[2]
  col6=dim(A6$which)[2]
  for (i in seq(1,col5)){
    CH5=any(A5$which[1:10,i],na.rm=TRUE)
    if (CH5==TRUE){
      cnt5=cnt5+1
      T_col5[cnt5]=T_col12[i]
      T_col5N[cnt5]=i
    }
  }
  for (i in seq(1,col6)){
    CH6=any(A6$which[1:10,i],na.rm=TRUE)
    if (CH6==TRUE){
      cnt6=cnt6+1
      T_col6[cnt6]=T_col34[i]
      T_col6N[cnt6]=i
    }
  }
  A5_true=A5$which[1:10,T_col5N]
  A6_true=A6$which[1:10,T_col6N]
  
  #Combining remaining variables and running leap for one more time
  T_col56=c(T_col5,T_col6)
  A7=leaps(x=Data_var[,T_col56],y=Q_var,names=colnames(Data_var)[T_col56],method="adjr2",nbest=1)
  cnt7=0
  T_col7=0
  T_col7N=0
  col7=dim(A7$which)[2]
  for (i in seq(1,col7)){
    CH7=any(A7$which[1:10,i],na.rm=TRUE)
    if (CH7==TRUE){
      cnt7=cnt7+1
      T_col7[cnt7]=T_col56[i]
      T_col7N[cnt7]=i
    }
  }
  A7_true=A7$which[1:10,T_col7N]
  #A7_true_X=A7[1:10,T_col7N]
  #function output
  return(A7_true)
}
