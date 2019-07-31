## Notes for using Julia on Compute Canada Clusters

### Getting an account and an SSH terminal
- Get a compute canada account https://www.computecanada.ca/research-portal/account-management/apply-for-an-account/
- If you are on windows: , get a terminal supporting ssh (either https://www.putty.org/ or https://docs.microsoft.com/en-us/windows/wsl/wsl2-install )


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
IJulia.notebook()
```
Answer `y` to any questions it asks you to install the notebook server.

When it is done, exit julia with `exit()` and then exit the ssh session.

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
jupyter notebook --no-browser --port=8889
```
It will list out a url in the output.  Copy and paste the content after the token, e.g. ` http://127.0.0.1:8889/?token=03990e819e40c063f9a754e10442030cdd1b1a06e1f21a99`

The first time you use the system, you can that token to setup a password (CHECK EXACT STEPS!)

## What other stuff is available on the cluster
At that point, it is easiest to close the ssh terminal to get those things updated.
https://docs.computecanada.ca/wiki/Available_software
