Here include all the work that I did when I edited HYMOD model from its initial form that was used before and how I edited show routine to improve model accuracy. 
Since I was studying watersheds that were snow dominated, I needed a model that had a robust snow routine. Initial HYMOD version did not provide that, so I needed to
develop a new routine based on process based equations.

Add:
- Equations that I added to improve old model framework
- MATLAB code

Comparison between two models with varying snow routines:

![image](https://user-images.githubusercontent.com/111301407/195432657-0907e36e-d696-4c4a-8e37-fb822edd2ec7.png)
![image](https://user-images.githubusercontent.com/111301407/195432687-bffeb366-52ea-4b2e-ac74-cf76f17d8676.png)

New snow routine reduces flashiness in hydrograph, hence improving overall model's ability to simulate streamflow in watersheds like Merced Pohono that is snowmelt dominated. As results show, new model better captures snow routine when refreezing capacity was added to the model.
