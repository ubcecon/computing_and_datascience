---
title       : "Dynamics of distributions under diffusion process using KFE"
author      : Chiyoung Ahn (@chiyahn)
date        : 2019-03-01
---

### About this document
Presented by Chiyoung Ahn (@chiyahn), written with `Weave.jl`.

~~~~{.julia}
using SimpleDifferentialOperators, LinearAlgebra, Parameters, Plots, BenchmarkTools, NLsolve
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
μ = -0.1 # constant negative drift
σ = 0.1
M = 100 # size of grid
x = range(-5.0, 5.0, length = M) # grid
bc = (Reflecting(), Reflecting())
~~~~~~~~~~~~~





### Initial distribution 
~~~~{.julia}
# Define initial distribution of `x` at time 0
f_0(x) = exp(-x^2/2) / sqrt(2*π)
~~~~~~~~~~~~~





### Corresponding operator
~~~~{.julia}
L_HJBE = μ*L₁₋(x, bc) + (σ^2 / 2) * L₂(x, bc) # HJBE operator
L_KFE = transpose(L_HJBE)
~~~~~~~~~~~~~





## Solve
### Find stationary distribution
~~~~{.julia}
# Find stationary dsitribution, i.e., 
# find f such that Lf = 0, where sum of `f` is 1

function f!(F, x)
    F[:] = L_KFE*x
end

result = nlsolve(f!, f_0.(x));
f_stationary = result.zero / sum(result.zero); # stationary distribution found
~~~~~~~~~~~~~





Confirm `Lf = 0` holds:

~~~~{.julia}
@show L_KFE * f_stationary
~~~~~~~~~~~~~


~~~~
L_KFE * f_stationary = [-5.56666e-13, 6.54088e-13, -2.94487e-14, -1.16226e-
14, 2.91954e-15, -3.10516e-16, -1.06794e-17, 6.39679e-18, -1.42302e-19, -1.
59242e-19, 1.23413e-18, 9.47618e-19, -1.01707e-18, -1.22411e-17, -2.61496e-
17, -2.92502e-17, -1.96731e-17, -1.07736e-16, 1.2659e-16, 7.19321e-18, 9.04
026e-18, 1.26011e-17, 1.46261e-17, 1.72308e-17, 4.82236e-16, 5.46118e-16, 1
.2154e-15, 7.16365e-16, 6.19912e-15, 1.31037e-14, 1.3176e-14, -1.60795e-14,
 2.85342e-14, -1.75243e-14, -1.89071e-14, 1.91255e-14, -4.09928e-14, -1.449
1e-15, 6.2838e-16, -9.37289e-16, 4.76724e-14, -4.88052e-14, 4.93677e-14, 1.
42569e-16, 5.28802e-17, -4.96804e-14, 1.5771e-16, 4.9398e-14, 9.82518e-14, 
4.34204e-17, -3.92415e-17, -4.90791e-14, -1.4453e-16, 4.95338e-14, 8.36494e
-17, 4.97744e-14, -4.97378e-14, 2.54684e-16, -4.91465e-14, 7.13017e-16, 4.8
2065e-14, -4.60076e-14, -4.42824e-14, -4.22255e-14, -5.55406e-16, -1.76e-14
, -3.44539e-14, 1.30819e-14, -3.00328e-14, 1.00837e-14, 5.44162e-15, -6.839
07e-16, -4.09828e-15, -3.5414e-15, -1.7747e-15, 1.42458e-15, -3.21074e-17, 
9.70618e-16, -2.48837e-17, -2.08059e-17, 1.62605e-16, 1.8879e-16, 1.91826e-
16, -6.56306e-18, -1.64153e-17, -3.89669e-18, -9.27147e-18, -5.54786e-18, -
2.37606e-18, 1.26426e-18, -1.87696e-19, -8.71255e-20, 1.62679e-20, -2.93633
e-20, 3.61136e-20, 8.75238e-21, -4.59317e-20, 6.36356e-20, 5.86148e-20, 1.0
9263e-19]
100-element Array{Float64,1}:
 -5.566658245470535e-13 
  6.54087894957911e-13  
 -2.944866572818228e-14 
 -1.1622647289044608e-14
  2.9195396100689663e-15
 -3.1051550219984847e-16
 -1.0679391398982219e-17
  6.396792817664476e-18 
 -1.4230153513872246e-19
 -1.5924219408380846e-19
  ⋮                     
 -8.712550661346167e-20 
  1.6267900176142043e-20
 -2.936328030075119e-20 
  3.6113620322294694e-20
  8.752381860231023e-21 
 -4.593166145093706e-20 
  6.363558116582361e-20 
  5.861475372743958e-20 
  1.0926326767790233e-19
~~~~


