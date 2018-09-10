FROM julia:latest
USER root
# install Julia packages in /opt/julia instead of $HOME
ENV JULIA_PKGDIR=/opt/julia
# Add packages
USER $NB_USER
# Julia packages
RUN julia -e 'using Pkg; pkg"add QuantEcon; precompile"' 
