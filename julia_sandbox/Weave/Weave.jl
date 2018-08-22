using Weave
# using Gadfly, Cairo, Fontconfig # Dependencies for default Weave example. 
# using IJulia # Dependency for output to notebook. 

#=
    Output the default Weave example to different outputs. 
=#

# weave(Pkg.dir("Weave","examples","gadfly_md_sample.jmd"), out_path = :pwd, doctype = "md2html") # HTML output. 
# weave(Pkg.dir("Weave","examples","gadfly_md_sample.jmd"), out_path = :pwd, doctype = "pandoc") # Markdown output. 
# # weave(Pkg.dir("Weave","examples","gadfly_md_sample.jmd"), out_path = :pwd, doctype = "md2pdf") # PDF output. CURRENTLY BROKEN. 
# notebook(Pkg.dir("Weave","examples","gadfly_md_sample.jmd"), :pwd) # Notebook output. 
# tangle(Pkg.dir("Weave","examples","gadfly_md_sample.jmd"), out_path = :pwd) # Tangled output. 

#=
    Test the more specialized features that we need. 
=#

# weave("economics_examples.jmd", out_path = :pwd, doctype = "md2html", template = "custom_html.tpl") # HTML output
# # weave("economics_examples.jmd", out_path = :pwd, doctype = "md2pdf") # PDF output. Currently broken.
# convert_doc("economics_examples.jmd", "economics_examples.ipynb") # Notebook output. 
# tangle("economics_examples.jmd", out_path = :pwd) # Tangled output. 

# Tests for equation numbering, etc. 
weave("economics_examples.jmd", out_path = :pwd, doctype = "md2html")
weave("economics_examples.jmd", out_path = :pwd, doctype = "md2tex")