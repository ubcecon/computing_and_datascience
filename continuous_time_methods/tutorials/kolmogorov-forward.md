---
title       : "Dynamics of distributions under diffusion process using KFE"
author      : Chiyoung Ahn (@chiyahn)
date        : 2019-03-04
---

### About this document
Presented by Chiyoung Ahn (@chiyahn), written with `Weave.jl`.

~~~~{.julia}
using SimpleDifferentialOperators, LinearAlgebra, Plots, NLsolve, DifferentialEquations, Test
gr(fmt = :png); # save plots in .png
~~~~~~~~~~~~~





## Model
Consider the following diffusion process:

$$
dx = \mu dt + \sigma dW
$$

Let $f(x,t)$ be the density of $x$ at time $t$. Given an initial distribution of $f_0(x) = f_0(x,t)$, $f$ satisfies the following PDE by the Kolmogorov Forward Equation:

$$
\partial_{t} f(x,t) = - \mu \partial_{x} f(x,t) + \frac{1}{2} \sigma^2  \partial_{x x} f(x,t)
$$

## Setup
### Model
~~~~{.julia}
T = 100.0 # terminal time
μ = -0.1 # constant negative drift
σ = 0.5
M = 100 # size of grid
x = range(-5.0, 5.0, length = M) # grid
bc = (Reflecting(), Reflecting())
params = (μ = μ, σ = σ, x = x, bc = bc); # group them as a tuple
~~~~~~~~~~~~~





### Initial distribution 
~~~~{.julia}
# Define initial distribution of `x` at time 0
f0(x) = exp(-x^2/2) / sqrt(2*π)
# Discretize by x
f0_discretized = f0.(x) / sum(f0.(x));
~~~~~~~~~~~~~





### Corresponding operator
~~~~{.julia}
L_HJBE = μ*L₁₋(x, bc) + (σ^2 / 2) * L₂(x, bc) # HJBE operator
L_KFE = transpose(L_HJBE)
~~~~~~~~~~~~~





## Find the stationary distribution
~~~~{.julia}
# Find stationary distribution
# Find f such that Lf = 0, where sum of `f` is 1

# Define the residual
function f!(F, x)
    F[:] = L_KFE*x
end

result = nlsolve(f!, f0_discretized) # extract the resulting solution
f_ss = result.zero / sum(result.zero); # stationary distribution found
~~~~~~~~~~~~~





Confirm `Lf = 0` holds:

~~~~{.julia}
@show L_KFE * f_ss
~~~~~~~~~~~~~


~~~~
L_KFE * f_ss = [-2.00762e-12, 6.90559e-14, 9.87432e-13, 9.12825e-13, -8.754
11e-13, 7.81708e-13, -1.08868e-12, -3.27516e-13, 6.18616e-13, 8.40938e-13, 
-2.98928e-13, -7.21645e-15, -4.66516e-13, 2.23543e-13, -5.27356e-15, 1.9073
6e-13, -8.16569e-14, 7.93809e-14, 7.33857e-14, 6.81122e-14, -6.08125e-14, 5
.9508e-14, -1.9984e-15, 5.39013e-14, -5.0987e-14, 2.77556e-17, 5.19029e-14,
 5.32213e-14, 2.498e-15, 5.92443e-14, 6.39488e-14, 4.77396e-15, 7.63833e-14
, 8.39745e-14, -1.82285e-13, 1.00947e-13, -1.14783e-13, 2.30801e-13, 6.1964
3e-15, 2.661e-13, 5.71765e-15, 4.89886e-15, 3.09149e-13, 3.33761e-15, -3.40
956e-13, 1.81799e-15, 1.47451e-15, 7.80626e-16, -3.52395e-13, -3.81639e-16,
 -7.01574e-13, 3.49599e-13, -1.56472e-15, -2.21524e-15, -3.2945e-13, 3.2956
8e-13, -3.08538e-13, -4.67161e-15, -5.59275e-15, 1.37654e-13, 1.29058e-13, 
1.19493e-13, 1.0961e-13, 9.92713e-14, 8.85021e-14, -3.99637e-14, 3.04297e-1
4, 2.80331e-15, 2.65152e-15, -2.04481e-14, -9.69624e-15, 9.11294e-15, -2.96
724e-15, -2.26338e-15, 2.42861e-17, 4.33681e-19, 9.71445e-17, -2.84928e-16,
 2.08167e-17, -1.30104e-18, 3.03577e-18, 2.1684e-19, 0.0, 2.1684e-19, 4.336
81e-19, -1.0842e-18, 4.33681e-19, 4.33681e-19, -2.1684e-19, 2.1684e-19, 4.3
3681e-19, 2.1684e-19, -3.25261e-19, -2.1684e-19, 3.25261e-19, 2.1684e-19, -
4.33681e-19, 5.42101e-20, 2.71051e-19, -1.0842e-18]
100-element Array{Float64,1}:
 -2.0076162954296706e-12
  6.905587213168474e-14 
  9.874323581016142e-13 
  9.128253708468037e-13 
 -8.754108549169359e-13 
  7.817080316385727e-13 
 -1.0886846979474285e-12
 -3.275157922644212e-13 
  6.186162693211372e-13 
  8.409384300023248e-13 
  ⋮                     
  2.168404344971009e-19 
 -3.2526065174565133e-19
 -2.168404344971009e-19 
  3.2526065174565133e-19
  2.168404344971009e-19 
 -4.336808689942018e-19 
  5.421010862427522e-20 
  2.710505431213761e-19 
 -1.0842021724855044e-18
~~~~



~~~~{.julia}
# Plot
plot(x, f_ss,  
    label = ["f_ss"] ,
    title = "Stationary distribution f_ss(x)", lw = 3)
~~~~~~~~~~~~~


![](figures/kolmogorov-forward_7_1.png)\ 




## Solve the corresponding dynamics
### Define `df`, time derivative of `f`
~~~~{.julia}
# Define df
function df!(df, f, params, t) 
    μ, σ, x, bc = params 
    L_HJBE = μ*L₁₋(x, bc) + (σ^2 / 2) * L₂(x, bc) # HJBE operator
    L_KFE = transpose(L_HJBE); # KFE operator is adjoint of HJBE
    
    # Assign it as df
    df[:] = L_KFE*f
end
~~~~~~~~~~~~~


~~~~
df! (generic function with 1 method)
~~~~





### Define the corresponding ODE
~~~~{.julia}
prob = ODEProblem(df!,f0_discretized,(0, T), params);
~~~~~~~~~~~~~





### Solve and plot it
~~~~{.julia}
# Solve the DE
f = solve(prob);
~~~~~~~~~~~~~



~~~~{.julia}
# Generate plot
plot(x, [f(0.0) f(T/10) f(T/8) f(T/5) f(T/3) f(T/2) f(T) f_ss],  
    label = ["f(0)", "f(T/10)", "f(T/8)", "f(T/5)", "f(T/3)", "f(T/2)", "f(T)", "f_ss"] ,
    title = "Dynamics of f(x, t), by t", 
    linestyle = [:solid :dot :dot :dot :dot :dot :solid :dash], 
    lw = 3)
~~~~~~~~~~~~~


![](figures/kolmogorov-forward_11_1.png)\ 

