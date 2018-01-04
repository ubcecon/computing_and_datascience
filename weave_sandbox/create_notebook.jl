# Call if required
# Pkg.add("Weave")
using Weave

convert_doc("test.jmd", "test.ipynb") #This should generate the notebook
#Right now (with JuliaPro 0.6.1) the notebook is not working when generated, but you can change the kernel to 0.6.1 and it seems to.