FROM julia:1.0.1-stretch
# Dependency layer
RUN apt-get update && apt-get install -y apt-utils && apt-get install -y libxt6 libxrender1 libgl1-mesa-glx libqt5widgets5 wget make bzip2 gcc g++ git
# # Conda layer. From conda official docker
RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \ 
    && /bin/bash ~/miniconda.sh -b -p /opt/conda \ 
    && rm ~/miniconda.sh \ 
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \ 
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc \ 
    && echo "conda activate base" >> ~/.bashrc 
# Jupinx layer. 
RUN /bin/bash -c "source ~/.bashrc; pip install sphinxcontrib-bibtex; git clone https://github.com/QuantEcon/sphinxcontrib-jupyter; cd sphinxcontrib-jupyter; python setup.py install"
# Julia layer  
RUN julia -e "using Pkg; pkg\"add Expectations Compat IJulia Revise QuantEcon InstantiateFromURL Plots GR Parameters Distributions DifferentialEquations DiffEqBase\"; pkg\"build\"; pkg\"precompile\"" 
