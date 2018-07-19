```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/../../../../../c:/Users/Arnav Sood/Desktop/computing_and_datascience/julia_sandbox/literate_test.jl"
```

This is a markdown comment. We can use Markdown syntax, like calling this language `julia`, making stuff *italic* and **bold**, etc.

```@example literate_test
# This is a Julia comment.
```

This will only show up in markdown output.

This is some stuff from another file in this repo.

```@example literate_test
type TestType
    x::Any
    y::Real
    z::Integer
end

print("This Julia code should work no matter what.")

@assert 1 == 1
```

This is a test of pre-processing. The date is: 2018-06-25.#-
*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

