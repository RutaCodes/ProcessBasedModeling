#Ruta Basijokaite
#ERE645 Hydrologic Modeling 

#This code uses leaps to identify potential explanatory variables to create model for
#predicting average streamflow, Q100 and 7Q10. Different models created are then
#compared using various regression analysis techniques to find the best model

#Variables:
#Data_all - dataset
#n_1 - dimention of dataset
#n - length of the dataset
#c - column number in dataset
#Data - dataset excluding one site
#Data_n - log transtormed dataset
#Data_var - explanatory variable pool
#Q_aver - average streamflow
#A_var_T - potentail explanatory variables returned from leap function
#a1a, a2a, a3a, a4a, a5a, a6a, a7a, a8a - column number of explanatory  variable
#m1, m2, m3, m4 - different model versions
#res1, res2, res3 - model residuals 
#pred1, pred2, pred3 - predicted Qaver, Q100 and Q7_10
#adj_r2_m1, adj_r2_m2,adj_r2_m3 - adjected r2 of best model for each predicted variable
#r_1, r_2, r_3 - residual normality for each test

#Uploading file
Data_all<-read.csv(file="Data.csv",sep=",",header=T)
n_1<-dim(Data_all) #dimension of dataset
n=n_1[1] #length of dataset
c=n_1[2] #number columns
Data=Data_all[1:n-1,] #data excluding last site
#Watershed characteristic in log space
Data_n=log(Data[,4:c])

source("Leaps_fun.R")
Data_var=Data_n[,5:dim(Data_n)[2]]
Q_aver=Data_n[,1]
A_var_T=Leap_loop(Data_n,Q_aver)

#Variables were manually chosen from final leap run (A_var_T)
a1a=which( colnames(Data_var)=="DRAIN_SQKM") #Drainage area
a2a=which( colnames(Data_var)=="PPTAVG_BASIN") #Mean annual precipitation for watershed
a3a=which( colnames(Data_var)=="SNOW_PCT_PRECIP") #Snow percent of total precipitation estimate
a4a=which( colnames(Data_var)=="MAR_PPT7100_CM") #Mean March precipitation for watershed
a5a=which( colnames(Data_var)=="WB5100_MAR_MM") #Estimated watershed March runoff
a6a=which( colnames(Data_var)=="ECO3_BAS_DOM") #Dominant (highest % of area) Level III ecoregion within the watershed
a7a=which( colnames(Data_var)=="WB5100_APR_MM")
a8a=which( colnames(Data_var)=="WB5100_MAY_MM")

#Model 1 - simple model with 1 explanatory variable
m1=lm(Q_aver~Data_var[,a1a])
#Model 2 - simple model with 3 explanatory variables
m2=lm(Q_aver~Data_var[,a1a]+Data_var[,a2a]+Data_var[,a3a])
#Model 3 - model with 6 explanatory variables 
m3=lm(Q_aver~Data_var[,a1a]+Data_var[,a2a]+Data_var[,a3a]+Data_var[,a4a]+Data_var[,a5a]+Data_var[,a6a])
#Model 4 - model with 8 explanatory variables 
m4=lm(Q_aver~Data_var[,a1a]+Data_var[,a2a]+Data_var[,a3a]+Data_var[,a4a]+Data_var[,a5a]+Data_var[,a6a]+Data_var[,a7a]+Data_var[,a8a])
summary(m4)
summary(m3)

#AIC test
extractAIC(m3)

#Stepwise regression
stepAIC(m1,scope=list(upper=m4,lower=~1),direction="both",trace=TRUE)
#StepwiseAIC identified m3 as the best model 

#Stepwise regression using an F test
library(MASS)
addterm(m1,scope=m4,test="F",sorted="TRUE")
#Check if addition of more terms would improve m3 model
addterm(m3,scope=m4,test="F",sorted="TRUE")
#Check if dropping any terms would improve m4 model
dropterm(m4,test="F", sorted=TRUE)

#put residuals of the best model m4 
res1<-residuals(m3)
# pred -> Y hats
pred1<-predict(m3)
#Adjusted R squared for best model
adj_r2_m1 <- summary(m3)$adj.r.squared

#Plotting model results
par(mfrow=c(2,2))
plot(pred1~Q_aver,xlab=paste("Measured Q average"),ylab=paste("Predicted Q average"))
abline(a=0,b=1)
legend(x="topleft",legend=paste("Adj. R2 = ",round(adj_r2_m1,3)),cex=0.65,bty = "n")
plot(res1~pred1,xlab=paste("Predicted Q average"),ylab=paste("Residuals"))
#using lowess to disregard the leverage from the outliers 
lines(lowess(pred1,res1))
#residuals vs explanatory variables (Drainage Basin)
plot(res1~Data_var[,a1a],xlab=paste("Drainage Area"),ylab=paste("Residuals"))
lines(lowess(Data_var[,a1a],res1))
#residuals vs explanatory variables (SNOW_PCT_PRECIP)
plot(res1~Data_var[,a3a],xlab=paste("Snow Percent"),ylab=paste("Residuals"))
lines(lowess(Data_var[,a3a],res1))

#Independence of the residuals
par(mfrow=c(1,1))
acf(res1) #acf -> autocorrelation function

# Calculate the test statistics for the PPCC test of normality of residuals
#Using Blom's plotting position
r_1<-cor(res1,qnorm((rank(res1)-(3/8))/(length(res1)+(1/4))))

library(car)
vif(m3)
##########################################################
#Model for Q100
Q_100=Data_n[,2]
A_100_T=Leap_loop(Data_n,Q_100)

#Mannually picked expanatory variables from narrowed down list
a1b=which( colnames(Data_var)=="DRAIN_SQKM") #Drainage area
a2b=which( colnames(Data_var)=="ELEV_MAX_M_BASIN") 
a3b=which( colnames(Data_var)=="T_MAX_SITE")
a4b=which( colnames(Data_var)=="JUN_TMP7100_DEGC")
a5b=which( colnames(Data_var)=="JUL_TMP7100_DEGC")
a6b=which( colnames(Data_var)=="BFI_AVE") #Baseflow index
a7b=which( colnames(Data_var)=="ELEV_MEAN_M_BASIN")

#Model 1 - simple model with 1 explanatory variable
m1b=lm(Q_100~Data_var[,a1b])
#Model 2 - model with 7 explanatory variables 
m2b=lm(Q_100~Data_var[,a1b]+Data_var[,a2b]+Data_var[,a3b]+Data_var[,a4b]+Data_var[,a5b]+Data_var[,a6b]++Data_var[,a7b])
#summary(m2b) #a2 gives p=0.851369
#Model 3 without a2b (6 explanatory variables)
m3b=lm(Q_100~Data_var[,a1b]+Data_var[,a3b]+Data_var[,a4b]+Data_var[,a5b]+Data_var[,a6b]++Data_var[,a7b])
summary(m3b)

#Stepwise regression
stepAIC(m1b,scope=list(upper=m2b,lower=~1),direction="both",trace=TRUE)
#StepwiseAIC identified m3b as the best model 

#Stepwise regression using an F test
library(MASS)
addterm(m1b,scope=m2b,test="F",sorted="TRUE")
#Check if addition of more terms would improve m3 model
addterm(m3b,scope=m2b,test="F",sorted="TRUE")
#Check if dropping any terms would improve m4 model
dropterm(m3b,test="F", sorted=TRUE)

res2<-residuals(m3b)
pred2<-predict(m3b)
#Adjusted R squared for best model
adj_r2_m2<- summary(m3b)$adj.r.squared

#Plotting model results
par(mfrow=c(2,2))
plot(pred2~Q_100,xlab=paste("Measured Q100"),ylab=paste("Predicted Q100"))
abline(a=0,b=1)
legend(x="topleft",legend=paste("Adj. R2 = ",round(adj_r2_m2,3)),cex=0.65,bty = "n")
plot(res2~pred2,xlab=paste("Predicted Q100"),ylab=paste("Residuals"))
#using lowess to disregard the leverage from the outliers 
lines(lowess(pred2,res2))
#residuals vs explanatory variables (Drainage Basin)
plot(res2~Data_var[,a1b],xlab=paste("Drainage Area"),ylab=paste("Residuals"))
lines(lowess(Data_var[,a1b],res2))
#residuals vs explanatory variables (ELEV_MEAN_M_BASIN)
plot(res2~Data_var[,a7b],xlab=paste("Mean Basin Elevation"),ylab=paste("Residuals"))
lines(lowess(Data_var[,a7b],res2))

#Independence of the residuals
par(mfrow=c(1,1))
acf(res2) #acf -> autocorrelation function

# Calculate the test statistics for the PPCC test of normality of residuals
#Using Blom's plotting position
r_2<-cor(res2,qnorm((rank(res2)-(3/8))/(length(res2)+(1/4))))

library(car)
vif(m3b)
#########################################################
#Model for 7Q10
Q_7_10=Data_n[,3]
A_7_10_T=Leap_loop(Data_n,Q_7_10)

#Mannually picked expanatory variables from narrowed down list
a1c=which( colnames(Data_var)=="DRAIN_SQKM") #Drainage area
a2c=which( colnames(Data_var)=="T_MAX_BASIN") 
a3c=which( colnames(Data_var)=="BFI_AVE")
a4c=which( colnames(Data_var)=="AUG_PPT7100_CM")
a5c=which( colnames(Data_var)=="MAINSTEM_SINUOUSITY")
a6c=which( colnames(Data_var)=="LAT_CENT")
a7c=which( colnames(Data_var)=="PERMAVE")
a8c=which( colnames(Data_var)=="CLAYAVE")

#Model1 with 1 explanatory variables
m1c=lm(Q_7_10~Data_var[,a1c]+Data_var[,a3c])
#Model2 with 1 explanatory variables
m2c=lm(Q_7_10~Data_var[,a1c]+Data_var[,a3c])
#Model3 with 8 explanatory variables 
m3c=lm(Q_7_10~Data_var[,a1c]+Data_var[,a2c]+Data_var[,a3c]+Data_var[,a4c]+Data_var[,a5c]+Data_var[,a6c]+Data_var[,a7c]+Data_var[,a8c])
summary(m3c)
#Stepwise regression
stepAIC(m1c,scope=list(upper=m3c,lower=~1),direction="both",trace=TRUE)
#StepwiseAIC identified m3c as the best model 

#Stepwise regression using an F test
addterm(m1c,scope=m3c,test="F",sorted="TRUE")
m4c=lm(Q_7_10~Data_var[,a1c]+Data_var[,a2c]+Data_var[,a4c]) #Adj R2 is much lower

#Check if dropping any terms would improve m4 model
dropterm(m3c,test="F", sorted=TRUE)
#Model without a5c
m5c=lm(Q_7_10~Data_var[,a1c]+Data_var[,a2c]+Data_var[,a3c]+Data_var[,a4c]+Data_var[,a6c]+Data_var[,a7c]+Data_var[,a8c])

res3<-residuals(m3c)
pred3<-predict(m3c)
#Adjusted R squared for best model
adj_r2_m3<- summary(m3c)$adj.r.squared

#Plotting model results
par(mfrow=c(2,2))
plot(pred3~Q_7_10,xlab=paste("Measured 7Q10"),ylab=paste("Predicted 7Q10"))
abline(a=0,b=1)
legend(x="topleft",legend=paste("Adj. R2 = ",round(adj_r2_m3,3)),cex=0.65,bty = "n")
plot(res3~pred3,xlab=paste("Predicted 7Q10"),ylab=paste("Residuals"))
#using lowess to disregard the leverage from the outliers 
lines(lowess(pred3,res3))
#residuals vs explanatory variables (Drainage Basin)
plot(res3~Data_var[,a1c],xlab=paste("Drainage Area"),ylab=paste("Residuals"))
lines(lowess(Data_var[,a1c],res3))
#residuals vs explanatory variables (BFI_AVE)
plot(res3~Data_var[,a3c],xlab=paste("Baseflow Index"),ylab=paste("Residuals"))
lines(lowess(Data_var[,a3c],res3))

#Independence of the residuals
par(mfrow=c(1,1))
acf(res3) #acf -> autocorrelation function

# Calculate the test statistics for the PPCC test of normality of residuals
#Using Blom's plotting position
r_3<-cor(res3,qnorm((rank(res3)-(3/8))/(length(res3)+(1/4))))

library(car)
vif(m3c)
#######################################################
source("LN3_LP3_Fun.R")
Q_7_10_val=round(LN3(day7_min,per_LN3),2)

#predicting values with developed models 
B1=matrix(0,1,7)
B2=matrix(0,1,7)
B3=matrix(0,1,9)
for (i in seq(1:7)){
  B1[i]=m3$coefficients[i]
  B2[i]=m3b$coefficients[i]
}
for (i in seq(1:9)){
  B3[i]=m3c$coefficients[i]
}

N=dim(Data_all)[1]
N2=dim(Data_all)[2]
Data_Gen=log(Data_all[N,8:N2]) #data excluding last site

Qaver_site_ln=B1[1]+B1[2]*Data_Gen[,a1a]+B1[3]*Data_Gen[,a2a]+B1[4]*Data_Gen[,a3a]+B1[5]*Data_Gen[,a4a]+B1[6]*Data_Gen[,a5a]+B1[7]*Data_Gen[,a6a]
Q100_site_ln=B2[1]+B2[2]*Data_Gen[,a1b]+B2[3]*Data_Gen[,a3b]+B2[4]*Data_Gen[,a4b]+B2[5]*Data_Gen[,a5b]+B2[6]*Data_Gen[,a6b]+B2[7]*Data_Gen[,a7b]
Q_7_10_site_ln=B3[1]+B3[2]*Data_Gen[,a1c]+B3[3]*Data_Gen[,a2c]+B3[4]*Data_Gen[,a3c]+B3[5]*Data_Gen[,a4c]+B3[6]*Data_Gen[,a5c]+B3[7]*Data_Gen[,a6c]+B3[8]*Data_Gen[,a7c]+B3[9]*Data_Gen[,a8c]

Qaver_site=exp(Qaver_site_ln)
Q100_site=exp(Q100_site_ln)
Q_7_10_site=exp(Q_7_10_site_ln)
