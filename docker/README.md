# Placeholder for notes on Docker

# How to get docker running on your laptop
 Step by step to run docker:

1. Install Docker see https://docs.docker.com/install/, should expect to see an executable file.
For Mac, https://store.docker.com/editions/community/docker-ce-desktop-mac
For Windows, https://store.docker.com/editions/community/docker-ce-desktop-windows

2. Test run: to test run Docker, run `docker version`, and `docker run hello-world`. This provides you with a test-run of a docker, and give the information whether docker is installed correctly.
To see installed docker container `docker container ls`.

3. After installing docker, one experiment run `docker run -p 8888:8888 jupyter/datascience-notebook`. This notebook contains scientific computing tools from Python,Julia and R.
It automatically downloads the container and starts for the first time. Press  `control+c` to shut down the server. 
To view the existing containers, use the command `docker ps -a` in the command line.
To view running containers, use `docker container ls`.
To kill container, use `docker kill <container_name>`.
To start a exisitng container, user ` docker start -a <container_id>`, the container id is something like ` 6bae11aca990`.

4. When starting the docker using step 3, the terminal print a url and ask you to paste it to your favorate browser. I received something like  `http://(1669f396172a or 127.0.0.1):8888/?token=e8b4ab83d23b8befe152936868bb79402ffdbfd9663615d4`.
*Note: In order to run the Jupyter notebook, need to change the url into `http://127.0.0.1:8888/?token=e8b4ab83d23b8befe152936868bb79402ffdbfd9663615d4`.

5. After step 4, should see a jupyter notebook opened in the preferred browser.  From here, to open jupyter notebook, click new - > julia. To open julia REPL, click new -> terminal, then type `julia`.
The version used in the current container is v0.6.2.

6. Install an experimental package in the REPL using `Pkg.add("QuantEcon")`.  Experiment if it is still there after I close it and open it again.
Shut down the kernel by using `Control+c` and then restart it by using `docker start -a <container_id>`. 
The installed package `QuantEcon` can still be used.

7. To mount the local directory, use the `-v` argument with `docker run`.
it must be done when first run the container. There are some potential issues. See https://github.com/jupyter/docker-stacks/issues/199.
One command I found useful is `docker run  -p 8888:8888 -v "$PWD":/home/jovyan/work jupyter/datascience-notebook`.

On a windows system, this works for me ` run -p 8888:8888 -v C:\Users\Jasmine:/home/jovyan/work jupyter/datascience-notebook`.
One thing to notice: `docker run` is the command one uses when first initiate the docker container.
If you shutdown the docker container, it went dormant. But everything installed remains in the container. To start the container again, use `docker start -a <container_id>`.


# Example docker images and stacks
- Help for the Jupyter Stacks: http://jupyter-docker-stacks.readthedocs.io/en/latest/index.html
    - Jupyter/Python/etc:  https://github.com/jupyter/docker-stacks/tree/master/datascience-notebook
    
# How to build your customizable docker image
### Command to build docker image locally
    docker build -t <your_username>/<docker_image_name_you_want_to_call_it> -f <Dockerfile_name> .
### If you want to have them commited to your docker hub
    docker login
    docker push <your_username>/<docker_image_name_you_want_to_call_it>
    
### I use this command to build the julia test image, you can modify the docker file used to add more packages and precompile
    docker build -t jasminefish000/julia_test -f Dockerfile_Juliav1.0 .
### Use this command to build Jupyter+Juliav1.0+GR image, the docker image size after building is 1.59G 
    docker build -t jasminefish000/jupyter_test -f Dockerfile_Juliav1.0 .
