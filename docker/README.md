# Placeholder for notes on Docker

## Example docker images and stacks
- Help for the Jupyter Stacks: http://jupyter-docker-stacks.readthedocs.io/en/latest/index.html
    - Jupyter/Python/etc:  https://github.com/jupyter/docker-stacks/tree/master/datascience-notebook
    
## To build the docker image locally
    docker build -t <your_username>/<docker_image_name_you_want_to_call_it> -f <Dockerfile_name> .
### If you want to have them commited to your docker hub
    docker login
    docker push <your_username>/<docker_image_name_you_want_to_call_it>
    
### I use this command to build the julia test image, you can modify the docker file used to add more packages and precompile
    docker build -t jasminefish000/julia_test -f Dockerfile_Juliav1.0 .
### Use this command to build Jupyter+Juliav1.0+GR image, the docker image size after building is 1.59G 
    docker build -t jasminefish000/jupyter_test -f Dockerfile_Juliav1.0 .
