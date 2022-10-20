*Hymod10par_new_RB.m* - HYMOD model code with new snow routine \
*Hymod10par_old.m* - HYMOD model code with old snow routine  \
*Hymod_new_framework.pdf* - conceptual HYMOD model framework with new snow routine  \
*Hymod_old_framework.pdf* - conceptual HYMOD model framework with old snow routine  \
*Snow accumulation process.pdf* - conceptualization of the snow accumulation process used in new snow model

California has experienced strong fluctuations between extreme wet and dry years, oscillating between receiving abundant precipitation, often falling as snow in mountain regions, and experiencing extreme droughts, including a recent major drought that lasted from 2012 to 2016 (USGS).

Precipitation rates vary greatly from year to year (one of study watersheds located in Sierra Nevada Mountains):
![Merced_Pohono_precip](https://user-images.githubusercontent.com/111301407/196473285-8edc5bf8-78eb-49ad-9def-2f86ead5b645.PNG)

Since our study sites span variety of elevations and available precipitation levels, it was important to use a model that not only accurately captures evapotranspiration, but can also simulate snow accumulation and melt processes. As several sites used in this study are located at high elevations, we combined the HYMOD framework with a parsimonious snow accumulation and melt model that incorporates the refreezing capability of snowpack (Kokkonen et al., 2006) a.k.a. 'new snow routine'. 'Old snow routine' did not account for streamflow that refreezes. 

Comparison between two model versions with varying snow routines:
![image](https://user-images.githubusercontent.com/111301407/196486456-0eb8b134-c9cc-4358-bea6-71ea9c5292f9.png)

New snow routine (bottom figure) reduced hydrograph flashiness, hence improving model's ability to simulate streamflow in watersheds like Merced Pohono that is snowmelt dominated. As results show, model with new snow routine better simulates streamflow in snowmelt dominated watersheds after refreezing capacity was added to the model.

\
**References:** \
Kokkonen, T., Koivusalo, H., Jakeman, T., & Norton, J. P. (2006). Construction of a degree-day snow model in the light of the ten iterative steps in model development (International Congress on Environmental Modelling and Software, Vol. 73). Retrieved from https://scholarsarchive.byu.edu/iemssconference/2006/all/73
