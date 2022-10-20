MAIN CODE - *Sens_analysis.R*

This code performs a global sensitivity analysis using the Morris One-factor-At-a-Time (OAT) method on SCS Model to analyze its parameter sensitivity. Parameters analyzed: CN, Kb, M(multiplier of ET). Elementary effect (EE) for each parameter is analyzed, where the model output (y) is the NSE of the monthly average streamflows. p=5 (number of discretization of each parameter) and k=15 (number of repetitions) are used for OAT technique. 

# Why Use Sensitivity Analysis?

Often we are interested in performing model sensitivity analyses to:
1) Examine how changes in input parameters impacts model output
2) Test model robustness (Re. variations in output) due to uncertainty in inputparameters
3) Reduce the dimensionality of the model by
   a) Identifying model inputs that cause the largest changes in modeloutput and focusing on improved estimation of these parameters(uncertainty reduction)
   b) Setting less sensitive inputs to fixed values (model simplification)
   
Sensitivity Analysis Methods:
1) Local Methods
2) Global Methods
   a) Monte Carlo with Latin Hypercube Sampling (LHC-MC)
   b) Morris One-factor-At-a-Time (OAT)
   c) Variance decomposition

# Local Methods

Local sensitivity analysis methods valuate the sensitivity of the model at one point in the parameter hyperspace. This could be a randomly chosen parameter set, the calibrated values, the mean parameter values, etc. There are a number of different commonly employed local methods that can be used to explore model sensitivity. Consider a model with N parameters x[1],..., x[N] with model output y.

**Partial Derivative (PD)** is derivative of the output with respect to the change in an input parameter:

![Screen Shot 2022-09-12 at 11 49 23 AM](https://user-images.githubusercontent.com/111301407/189698968-86f16ca2-4c3f-4d82-9587-ea93238af1f2.png)

**Elementary Effect (EE)** is the scaled ratio of the partial derivative of the model output to the partial derivative of a single input parameter:

![Screen Shot 2022-09-12 at 11 51 48 AM](https://user-images.githubusercontent.com/111301407/189699493-7d059c7a-e896-4c2c-b3fa-d042a559e097.png)

This is also sometimes called the Sensitivity Index or the Elasticity of the model output to a change in the model input. Generally, EE is less sensitive to the scale of the parameters compared to PD.

Use of these metrics is relatively simple where only an additional run is required for each parameter. However, results will depend on the size of variation in x[i] (delta x[i]). Generally, the smaller the delta x[i], the more accurate the estimation of the partial derivative. If it is too small, there may not be a large enough change in y. 

# Global Methods

Global methods explore the whole parameter space (not just at set or mean values). You can reach more general conclusions about the impact of a parameter on the model which is less impacted by the currently solution (like a local method). 

**Monte Carlo with Latin Hypercube Sampling (LHC-MC)** consists of many repetitions of a local method. Idea is to generate a large number of random realizations of the parameter set, and run the model for each set. Parameters are assumed to follow a specific probability distribution, such as:
1) Uniform
2) Normal
3) Truncated Normal
4) Beta

This method provides a good estimate of the minimum and maximum value of the model output. However, it requires to run many model runs, which is computationally intensive. 

**Latin Hypercube Sampling (LHC)** is a stratified sampling approach. It subdivides the distribution of each parameter into N intervals, each with a probability of 1/N of occurring. One sample is then taken from each interval once. Sample is selected either randomly in the interval or at the mean value. This reduces computational requirements while fully sampling the parameter hyperspace. 

Issues: 
- Does not reveal the contributions of individual parameters
- Typically ignores the correlation between the parameters (which is more complicated)

**Morris One-factor-At-a-Time (OAT or MOAT)** consists of many repetitions of a local method, but with much fewer repetitions than LHC-MC. 

Steps:
1) Determine the range of each parameter: min(x[i]), max(x[i])
2) Discretize each parameter over its range in equidistant intervals. Letting p be the number of intervals (often p is chosen as 4 as a minimum):

![Screen Shot 2022-09-12 at 12 25 23 PM](https://user-images.githubusercontent.com/111301407/189706545-e6353565-ef07-48dd-beb5-2de8b5ffb95f.png)

3) Randomly choose a set of N parameters: x[1],..., x[N], where each parameter is chosen from its range from min(x[i]) to min(x[i]) + (p-2)*delta x[i]
4) Select each parameter and calculate the Elementary Effect
5) Repeat this procedure N times (once for each parameter), returning all parameters to their original values before calculating EE[i] for each parameter
6) Repeat steps 3) – 5) k times. Typically k is at least 10 – 15

For each x[i], you end up with k values of EE[i]. Typically the mean and standard deviation of each EE[i] is determined:
- A high mean means the parameter has a large influence on the model output
- A low mean means the parameter is a small influence on the model output
- A high standard deviation indicates either a parameter interacting with other parameters or a nonlinear effect of the parameter on the output
- A low standard deviation indicates the parameter has a linear effect (i.e. EE constant across the range parameter values)

**Variance Decomposition** is another popular global sensitivity analysis method. It decomposes the variance of an output into components (fractions) that are attributed to inputs or a set of inputs and measures the contribution of different input variability to the variability of the output. It can be used for nonlinear responses and correlation amongst the input parameters. Typically you determine:
1) First-Order Index - A measure of the effect of varying x[i] alone (averaged over varaiations in other input parameters)
2) Total-Effect Index - A measure of the total effect of varyong x[i], including all of the interactions with other terms
