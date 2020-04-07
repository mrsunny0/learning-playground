# Python Playground

<!-- ----------------------------------------------------------------------- -->
<!-- Anaconda -->
<!-- ----------------------------------------------------------------------- -->
## Anaconda

### Download
![](https://pythonforundergradengineers.com/images/anaconda_download_page.png)
_Windows_ <br>
[Download installer](https://www.anaconda.com/distribution/)

_Linux_ <br>
[Download `.sh`](https://www.anaconda.com/distribution/) and run
```bash
# as of April 2020
# and confirm all defaults
bash Anaconda3-2020.02-Linux-x86_64.sh
```

### Conda Commands
[Conda Cheatsheet](https://docs.conda.io/projects/conda/en/4.6.0/_downloads/52a95608c49671267e40c689e0bc00ca/conda-cheatsheet.pdf)

_Managing Envs_
- `conda config --set auto_activate_base false` = prevent autostart of conda on the (base) env ([more info](https://stackoverflow.com/questions/54429210/how-do-i-prevent-conda-from-activating-the-base-environment-by-default))
- `conda create --name <envname> --file requirements.txt python=3` = creates python3 env with envname and packages from requirements.txt file
- `conda init` = initialize conda, put all commands to `PATH`
- `conda env list` = show all installed envs
- `conda activate <env>` = activate env
- `conda deactivate` = deactivate env

_Generating requirement files_
- `conda list --export >> requirements.txt` = generated requirement.txt file
- `conda env export --file environment.yml` = generates an environment.yml file which includes env name, channels, and packages

_GUIs_
- `jupyter lab/notebook`
- `spyder`
- `anaconda-navigator` = GUI env and package manager

### Jupyter Notebook/Lab
Install `jupyter lab` and `notebook` for jupyter notebook and lab servers. These servers can be activated on the WSL or docker containers; however, because of token and password authentication, there is some issues. To avoid these, create a jupyter config file and manually configure a password.

```bash
# generate config files (if not already present in ~)
jupyter notebook --generate-config

# manually enter password
jupyter notebook password

# start jupyter notebook/lab on new port
jupyter lab --port=8000 --no-browser
```

IP addres = 127.0.0.1:8888 is the default, and for some reason this will always request a token and password with no way to pass credentials. Therefore, open a sever on a specific port (not default), and open without a browser. As opening a browser also generates a token, for some reason. Which adds more confusion.

To show kernel information:
```bash
# much like python -m spyder_kernels.console
ipython kernel
```

### Spyder
To connect to existing Jupyter kernel, find out where kernel information is:
```bash
# outputs directory of kernels
jupyter --runtime-dir
```

In this directory, generate kernel information from the running kernel using spyder_kernels

```bash
# generates kernel information from running jupyter IP
python -m spyder_kernels.console --matplotlib="inline" --ip=127.0.0.1
```

Steps to access remote jupyter kernel opened in container or wsl. Naming convention. _HOST_=_container/wsl_, _GUEST_=_windows_
1. _HOST_: open jupyer notebook or lab
  - Run `jupyter lab --port=8000 --no-browser`
  - Find location of kernel by using command `jupyter --runtime-dir`
  - These files contain all kernel and notebook information, for all sessions (may be good to remove some occasionally)
2. _HOST_: Have `spyder-kernels` package installed. If so, run `python -m spyder_kernels.console --matplotlib="inline" --ip=127.0.0.1 -f=<dir>`
  - Assuming jupyter notebook is hosted on localhost
  - `<dir>` is by default where `jupyter --runtime-dir` shows. However, it can be easier to place `~/.remotemachine.json`
  - If no name is given, it is typically written as `kernel-<hash#>.json`
3. _HOST_->_GUEST_: move the generated kernel.json file to the guest machine.
  - With wsl, this is easy as going to the location of the kernel file in the HOST machine, and typing `explorer .` to create a file view. Simply copy and past to a convenient location
  - On containers, VM, need to ssh/ftp this to the GUEST.
  - Copy and past and make your own file on the GUEST
4. _GUEST_: Open Spyder and connect to remote kernel
  - Go to the console tab, and open "connect to an existing kernel"
  - Browse and load the copied/duplicated/created kernel.json file on the GUEST
  - Check by executing commands:
  ```python
  import sys
  print(sys.executable)
  print(sys.version)
  print(sys.version_info)
  ```

More information about spyder-kernels: https://github.com/spyder-ide/spyder-kernels, and a tutorial on using it: https://medium.com/@halmubarak/connecting-spyder-ide-to-a-remote-ipython-kernel-25a322f2b2be. Another good tutorial can be found here: https://medium.com/@mazzine.r/how-to-connect-your-spyder-ide-to-an-external-ipython-kernel-with-ssh-putty-tunnel-e1c679e44154

<!-- ----------------------------------------------------------------------- -->
<!-- Relative Imports -->
<!-- ----------------------------------------------------------------------- -->
## Relative Imports

<!-- ----------------------------------------------------------------------- -->
<!-- Makefiles -->
<!-- ----------------------------------------------------------------------- -->
## Makefiles

Comprehensive MIT course on Makefiles (1994): http://web.mit.edu/gnu/doc/html/make_toc.html#SEC19

Commands <br>
- `make -f <name>`, or `make --f==name` makes the file name specified, rather than looking for `Makefile` or `makefile`
- `make -include` = include other make files as space separated list
-

Variables <br>
- `$(wildcard *)` = expands the wildcard into a variable
- `$@`, `$^`, `$<`= target name, first dependency name, all dependencies
  ```bash
  # target : dependency; command
  $@: $^
    # echo first dependency file
    @echo $<
  ```

Directories <br>
- `VPATH = <directories>`
- `vpath %pattern directories:...`

<!-- ----------------------------------------------------------------------- -->
<!-- File Structure -->
<!-- ----------------------------------------------------------------------- -->
## File Structure

### Variable Conventions
- `_name` = private variable
- `__name` = protected variable, name gets clobbered in namespace

```python
dir()
```

### File types
- `__init__.py`
- `__name__.py`
- `pycache`

<!-- ----------------------------------------------------------------------- -->
<!-- AWS -->
<!-- ----------------------------------------------------------------------- -->
## AWS

### Configuring
_Command Line_
``` bash
# install aws cli
conda install -c source-forge --name <env> awscli

# configure
aws configure # follow prompt for account ID and secret key

# subsequent changes
aws configure set region <us-east-1>
```

_Scripting_

### Managing buckets
_Command Line_
```bash
# copying from local file to s3 bucket
# add --recursive flag to copy entire directories
aws s3 cp <file> s3://<bucket-name> --recursive

# sync (upload all files/directories from bucket)
aws s3 sync s3://<bucket-name> <dir>
```

_Scripting_

<!-- ----------------------------------------------------------------------- -->
<!-- File Structure -->
<!-- ----------------------------------------------------------------------- -->
### Linux

### Windows
install Make: http://gnuwin32.sourceforge.net/packages/make.htm (2006, but still works)

Overall GNU project: https://www.gnu.org/software/make/

Best answer on StackOverflow: https://stackoverflow.com/questions/32127524/how-to-install-and-use-make-in-windows

Wikipedia Page: https://en.wikipedia.org/wiki/GnuWin32

GNU Makefile Manual: https://www.gnu.org/software/make/manual/html_node/index.html#SEC_Contents

Get all of the GNU files: https://sourceforge.net/projects/getgnuwin32/files/

(Note, installing from http://www.mingw.org/ doesn't work for Windows 10 since the binaries won't execute (or not recognized))

add to path (windows):

introduction: https://opensource.com/article/18/8/what-how-makefile

cookie cutter example: https://github.com/drivendata/cookiecutter-data-science/blob/master/%7B%7B%20cookiecutter.repo_name%20%7D%7D/Makefile

# Creating Make files

- [ ] Find out what shell is running
 - [ ] For Windows, convert commands to standard commands, python path should be normal
 - [ ] For Linux, convert commands to Bash and find Windows python path by executing cmd.exe
    - [ ]
