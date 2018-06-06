# Julia libraries and notes

## General web resources
- Search and list of registered and unregistered packages: http://genieframework.com/packages
- https://juliaobserver.com/
- http://svaksha.github.io/Julia.jl/ Somewhat curated

## Lecture notes and introductions
- https://github.com/tpoisot/ScientificComputingForTheRestOfUs
- http://ucidatascienceinitiative.github.io/IntroToJulia/
- https://github.com/timholy/IntroToJuliaWashU
- https://www.juliabox.com/notebooks/tutorial/00%20-%20Start%20Tutorial.ipynb
- https://julialang.org/learning/ though many are for out of date julia versions.
  - A short introductory manual: http://bogumilkaminski.pl/files/julia_express.pdf
  - https://www.analyticsvidhya.com/blog/2017/10/comprehensive-tutorial-learn-data-science-julia-from-scratch/
- https://github.com/stevengj/18S096-iap17 for a course on Julia from MIT for high-performance
  - Superb notes, but not where to start.  Use for understanding cache locality, 
  - https://github.com/stevengj/18S096-iap17/blob/master/lecture8/Automatic%20differentiation%20and%20applications.ipynb as an introduction to AD
  - https://github.com/stevengj/18S096-iap17/blob/6d5a717b5c6fe34fb584718821578e06ce16c06d/lecture8/Interval%20Newton.ipynb and https://github.com/stevengj/18S096-iap17/blob/master/lecture8/Interval%20arithmetic.ipynb interval arithmetic
- Tutorial on dataframes https://github.com/bkamins/Julia-DataFrames-Tutorial/blob/master/README.md

## Notes on particular topics
- On values and naming: http://www.johnmyleswhite.com/notebook/2014/09/06/values-vs-bindings-the-map-is-not-the-territory/

## Cheat Sheets
- https://juliadocs.github.io/Julia-Cheat-Sheet/

## Submitting bugs and changes
- https://docs.julialang.org/en/stable/manual/packages/#Documentation-changes-1
  
## Style guides and conventions
- https://github.com/johnmyleswhite/Style.jl/blob/master/README.md
  
## Structuring Files and packages
- See Julz: https://github.com/djsegal/Julz.jl 
- https://github.com/JuliaLang/PkgDev.jl#generatepkg-license
- An example: https://github.com/ChrisRackauckas/ExamplePackage.jl
- https://github.com/vikjam/mostly-harmless-replication for julia based replication

## Some general higher level libraries
- https://github.com/matthieugomez/FixedEffectModels.jl
- https://github.com/matthieugomez/EconPDEs.jl
- Aiyigari steady state: http://www.princeton.edu/~moll/HACTproject/aiyagari_diffusion_equilibrium.jl

## Dataframes
- https://github.com/JuliaData/DataFrames.jl
- https://github.com/JuliaData/CSV.jl
- https://github.com/JuliaData/Missings.jl
- https://github.com/JuliaData/CategoricalArrays.jl
- https://github.com/nalimilan/FreqTables.jl
- https://github.com/JuliaStats/DataFramesMeta.jl


## Libraries for Data Science, etc.
- https://github.com/JuliaStats/GLM.jl
- https://github.com/matthieugomez/FixedEffectModels.jl
- https://github.com/jmboehm/RegressionTables.jl
- https://github.com/JuliaStats/MultivariateStats.jl
- 

## Environment
- Run Jupyter online: https://www.juliabox.com/
  - https://github.com/jupyter/nbgrader for grading?
- https://github.com/quinnj/Sublime-IJulia
- https://discourse.julialang.org/t/workflow-for-julia-scripts/6453
- Install RISE for slideshow's in Jupyter (https://github.com/damianavila/RISE)  Run from Julia REPL (HAVING TROUBLE RIGHT NOW)
```julia
using Conda
Conda.add_channel("damianavila82")
Conda.add("rise")
```
- For better syntax coloring in the REPL https://github.com/KristofferC/OhMyREPL.jl

## More lecture notes
- https://github.com/PaulSoderlind/EmpiricalFinancePhD
- https://github.com/PaulSoderlind/FinancialTheoryMSc
- https://github.com/PaulSoderlind/JuliaTutorial

## Optimization
- https://github.com/robertfeldt/BlackBoxOptim.jl/blob/master/README.md
- MPEC and complementarity: https://github.com/chkwon/Complementarity.jl
- https://github.com/rdeits/ConditionalJuMP.jl converts complementarity into mixed-integer

## Auto-differentiation
- https://github.com/gaika/AutoDiffSource.jl source code transformation style. Works with ArrayFire
- https://github.com/dfdx/XGrad.jl

## GPU
- https://github.com/JuliaComputing/ArrayFire.jl
- https://mikeinnes.github.io/2017/08/24/cudanative.html
- https://medium.com/@sdanisch/writing-extendable-and-hardware-agnostic-gpu-libraries-b21c145a8dad

## Continuous Integration
- https://github.com/JuliaCI/

## Optimization
- Consider checking latest benchmarks, http://plato.asu.edu/ftp/ampl-nlp.html and wrapping as required

## AD and Interval Analysis
- https://github.com/JuliaIntervals
- https://github.com/JuliaIntervals/IntervalRootFinding.jl
- https://github.com/JuliaIntervals/IntervalContractors.jl for inverse functions
- https://github.com/JuliaIntervals/IntervalConstraintProgramming.jl

## PDEs, etc.
- Inverse problems, PDE estimation: https://github.com/JuliaInv/jInv.jl

## Dynare and DSGE
- https://github.com/DynareTeam/Dynare.jl	
- https://github.com/MichelJuillard/dynare.jl
- A possible successor to Dynare: https://github.com/EconForge/Dolang.jl
  - https://github.com/EconForge/Dolang.jl

## Data sources
- http://quandljl.readthedocs.io/en/latest/search_data.html#interactive-search

## Machine Learning
- https://fluxml.github.io/
- https://julialang.org/blog/2017/12/ml&pl
- https://github.com/denizyuret/Knet.jl
- https://github.com/ilkarman/DeepLearningFrameworks Profiling and examples across various implementations.

## Clusters
- https://github.com/JuliaParallel/ClusterManagers.jl

## Docker
- https://github.com/jupyter/docker-stacks/tree/master/datascience-notebook
- https://juliacomputing.com/blog/2017/11/29/juliapro-ami-and-docker-image.html
