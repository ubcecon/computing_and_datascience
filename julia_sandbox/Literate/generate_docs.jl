using Literate

import Plots

function update_date(content)
    content = replace(content, "DATETIME" => Date(now()))
    return content
end

Literate.markdown(pwd() * "\\julia_sandbox\\literate_test.jl", pwd() * "\\julia_sandbox\\"; preprocess = update_date)
Literate.notebook(pwd() * "\\julia_sandbox\\literate_test.jl", pwd() * "\\julia_sandbox\\"; preprocess = update_date)
Literate.notebook(pwd() * "\\julia_sandbox\\literate_test_2.jl", pwd() * "\\julia_sandbox\\"; preprocess = update_date)
