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

### Conda Commands - [Cheatsheet](https://docs.conda.io/projects/conda/en/4.6.0/_downloads/52a95608c49671267e40c689e0bc00ca/conda-cheatsheet.pdf)

_Managing Envs_
- `conda config --set auto_activate_base false` = prevent autostart of conda on the (base) env ([more info](https://stackoverflow.com/questions/54429210/how-do-i-prevent-conda-from-activating-the-base-environment-by-default))
- `conda create --name <envname> --file requirements.txt python=3` = creates python3 env with envname and packages from requirements.txt file
- `conda init` = initialize conda, put all commands to `PATH`
- `conda env list` = show all installed 
envs
- `conda activate <env>` = activate env
- `conda deactivate` = deactivate env

_Generating requirement files_
- `conda list --export >> requirements.txt` = generated requirement.txt file
- `conda env export --file environment.yml` = generates an environment.yml file which includes env name, channels, and packages

_GUIs_
- `jupyter lab/notebook`
- `spyder`
- `anaconda-navigator` = GUI env and package manager

<!-- ----------------------------------------------------------------------- -->
<!-- Anaconda -->
<!-- ----------------------------------------------------------------------- -->
## Python Editors

###  Jupyter Notebook/Lab
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

### VSCode
_Nit-picky edits_ <br>
Access to setting changes `ctrl+shift+p` "settings".
- VSCode terminal runs ~/.bash_profile when logging in (discussion [here](https://github.com/Microsoft/vscode/issues/20265)) <br>
  `terminal.integrated.shellArgs.linux = [-l]`
  Note: when entering via the VSCode settings, this should just be `-l` with no quotes or brackets.
- Removing "run cell". This turns out to be removed by default in newer VSCode versions.
- Hide Open Editor Pane view <br>
  `"explorer.openEditors.visible" = 0`
- Double click folders to toggle expansion, rather than single click <br>
  `"workbench.list.openMode" = "doubleClick"`
- Change terminal font size <br>
  `"terminal.integrated.fontSize" = 12`
- Change linting to use Jedi settings, this prevents vscode bugs from giving warnings <br>
  `"python.jediEnabled" = true`

_Plugins/Extensions_
- [Python Extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python) (offered by Microsoft)
- [Anaconda Extension](https://docs.anaconda.com/anaconda/user-guide/tasks/integration/vscode/)
- [Remote WSL](https://code.visualstudio.com/docs/remote/wsl) (should already be installed)
- [Docker](https://code.visualstudio.com/docs/containers/overview)
- [Markdown Preview](https://code.visualstudio.com/docs/languages/markdown)
- [Markdown Github Preview](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-preview-github-styles) or this [other version](https://marketplace.visualstudio.com/items?itemName=bierner.github-markdown-preview&ssr=false#overview)
- [Changing themes](https://code.visualstudio.com/docs/getstarted/themes), per language
  - [VSCode Icons](https://marketplace.visualstudio.com/items?itemName=vscode-icons-team.vscode-icons) 
  - [Atom Theme](https://marketplace.visualstudio.com/items?itemName=akamud.vscode-theme-onedark)
- [Neuron](https://marketplace.visualstudio.com/items?itemName=neuron.neuron-IPE), custom Jupyter notebook theme and format. <br>
  Note: need to conda install jupyter package into current env before installing Neuron.
  - Because Neuron and IPE need to install on the root path, there is a conflict with conda env, since it needs Jupyter. Alternative is the fork [VSNotebooks](https://marketplace.visualstudio.com/items?itemName=pavan.VSNotebooks) ([Github Repo](https://github.com/pavanagrawal123/VSNotebooks)

_Hotkeys_ <br>
https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf

- `ctrl+J` = toggle terminal
- `ctrl+#` = switch to numbered pane (or create it)
- `ctrl+alt+left/right` = move current tab to another pane
- `ctrl+tab` = move to most recent file
- `ctrl+page up/down` = move to next tab in window <br>
  to change these features, check out: https://stackoverflow.com/questions/38957302/is-there-a-quick-change-tabs-function-in-visual-studio-code

_Managing Workspaces_
- Moving panel positions, using command options in settings, or simply right click a panel and choose an option to move left/right/up/down.
  `"workbench.panel.defaultLocation": "right"` <br>

_Working with Jupyter Notebooks_
- `shift+enter` = run cell
- external plot viewer

<!-- ----------------------------------------------------------------------- -->
<!-- Working with Containers -->
<!-- ----------------------------------------------------------------------- -->
## Working with Containers

<!-- ----------------------------------------------------------------------- -->
<!-- Makefiles -->
<!-- ----------------------------------------------------------------------- -->
## Makefiles

Comprehensive MIT course on Makefiles (1994): http://web.mit.edu/gnu/doc/html/make_toc.html#SEC19. There is a GnuWin32 Make download for windows, which can be installed here: http://gnuwin32.sourceforge.net/packages/make.htm. However, given WSL2 and containers, scripts can be run on Windows and make files handled at the terminal of the container.

_Commands_ <br>
- `make -f <name>`, or `make --f==name` makes the file name specified, rather than looking for `Makefile` or `makefile`
- `make -include` = include other make files as space separated list

_Variables_ <br>
- `$(wildcard *)` = expands the wildcard into a variable
- `$@`, `$^`, `$<`= target name, first dependency name, all dependencies
  ```bash
  # target : dependency; command
  $@: $^
    # echo first dependency file
    @echo $<
  ```

_Directories_ <br>
- `VPATH = <directories>`
- `vpath %pattern directories:...`

Examples <br>
https://github.com/drivendata/cookiecutter-data-science/blob/master/%7B%7B%20cookiecutter.repo_name%20%7D%7D/Makefile

<!-- ----------------------------------------------------------------------- -->
<!-- Python Tips -->
<!-- ----------------------------------------------------------------------- -->
## Python Tips

### Variable Conventions
_Naming_
- Classes are capitalized - `ClassExample`
- Variables are underscored - `this_is_a_variable`
- `_name` = private variable
- `__name` = protected variable, name gets clobbered in namespace

_Special Types_
- `__init__.py`
- `__name__.py`
- `__pycache__`

_Built in Commands_
- `dir()` - shows dictionaries of fields/methods of the object
- `type()`

### Relative Imports
In Python >3.6 relative imports do not need `__init__.py`, but they are necessary to perform more advanced imports.

You can declare variables in `__init__.py` and they will be exposed to the imported module. Not that the current directory is the directory of the module that imported it

Variables can be added in the `__init__.py` to expose specific run-times of module functions.

Note, the current directory is the directory of the file that is importing the module. Imagine the module package being run in the current file.

### Context Managers
Context managers use the `with` command to isolate particular environments with a setup and teardown method. See here: https://docs.python.org/3/library/contextlib.html#contextlib.contextmanager

```python
import os
from contextlib import contextmanager

@contextmanager
def change_dir(destination):
    cwd = os.getcwd()
    # set up
    try:
        cwd = os.getcwd()
        nwd = os.chdir(destination)
        yield os.getcwd()
    # break down
    finally:
        os.chdir(cwd)

with change_dir(destination) as nwd:
  # changed directory to distination
  # and yeiled the new working directory as nwd 

```

### Decorators

<!-- ----------------------------------------------------------------------- -->
<!-- AWS -->
<!-- ----------------------------------------------------------------------- -->
## AWS

### Configuring Credentials
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
```python
import boto3
client = boto3.client(
  's3',
  aws_access_key_id=ACCESS_KEY,
  aws_secret_access_key=SECRET_KEY,
  aws_session_token=SESSION_TOKEN,
)

# Or via the Session
session = boto3.Session(
  # credentials should not be hard-coded, if possible  
  aws_access_key_id=ACCESS_KEY,
  aws_secret_access_key=SECRET_KEY,
  aws_session_token=SESSION_TOKEN,
)
```

### Managing S3 Buckets
- Documentation: https://docs.aws.amazon.com/cli/latest/reference/s3/
- Examples: https://boto3.amazonaws.com/v1/documentation/api/latest/guide/s3-examples.html

_Command Line_ <br>
```bash
# copying from local file to s3 bucket
# add --recursive flag to copy entire directories
aws s3 cp <file> s3://<bucket-name> --recursive

# download a file by switching arguments
aws s3 cp s3://<bucket-name>/<file> <file>

# sync (upload all files/directories from bucket to dir)
# can go both ways, from <src> to <dst>
# download all files from bucket to dir
aws s3 sync s3://<bucket-name> <dir>

# upload all files from dir to bucket
aws s3 sync <dir> s3://<bucket-name> 
```

_Scripting_ <br>
When to use `client` or `resource`
https://stackoverflow.com/questions/39272744/when-to-use-a-boto3-client-and-when-to-use-a-boto3-resource/39273710
- `resource` is a high-level API call that wraps around `client`
- `client` low-level API calls are all dictionaries
- `resource` may not have all the functionality of `client`, if needed, `resource` can call `resource.meta.client`

- Getting buckets
  ```python
  import boto3
  import os
  bucket_name = 'nx-playground'

  #%% Viewing buckets
  s3 = boto3.resource('s3')
  buckets = s3.buckets.all()

  # or 
  buckets = s3.buckets.limit(10)

  # getting a specific bucket
  bucket = s3.Bucket(bucket_name)
  ``` 

- Filtering through objects
  ```python
  # viewing all files in bucket
  for f in bucket.objects.all():
      print(f)

  # filtering through bucket
  # using resource
  prefix = "file"
  for obj in bucket.objects.filter(Prefix=prefix):
      print(obj)

  # using client, note that Prefix can be a subfolder name
  # returns dictionary of key/content and metadata
  s3_client = boto3.client('s3')
  filter_result = s3_client.list_objects(Bucket=bucket_name, Prefix=prefix)
  contents = filter_result['Contents'] 
  for c in contents:
      print(c['Key'])
  ```

- Downloading objects
  ```python
  # using meta client
  s3.meta.client.download_file(bucket_name, 'helloworld.txt', 'tmp-meta.txt')

  # using client directly
  s3_client.download_file(bucket_name, 'helloworld.txt', 'tmp-client.txt')

  # using download_file from Bucket
  bucket.download_file("helloworld.txt", "tmp-Bucket.txt")
  ```

- Uploading objects
  ```python
  # create an s3 object via resource and put
  # or use client meta to upload_file
  contents = b'New file upload - from resource'
  new_object = s3.Object(bucket_name, "tmp/file_upload_resource.txt")
  new_object.put(Body=contents)

  s3.meta.client.upload_file(Filename=os.path.join(os.getcwd(), "main.py"),
      Bucket=bucket_name,
      Key='tmp/file_upload_resource-upload.txt')

  # create an s3 object using client
  # either upload_file or put_object
  # upload_file will handle multipart uploads, put_object will send an entire body
  # upload_file takes from an existing file on the OS
  contents = b'New file upload - from client'
  s3_client.put_object(Body=contents, 
      Bucket=bucket_name, 
      Key='tmp/file_upload_client.txt')

  s3_client.upload_file(Filename=os.path.join(os.getcwd(), "main.py"),
      Bucket=bucket_name,
      Key='tmp/file_upload_client-upload.txt')
  ```

### Lambdas
_Setting Up_ <br>
Accepting incoming requests: https://docs.aws.amazon.com/pinpoint/latest/developerguide/tutorials-importing-data-lambda-function-process-incoming.html

```python
import json

def lambda_handler(event, context):
    
    # capture request payload, event is type dict    
    request = json.dumps(event)
    
    # echo
    # convert body to dict/json, not string
    return {
        'statusCode': 200,
        'body': json.loads(request)
    }
```

_Command Line_
```bash
aws lambda invoke \
    --function-name my-function \
    --payload '{ "foo": "bar" }' \
    response.json
```

_Scripting_
```python
import boto3

# create lambda client
client = boto3.client('lambda')

# invoke and provide a payload as a formatted string
response = client.invoke(
    FunctionName = "nx-test-function",
    Payload = json.dumps({
        "hello": "world"
    })
)

# read in response as a json/dict
json_response = json.loads(response['Payload'].read())
print(json_response['body'])
```

[_Creating layers_](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html ): 
- Layer nomenclature is name then version (1, 2, ...)
- Currently for Python 3.7, there is an aws created numpy/scipy layer.
- To create custom layer compatible with aws lambda env, use Docker

### Cloud Watch
_Setting Up_
Monitor CloudWatch here: https://console.aws.amazon.com/cloudwatch/ <br>
Go to Logs (left hand tabs) to see calls > Log Groups

_Command Line_
```bash
```

<!-- ----------------------------------------------------------------------- -->
<!-- Misc Resources -->
<!-- ----------------------------------------------------------------------- -->
