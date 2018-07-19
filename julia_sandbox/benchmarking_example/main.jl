# Dependency. 
using BenchmarkTools

# Define a function to benchmark. 
foo(x) = x^2 

# Define a benchmark group and fill it with some tests. 
regressions = BenchmarkGroup()
srand = 123 # Seed as in the tutorial. 
regressions["floats"] = @benchmarkable foo.($(rand(100))) # Interpolate as in the tutorial. 
regressions["ints"] = @benchmarkable foo.($(rand(1:1000, 100)))

# Get and compress results. 
results = run(regressions)
results = median(results)

# Write results to file. 
BenchmarkTools.save("benchmarks.json", results)

# Load results from file. 
old = BenchmarkTools.load("benchmarks.json")[1]

# Make judgment. 
@show judgment = judge(old, results)

# Inspect judgment element. 
@show judgment["floats"]