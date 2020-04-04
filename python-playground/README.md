# Python Playground

<!-- ----------------------------------------------------------------------- -->
<!-- Anaconda -->
<!-- ----------------------------------------------------------------------- -->
## Anaconda

### Download
_Windows_ <br>
[Download installer](https://www.anaconda.com/distribution/)

_Linux_ <br>
[Download `.sh`](https://www.anaconda.com/distribution/) and run
```bash
# as of April 2020
bash Anaconda3-2020.02-Linux-x86_64.sh

# and confirm all defaults
```

### Conda Commands
[Conda Cheatsheet](https://docs.conda.io/projects/conda/en/4.6.0/_downloads/52a95608c49671267e40c689e0bc00ca/conda-cheatsheet.pdf)
- `conda config --set auto_activate_base false` = prevent autostart of conda on the (base) env ([more info](https://stackoverflow.com/questions/54429210/how-do-i-prevent-conda-from-activating-the-base-environment-by-default))
- `conda create --name <envname> --file requirements.txt python=3` = creates python3 env with envname and packages from requirements.txt file
- `conda init` = initialize conda, put all commands to `PATH`
- `conda activate <env>` = activate env
- `conda deactivate` = deactivate env
- `conda env list` = show all installed envs
- `conda list --export >> requirements.txt` = generated requirement.txt file
- `anaconda-navigator` = GUI env and package manager

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
