using BenchmarkTools, StaticArrays, Parameters, NamedTuples, LinearAlgebra
#Generic functions used by all variations
f(p) = p.a + 1.0
g(f,p) = f(p)
h(x) = x^2
i(f, p) = f(p) * sum(h.(p.c))
function j(f, p)
    @unpack c, b, d = p #Benchmarked that @unpack is identical
    g(f,p) .+ sum(h.(c)) .+ b .+ c * d
end
k(p) = sum(p.c) + p.a * p.b

#Higher-order function function
function l(p)
    return x-> x^(p.b) #Returns a function
end

#Uses the higher-order function
function m(p, l2)
    @unpack a, b, e = p
    f2 = l2(p) #Uses the higher order function
    return f2(a) + h(b) + e(b)
end

#Checking if there is a higher order function penalty
n1(p) = 1.1^(p.b)
function n2(p)
    n3 = l(p)
    return n3(1.1)
end

#Named Tuple
np = (a=1.0, b=2, c=[1 2 3], e=x -> x^3, d=@SVector [1, 2, 3])

#v0.6 named tuple
np2 = @NT(a=1.0, b=2, c=[1 2 3], e=x -> x^3, d=@SVector [1, 2, 3])

#Typed Structure
struct X{F}
    a::Float64
    b::Int64
    c::Array{Int64,2}
    e::F
    d::SArray{Tuple{3},Int64,1,3}
end
np3 = X(1.0, 2, [1 2 3], x -> x^3, @SVector [1, 2, 3])
#Untyped structure
struct X2
    a
    b
    c
    e
    d
end
np4 = X2(1.0, 2, [1 2 3], x -> x^3, @SVector [1, 2, 3])

#Trying the variations
@btime i($f,$np)
@btime i($f,$np2)
@btime i($f,$np3)
@btime i($f,$np4)

@btime j($f,$np)
@btime j($f,$np2)
@btime j($f,$np3)
@btime j($f,$np4)

@btime k($np)
@btime k($np2)
@btime k($np3)
@btime k($np4)

@btime m($np, $l)
@btime m($np2, $l)
@btime m($np3, $l)
@btime m($np4, $l)

#Checking if overhead from higher order functions
@btime n1($np)
@btime n2($np)
@btime n1($np2)
@btime n2($np2)
@btime n1($np3)
@btime n2($np3)
@btime n1($np4)
@btime n2($np4)
