MAIN CODE - SimpleQPredictions.R

SimpleQPredictions.R code predicts streamflow using simple Q=P-E model, which assumes that streamflow can be estimated by subtracting estimated evapotranspiration (output) from precipitation (input) while ignoring any other potential outputs in the system. It also estimates model accuracy by calculating bias and Nash Sutcliffe Efficiency (code can be found in Bias_NSE.R).

Q - Daily Streamflow; 
P - Daily Precipitation; 
E - Estimated Evapotranspiration; 

Evaporatraspiration was calculated using Hamon method. Evapotraspiration calculations can be found in E_cal_fun.R.

Data used: Climate_data.csv, Genesee_data.csv.
