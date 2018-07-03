#A whole bunch of splatting...
u(x; p...) = x^(1-p[:γ])/(1-p[:γ])
g(; a, γ) = a + γ #Splatting the exact named parameters!
function f(x; p...)
    x2 = g(; p...) + x * p[:a]
    return u(x2; p...)
end


#Trying
u2(x, γ) = x^(1-γ)/(1-γ)
function f2(x; p...)
    x2 = g(;p...) + x * p[:a]
    return u2(x2, p[:γ])
end
kw = (a=1, γ=0.5)
f(2.0;kw...)

@btime f(2.0;$kw...)
@btime f2(2.0;$kw...) #The same.

#With a structure and no types
struct Params
    a
    γ
end
param = Params(1, 0.5)

## There is something oddly inconsistent about splatting named tuples in v0.7
myp = (a=2,b=4)
myp.a #Note typical named tuple access
f(;p...) = p[:a] #Note access as a dictionary!
f(;myp...)
#Base.getproperty(p::Base.Iterators.Pairs{<:Any,<:Any,<:Any,<:NamedTuple}, prop) = getproperty(p.data, prop)
#The above used to work, but doesn't now...