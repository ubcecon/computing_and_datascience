# General Python Notes and References

### Style Guides

- https://www.python.org/dev/peps/pep-0008/
- https://google.github.io/styleguide/pyguide.html
- http://deeplearning.net/software/pylearn/v2_planning/API_coding_style.html
- Docstring
  - https://www.python.org/dev/peps/pep-0257/
  - https://github.com/numpy/numpy/blob/master/doc/HOWTO_DOCUMENT.rst.txt

### IDEs
- https://github.com/spyder-ide/spyder/blob/master/README.md
  
### Package Management

- Comments on conda package manager: https://blog.konpat.me/conda-and-anaconda-for-python-package-management-and-virtual-envs/
- Recipes, etc. for conda package manager: https://github.com/conda-forge

### Software Engineering Infrastructure

- Travis with conda etc. https://gist.github.com/dan-blanchard/7045057
- Travis with cython: https://github.com/thearn/simple-cython-example
- Documentation: http://www.sphinx-doc.org/en/stable/


### Libraries for Parallel Computing

- http://dask.readthedocs.io/en/latest/
- List of blaze libraries, including C++ bindings: http://blaze.pydata.org/
  - https://www.continuum.io/anaconda-academic-subscriptions
  - https://docs.continuum.io/iopro/ and https://docs.continuum.io/accelerate/ should be free?
- Distributed Dask on S3: http://blaze.pydata.org/blog/2016/02/17/dask-distributed-1/

### General Numerical Libraries

- Theano symbolic expression compiler: http://deeplearning.net/software/theano/
- Symbolic: http://www.sympy.org/en/index.html
- Scipy and numpy: https://github.com/scipy/scipy
- http://pytorch.org/about/ for learning, but also has autogradient's, GPU supported senors, etc.  Replaces numpy with  GPU-ready tensors.

### Statistics, etc.
- MCMC http://docs.pymc.io/notebooks/getting_started.html


### Derivatives and AD

- See benchmarking of: https://arxiv.org/pdf/1606.06311.pdf
- Within Theano, symbolic: http://deeplearning.net/software/theano/tutorial/gradients.html
- https://github.com/HIPS/autograd/blob/master/docs/tutorial.md
- https://github.com/HIPS/Kayak/
- AD ofgradient decent?  Use for calibration/etc?: https://github.com/HIPS/hypergrad
- https://stackoverflow.com/questions/36370129/does-tensorflow-use-automatic-or-symbolic-gradients
- https://github.com/casadi/casadi/wiki
- See https://github.com/b45ch1/pyadolc/blob/master/examples/sparse_jacobi_matrix.py for an example of sparsity with pyadolc

### Dataframes/etc:

- https://github.com/pandas-dev/pandas


### Petsc/Slepsc/TAO
- TAO has an implementation for MCP's using http://www.mcs.anl.gov/~tmunson/papers/semismooth.pdf algorithm.  THis is the evolution of the PATH solver: http://www.mcs.anl.gov/petsc/petsc-current/docs/tao_manual.pdf
- https://bitbucket.org/dalcinl/tao4py is a TAO binding.  Seems out of date...
- Petsc example http://www.mcs.anl.gov/petsc/petsc-3.6/src/tao/complementarity/examples/tutorials/blackscholes.c.html example.  Does a pytao example exist?

### Plotting

- matlab like interface: https://matplotlib.org/
- data viualization built on matplotlib: https://seaborn.pydata.org/

### Polynomials and Basis

- https://docs.scipy.org/doc/numpy/reference/routines.polynomials.chebyshev.html#calculus
- Chebfun copy: https://github.com/pychebfun/pychebfun
- Approximation of functions with sympy: http://hplgit.github.io/num-methods-for-PDEs/doc/pub/approx/html/approx.html

### Optimization

-  Python Software for Convex Optimization: http://cvxopt.org/
- http://openmdao.org/


### MPEC
- https://github.com/Pyomo/pyomo/tree/master/examples/mpec

### DAE
- http://daetools.com/docs/index.html and see https://www.slideshare.net/DraganNikoli5/dae-tools-overview

### Other Stuff

- Conversion of mathematica to numpy: https://github.com/gwiederhecker/ToPython?files=1
- Debugging package required: https://pypi.python.org/pypi/ipdb

### Typing in the Medium-Term?

- Read PEP482,483, and PEP484. 
- With an emphasis on numerical methods and scientific computing, where are type annotations going?  Are we thinking of as a tightly managed TypeScript style extension which people will start using for higher performance and have ahead of time compilation?  Eliminate the need for Cython as a separate fork on the language?
- http://cython.readthedocs.io/en/latest/src/tutorial/pure.html, https://github.com/cython/cython/wiki/Python-Typing-Proposal, https://www.python.org/dev/peps/pep-0526/

### Lecture Notes, Cheat Sheets

- http://www.scipy-lectures.org/
- http://mathesaurus.sourceforge.net/matlab-numpy.html

### Examples from economists
- http://nbviewer.jupyter.org/github/QuantEcon/QuantEcon.notebooks/blob/master/aiyagari_continuous_time.ipynb

### Interoperability with C++/etc.
- https://github.com/pybind/pybind11/blob/master/README.md

### Anaconda maintenance, etc.
- https://www.anaconda.com/blog/developer-blog/keeping-anaconda-date/