# Call if required
# Pkg.add("Weave")
using Weave

#Right now (with JuliaPro 0.6.1) the notebook is not working when generated, but you can change the kernel to 0.6.1 and it seems to.
convert_doc("test.jmd", "test.ipynb") #This should generate the notebook
convert_doc("test_2.jl", "test_2.ipynb") #Note the .jl file has special comments in it.