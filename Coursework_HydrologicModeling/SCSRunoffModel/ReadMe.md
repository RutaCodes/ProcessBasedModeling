MAIN CODE - SCSModel.R

SCS Runoff Model employs Haith's continuous curve number model for runoff and Hamon’s temperature-based evapotranspiration model to estimate streamflow discharge for 20 years of data (water years 1998 – 2017). The following diagram presents a schematic of this model:

![Screen Shot 2022-09-09 at 1 58 31 PM](https://user-images.githubusercontent.com/111301407/189414903-02df4d40-1994-4072-93f0-449fdc2ece3a.png)

Precipitation is partitioned into either surface runoff or infiltration. Infiltration enters the subsurface and is added to subsurface storage. Evapotranspiration comes from subsurface storage. A portion of subsurface storage is discharged to the stream. Streamflow is composed of surface runoff and subsurface discharge. Note snow and the division of the subsurface storage into saturated and unsaturated zones are ignored in this model.
