MAIN CODE - *Bear_SA_analysis.m*
- Runs HYMOD model with new snow routine to simulate streamflow during 1981 - 2013 and calculates model performance metrics (i.e Kling-Gupta Efficiency Coefficient) 
and hydrologic signatures (i.e. Runoff ratio, baseflow index, standard flow duration curve, streamflow centroid). In addition, global Sobol' method was applied 
pointiwise in time to decompose the variance of model performance into first and total order contributions per model parameter to analyze how model parameter 
sensitivity changes through time.

Functions and data used in the main code:

*AAT_sampling.m* - Generates a sample composed of N random of M uncorrelated variables

*Data_Bear_lake.mat* - Climate data (daily precipitation and average temperature) 

*Data_Qflow_Bear_lake.mat* - Streamflow data

*Hymod10par_new_RB.m* - HYMOD model

*juliandate.m* - Function that converts typical date format m/d/y to day of the year (1-365)

*kge.m* - Function that calculates Kling-Gupta Efficiency (KGE) Coefficient

*oudinET.m* - Function that estimates potential evapotranspiration using Oudin method

*vbsa_resampling.m* - Function that implements the resampling strategy needed to build the approximators of the first-order (main effect) and total-order sensitivity indices
