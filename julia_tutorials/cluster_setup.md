## Notes for using Julia on Compute Canada Clusters
NOTE: THESE NOTES WERE BEFORE FINDING https://docs.computecanada.ca/wiki/Jupyter

They should be adapted, and likely simplified.

### Getting an account and an SSH terminal
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


## More from ComputeCanada  (for future organization)
See https://docs.computecanada.ca/wiki/Connecting_with_MobaXTerm fora  windows termianl


https://docs.computecanada.ca/wiki/Available_software

More on jupyter and ssh on computecanada:
- https://docs.computecanada.ca/wiki/Jupyter
- https://docs.computecanada.ca/wiki/SSH_tunnelling
