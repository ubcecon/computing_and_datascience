## Notes for using Julia on Compute Canada Clusters

## Getting Started

- Get a compute canada account https://www.computecanada.ca/research-portal/account-management/apply-for-an-account/
- Make sure you have access to a ssh shell
  - On windows, you will want to install https://docs.computecanada.ca/wiki/Connecting_with_MobaXTerm as a terminal
  - Needed? You could get keygens.  Either follow the instructions in the MobaXTerm "Tools/follow the "Key Pair" instructions or open up a windows powershell terminal and go `ssh-keygen`.
  
 Once you are logged in, it is best to edit your `.bashrc` so that Julia is always available.  To do that you could use vim
```bash
vim .bashrc
```
Then edit the file to add something like:
```
module load gcc/7.3.0
module load julia/1.1.1
module load python/3.6
```
In vim, you go `<ESC> i` to enter insert mode, and when you are done `<ESC> :wq!` to save and exit.
 
 ### One-time Jupyter Support Instllation
 
 In a ssh 
```bash
module load gcc/7.3.0
module load julia/1.1.1
module load python/3.6
virtualenv $HOME/jupyter_py3
source $HOME/jupyter_py3/bin/activate
pip install jupyter
pip install jupyterlab
echo -e '#!/bin/bash\nunset XDG_RUNTIME_DIR\njupyter lab --ip $(hostname -f) --no-browser' > $VIRTUAL_ENV/bin/notebook.sh
chmod u+x $VIRTUAL_ENV/bin/notebook.sh
```
Then to add in Julia support, first run the notebook (I think this is necessary?  Remove if not).
```bash
$VIRTUAL_ENV/bin/notebook.sh
```
Then `<ctrl-c>` twice to close it and then run
```bash
julia -e 'using Pkg; pkg"add IJulia"'
``` 

## Starting Jupyter notebooks
In a ssh shell, you need to change out of home first,
```julia
cd /project
source $HOME/jupyter_py3/bin/activate
```
Then replace YOURUSERNAME below and execute
```
salloc --time=1:0:0 --ntasks=1 --cpus-per-task=2 --mem-per-cpu=1024M --account=def-YOURUSERNAME srun $VIRTUAL_ENV/bin/notebook.sh
```

Then in another screen start a tunnel (replaceing the cdrXXX and username)
```julia
ssh -L 8888:cdrXXX.int.cedar.computecanada.ca:8888 USERNAME@cedar.computecanada.ca
```


# OLD: Getting an account and an SSH terminal
NOTE: THESE NOTES WERE BEFORE FINDING https://docs.computecanada.ca/wiki/Jupyter

They should be adapted, likely simplified.

- Get a compute canada account https://www.computecanada.ca/research-portal/account-management/apply-for-an-account/
- If you are on windows: , get a terminal supporting ssh (either https://docs.computecanada.ca/wiki/Connecting_with_MobaXTerm or https://docs.microsoft.com/en-us/windows/wsl/wsl2-install )


### One-time Setup
Find your computecanada login name, such as `YOURUSERNAME`
Optional buy convenient: start by adding ssh keys
You may want to create a public key if you haven't already.  Accept defaults.  You don't need to have a passphrase if you don't want one.
```julia
ssh-keygen 
```

Then replace `YOURUSERNAME` in the following
```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub YOURUSERNAME@cedar.computecanada.ca
```

- In a terminal supporting SSH, connect with
```bash
ssh cedar.computecanada.ca
```

Once you are logged in, it is best to edit your `.bashrc` so that Julia is always available.  To do that you could use vim
```bash
vim .bashrc
```
Then edit the file to add something like:
```
module load gcc/7.3.0
module load julia/1.1.1
export JULIA_NUM_THREADS=10
PATH=~/.julia/conda/3/bin:$PATH
```
In vim, you go `<ESC> i` to enter insert mode, and when you are done `<ESC> :wq!` to save and exit.

Then, run `julia` to get a julia commandline and run the command to install IJulia
```julia
] add IJulia
```
Then install the notebook server with
```julia
using IJulia
IJulia.jupyterlab()
```
Answer `y` to any questions it asks you to install the notebook server.

When it is done, `ctrl-c` a few times to exit julia.  Then in the terminal run
```bash
 jupyter notebook --generate-config
 ```

## Starting a normal julia terminal
You can just go `ssh cedar.computecanada.ca` to start a shell
Then to run Julia, you can just go
```bash
julia
```

## Starting with Jupyter
First, in your terminal you want to setup the tunneling
```bash
ssh -L 8889:127.0.0.1:8889 cedar.computecanada.ca -N -f
```
That should return immediately.  Then go 
```bash
ssh cedar.computecanada.ca
```
and then the following, which may take some time to execute
```
jupyter lab --no-browser --port=8889
```

To access it, on your local browser go to `http://127.0.0.1:8889/`

Note: the first time you do this, take the token that is in the output of the window (e.g. `http://127.0.0.1:8889/?token=03990e819e40c063f9a754e10442030cdd1b1a06e1f21a99` becomes `03990e819e40c063f9a754e10442030cdd1b1a06e1f21a99`) and paste it into the login screen.  You may want to use token and setup a password (which could be blank).
cdr544.int.cedar.computecanada.ca:8888


ssh -L 8888:cdr544.int.cedar.computecanada.ca:8888 jlperla@cedar.computecanada.ca

## More from ComputeCanada  (for future organization)
See https://docs.computecanada.ca/wiki/Connecting_with_MobaXTerm fora  windows termianl


https://docs.computecanada.ca/wiki/Available_software

More on jupyter and ssh on computecanada:
- https://docs.computecanada.ca/wiki/Jupyter
- https://docs.computecanada.ca/wiki/SSH_tunnelling

