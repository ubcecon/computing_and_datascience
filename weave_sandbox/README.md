# Sandbox for Weave and Markdown to Notebook Translation

##  Weave

- The [Weave.jl](https://github.com/mpastell/Weave.jl) package is intended to provide a solution to many problems in `literate programming'.
- While it is more tuned towards turning combined markdown/code into PDF, it can also generate a jupyter notebook

## Weave to Notebook Installation Instructions
 This relies on the Python and Jupyter ecosystem, so it will need to be installed if it is not already.

1. If you have installed Anaconda, Jupyter and nbconvert are installed, but they may not be in your path.  You can test if they are by typing `jupyter` into a console
    - If they are not, then them to the path based on your operating system.  For example, they might be in `C:\bin\Anaconda3\Scripts` if you installed Anaconda in `c:\bin`
1. If you didn't install nbconvert, then verify the installation with [nbconvert](https://nbconvert.readthedocs.io/en/latest/install.html)
    - **TODO:** It is unclear whether you need to have XeLaTeX installed just to generate a notebook

Once you have `jupyter` and `nbconvert` in your path, you should be able to use Weave.  At this point, open a Julia REPL and checkout Weave from the master with
```julia
Pkg.checkout("Weave") #Note that this functionality isn't in the published version yet
```

At that point, you can test out the generation by going to this folder on your machine and using one of the example files
```julia
using Weave #don't worry about deprecation warnings

# There are three examples
notebook("test.jmd")
notebook("test_2.jl")

# At this point, graphics don't seem to correctly show with this approach, but the rest should run.
notebook("FIR_design.jl")

#  Plotting can be done using the following pattern
notebook("test_plotting.jmd")
```

## Using Weave
See the documentation in [Weave.jl Docs](http://weavejl.mpastell.com/stable/)  There are two main approaches to writing the code, as outined in [Usage](http://weavejl.mpastell.com/stable/usage/):

1. Special comments in an otherwise normal `.jl` file:  See [gadfly_md_sample.jmd](https://raw.githubusercontent.com/mpastell/Weave.jl/master/examples/gadfly_md_sample.jmd) as a good example
1. Special code sections in an otherwise normal mardown file, called `.jmd`:  See [FIR_design.jl](https://github.com/mpastell/Weave.jl/blob/master/examples/FIR_design.jl)
