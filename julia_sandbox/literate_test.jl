# This is a markdown comment. We can use Markdown syntax, like calling this language `julia`, making stuff *italic* and **bold**, etc. 
## This is a Julia comment. 
#md # This will only show up in markdown output. 
#nb # This will only show up in Jupyter output.

# This is some stuff from another file in this repo.

type TestType
    x::Any
    y::Real
    z::Integer
end

print("This Julia code should work no matter what.")

@assert 1 == 1

# This is a test of pre-processing. The date is: DATETIME.