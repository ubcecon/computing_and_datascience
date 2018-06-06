
f(x) = x.^2
println("Square it: $(f(2))")

##Plots.jl is extremely slow for the first plot.  Much faster after
using Plots
gr() # Choose a backend

##Alternatively, use Gadfly
#using Gadfly
p = plot(1:7, f(1:7)) # This will plot to the plot pane
display(p) #In Juno and the REPL, you need to display a plot
