MAIN CODE - SCSModel.R

# SCS Runoff Model

SCS Runoff Model employs Haith's continuous curve number model for runoff and Hamon’s temperature-based evapotranspiration model to estimate streamflow discharge for 20 years of data (water years 1998 – 2017). The following diagram presents a schematic of this model:

![Screen Shot 2022-09-09 at 1 58 31 PM](https://user-images.githubusercontent.com/111301407/189414903-02df4d40-1994-4072-93f0-449fdc2ece3a.png)

Precipitation is partitioned into either surface runoff or infiltration. Infiltration enters the subsurface and is added to subsurface storage. Evapotranspiration comes from subsurface storage. A portion of subsurface storage is discharged to the stream. Streamflow is composed of surface runoff and subsurface discharge. Note snow and the division of the subsurface storage into saturated and unsaturated zones are ignored in this model. Each of the model components are discussed below.

# Subsurface Storage, Evapotranspiration, and Subsurface Discharge

This model accounts for subsurface storage using a mass balance approach:

SS[t+1] = SS[t] + I[t] - ET[t] - SD[t]

where: 
- SS[t] = Subsurface storage at beginning of day t
- I[t] = Infiltration on day t
- ET[t] = Evapotranspiration on day t
- SD[t] = Subsurface discharge on day t

The infiltration is estimated as the quantity of precipitation P[t] that is not surface runoff SR[t]:

I[t] = P[t] - SR[t]

I[t] includes interception, depression storage, and infiltrated waters. 

Hamon's method was employed to estimate the potential evapotranspiration ET[t]:
ET[t] = 0.021 N^2 est/(T + 273)     if T > 0
ET[t] = 0                           if T <= 0

where:
- ET[t] = potential evapotranspiration (cm/day)
- N = number of hours of daylight on day t
- est = saturated water vapor pressue (mb) on day t
- T = mean air temperature (C) on day t

It is assumed that as long as enough subsurface storage is available at the beginning of day t, evapotranspiration is equal to ET[t]. If SS[t] < ET[t], then ET[t] = SS[t].

The subsurface discharge on day t, SD[t], is calculated using a linear reservoir model, where discharge is linear function of the subsurface storage at the beginning of day t, SS[t]:

SD[t] = (1 - Kb)(SS[t] - ET[t])

where Kb is the baseflow recession constant.

# Streamflow

The final estimated streamflow Q[t] on day t is estimated as a combination of surface runoff and subsurface discharge:

Q[t] = SR[t] + SD[t]
