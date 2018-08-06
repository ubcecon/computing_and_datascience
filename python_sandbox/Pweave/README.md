# Introduction

Pweave is a literate programming tool for embedding Python codes into scientific reports. It works well with various Python packages such as Scipy, Numpy and Matplotlib and it can easily capture both inputs and ouputs (including matplotlib graphics) to a report. What's convenient about using Pweave is that results can be automatically recomputed when inputs change. This is especially useful with images since rather than incorporting graphs into your report, you include the code which creates the graph. This feature makes Pweave great for creating reports, tutorials, presentations etc. as people can simply create the code and notes in a separate file and then generate the jupyter notebooks from it. Pweave supports several input formats and all these formats will produce idential outputs. 

# Installation 

Please check out the [Pweave documentation](http://mpastell.com/pweave/index.html) for more information. For basic setup, try the following commands: 

To install the package with conda, run
  ```
conda install -c conda-forge pweave
  ```
Alternately, you may download the source and run 
  ```
python setup.py install
  ```
For PyPi, enter
  ```
pip install --upgrade Pweave
  ```

# Examples 
Check out Pweave example gallery [here](http://mpastell.com/pweave/examples/index.html)

# Basics

In Pweave, A code block begins with `<<>>=` or `<<options>>=` and end with `@` on a line by itself. The codes between the start and end markers are executed and code blocks appear in the LaTeX output by default. In Pweave you may also use `<% %>` to mark a code chunk which executed but does not echo its source. Pweave can also run codes from fenced markdown Python code chunks by using either of the following ways: 
  ```
```python
```{python}
```{.python}
  ```
If you wish to include graphics in Pweave, just simply begin a code chunk with `<<fig=TRUE, echo=FALSE>>=`. See [here](http://mpastell.com/pweave/usage.html) for some examples. You may also use `<<fig=TRUE, echo=TRUE>>=` if you want to display the code that produces the image. To weave a markdown document, run Pweave `-f DOCTYPE`. Available formats include tex, markdown,sphinx,html etc. Check out the full list of supported output formats [here](http://mpastell.com/pweave/formats.html). For example, to process a Pweave file *intro.Pnw*, simply run *Pweave -f tex intro.Pnw* from the shell. You will then get a LaTeX file which you can then compile it to a PDF. 




