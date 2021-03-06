# Computer playground - Windows

<!-- ----------------------------------------------------------------------- -->
<!-- Windows Activation -->
<!-- ----------------------------------------------------------------------- -->
## Activation
Windows 10 Home comes with most PCs. However, Windows 10 Pro has the needed Hyper-V built in, as well as remote desktop and security features. Secondary applications such as Docker Desktop can only be installed on Pro.

![](https://www.velocitymicro.com/blog/wp-content/uploads/2015/07/Windows-10-Home-vs-Pro.png)

1. Go to Activation screen, `cmd+Q` "Activation". Either enter a license key or purchase one from the Micrcosoft Store.
2. Upgrades purchased through the store do not provide a license key, the license is linked to your Windows account.
3. If computer is modified or hardware changed (such as fresh restart), go to Activation and access Troubleshooter for it to link Windows account (which has the digital license) and PC.
4. Activation trouble: https://www.youtube.com/watch?v=bggRczi7ojA&t=1s, or call the Microsoft customer service at 1-877-686-7786 (they will remote desktop and activate for you). <br>
Or use Windows Default Activation codes: https://www.sysnative.com/forums/threads/using-default-generic-product-keys-to-install-windows-10.29464/ <br>
| Operating System Edition           | Default Product Key           |
|------------------------------------|-------------------------------|
| Windows 10 Home                    | YTMG3-N6DKC-DKB77-7M9GH-8HVX7 |
| **Windows 10 Pro**                 | **VK7JG-NPHTM-C97JM-9MPGT-3V66T** |
| Windows 10 Home N                  | 4CPRK-NM3K3-X6XXQ-RXX86-WXCHW |
| Windows 10 Home - Single Language  | BT79Q-G7N6G-PGBYW-4YWX6-6F4BT |
| Windows 10 Home - Country Specific | 7B6NC-V3438-TRQG7-8TCCX-H6DDY |
| Windows 10 Pro N                   | 2B87N-8KFHP-DKV6R-Y2C8J-PKCKT |
| Windows 10 Education               | YNMGQ-8RYV3-4PGQ3-C8XTP-7CFBY |

<!-- ----------------------------------------------------------------------- -->
<!-- General Use -->
<!-- ----------------------------------------------------------------------- -->
## General Use

### Window Snapping
Stop smart aerosnapping: https://botcrawl.com/when-i-snap-a-window-show-what-i-can-snap-next-to-it-windows-10/

Go to `Settings > System > Multitasking`
![](https://botcrawl.com/wp-content/uploads/2015/07/When-I-snap-a-window-show-what-I-can-snap-next-to-it-Windows-10.png)

### Check Build
Type `cmd+r` and then run `winver`
![](https://support.techsmith.com/hc/article_attachments/115002725732/2017-10-11_8-39-12.png)

### Check System Information
`cmd+Q` "System Information"
![](https://tr1.cbsistatic.com/hub/i/2017/07/19/4e87f553-d66a-4fc5-8ad4-fe867620028f/fig-c-7-17.png)

### Check Performance
`ctrl+shift+esc` (Task Manager) > Performance Tab <br>
Can also check the number of sockets, cores, processors, virtualization, etc.
![](https://cloud.addictivetips.com/wp-content/uploads/2017/08/gpu-performance-task-manager.jpg)

### Creating Symlinks
Using a GUI provided by https://schinagl.priv.at/nt/hardlinkshellext/linkshellextension.html
![](https://i.stack.imgur.com/FvPez.png)

Or using command prompt
```bash
# Link is your made-up destination; Target is the actual location
mklink Link Target

# soft link to a directory
mklink /D Link Target

# hard link to a file
mklink /H Link Target

# hard link to a directory
mklink /J Link Target
```

### Hotkeys
- `cmd + tab` = show all currente windows
- `cmd + q` = finder
- `cmd + arrows` = move window position
- `cmd + shift + left/right arrows` = move window to second monitor
- `cmd + ctrl + left/right arrows` = move to new working desktop

<!-- ----------------------------------------------------------------------- -->
<!-- Virtual Machines -->
<!-- ----------------------------------------------------------------------- -->
## VMWare
Linux Sub-system and VMWare need to access the same Hyper-V system, which breaks.
Updating VMWare, or waiting for the new Linux Sub-system release will work.
https://blogs.vmware.com/workstation/2020/01/vmware-workstation-tech-preview-20h1.html (_updated March 2020_). A useful blog post on the distinction between WSL, VMWare, and Hyper-V usage can be found here: https://win10.guru/vmware-workstation-tech-preview-20h1/

### Toggling Hyper-V Usage
Hyper-V is installed on Windows Pro, or given access to via Windows Insider Program (Fast or Slow ring). WSL and other Windows native virtual machines are Type 1 Hypervisors, whereas VMWare is a Type 2. When Type 1 is in use, Type 2 cannot be run. Therefore, WSL and VMWare cannot be runned together.

![](https://i1.wp.com/win10.guru/wp-content/uploads/2020/03/Hypervisor.png?w=402&ssl=1)

Access to Hyper-V must be disabled to give VM access to the Type 2 Hypervisors, this disables WSL.

```bash
# disabling with admin priveleges
bcdedit /set hypervisorlaunchtype off

# enabling with admin priveleges
bcdedit /set hypervisorlaunchtype auto

# need to restart
```

However, this can be avoided with new updates on VMWare in its tech preview releases.

### VMWare Tech Preview
[Download link](https://blogs.vmware.com/workstation) to 20H1 Tech Preview:

![](https://578202.smushcdn.com/777453/wp-content/uploads/2020/01/The-new-Tech-Preview-user-interface.png?lossy=1&strip=1&webp=1)

Because VMWare is virtualizing itself without Hyper-V Type 2 access, it shows a warning.

![](https://www.siberportal.org/wp-content/uploads/2016/06/downloading-and-installing-vmware-workstation-and-importing-first-virtual-machine-19.jpg)

Unfortunately, this cannot be avoided (for now), but degradation is minimized with full Hyper-V support when upgrading to Windows 10 Pro.

### Sharing Folders
Must have VMware tools installed. Watch this video on how to enable sharing: https://www.youtube.com/watch?v=K8OU6YSlhSU

1. VM -> Settings (`ctrl+D`) -> Options Tab -> Enable Shared Folders
2. Choose directory and name for shared folder
3. Folders can be found `/mnt/hgfs/<shared folder name>`
4. Make a symlink using
```bash
# has to be absolute paths to work
ln -s /mnt/hgfs/"<shared folder name>" /home/"<username>"/"<destination>"
```

Changes on the VM or the host system will effect the shared folder. Good to interact with data on the Host side, while commanding using Linux functionality on the Guest side.

**Improving sharing speed and performance** <br>
See StackOverflow Q/A: https://superuser.com/questions/1025864/how-to-speed-up-vmware-shared-folders

Go to Settings (`ctrl+D`), and look select "Network Adaptor", and switch from NAT to Bridge. Review VMWare docs on what this means: https://www.vmware.com/support/ws45/doc/network_configure_ws.html.

### Troubleshooting
Guest freezes after sleep/hibernate when in full & dual-screen mode. To avoid this conflict, `VM -> Manage -> Change Hardware Compatibility` and upgraded to the latest available version (did the clone option). https://communities.vmware.com/thread/544330

<!-- ----------------------------------------------------------------------- -->
<!-- WSL Linux Subsystem -->
<!-- ----------------------------------------------------------------------- -->
## WSL2 & Ubuntu

### Enabling WSL
https://code.visualstudio.com/remote-tutorials/wsl/enable-wsl#_check

Using Windows Feature Dialog
![](https://code.visualstudio.com/assets/remote-tutorials/wsl/windows-features.png)

Using Admin PowerShell
```bash
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

### Setting WSL Distro and Version
https://docs.microsoft.com/en-us/windows/wsl/wsl2-install

```bash
# check distro and version
wsl --list --verbose

# set distro and version
wsl --set-version <Distro> 2

# or use alias
wsl --set-default-version 2
```

[Download distros here](https://docs.microsoft.com/en-us/windows/wsl/install-manual), or go to Windows Play Store to download.


### Entering WSL
```bash
bash

# or
wsl
```

Note that because Windows is entering WSL through a terminal, the order of `source` is different. `.bash_profile` is called instead; therefore, keep all personal customizations in `.profile`, but in `.bash_profile` do:
```bash
source ~/.profile
```
To replicate the effect

<!-- ----------------------------------------------------------------------- -->
<!-- Customizing WSL-->
<!-- ----------------------------------------------------------------------- -->
## Customizing WSL (Ubuntu 18.04)

### Edit PS1
- Show git branch - https://askubuntu.com/questions/730754/how-do-i-show-the-git-branch-with-colours-in-bash-prompt
- Change color scheme - https://www.cyberciti.biz/faq/bash-shell-change-the-color-of-my-shell-prompt-under-linux-or-unix/

```bash
# Get git branch name
parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Custom green/white/gold(git)
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

# Custom green/(light)blue/red(git)
# note that [01;XXm\] controls the color scheme for the subsequent text
# 01 indicating bold, and XX indicating the color
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;94m\]\w\[\033[01;31m\] $(parse_git_branch)\[\033[00m\]\n\$ '
```

### Running Window Commands
WSL tries to convert the `$PATHS` from Windows to Unix; however, many of the commands have to be executed with `<command>.exe`, where `.exe` is required in the prompt.  

Special notes are that certain executables in the windows systems turn into .bash or .sh scripts, notably Atom. This is circumvented by calling the original command prompt arguments (assuming its in the path). Refer to StackOverflow Q/A: https://superuser.com/questions/1185214/opening-atom-in-current-directory-in-wsl, where a function. These additions can be added to the `~/.profile`

```bash
# Path variables on WSL and Win host systems
root_wsl="\\wsl$\Ubuntu-18.04\home\mrsunny" # found in windows
root_win="/mnt/c/Users/ge0rge" # found in wsl

# Create aliases
alias explorer=explorer.exe
alias notepad=/mnt/c/windows/system32/notepad.exe
alias sublime="/mnt/c/Program\ Files/Sublime\ Text\ 3/subl.exe"
atom () {
  # note that once cmd is called, all paths are relative to the win system
  # therefore ./ is appropriate to use for the current directory
  /mnt/c/Windows/System32/cmd.exe /c "atom ./$1"
}
# Note that git, nvm, conda should all be installed as WSL Linux binaries, rather than relying on the Win system
# code (Visual Studio Code) is not included, as it is run on the WSL side. It's also available through the Anaconda installation
```

### Using or Installing Anaconda (separately)
----
**NOTE THE BELOW CONTENTS DONT WORK** <br>
Note specifically for Anaconda/Conda served on the Windows side. You need to run
```bash
# initialize conda executables to be run by bash
conda init bash
```

Close the terminal, or start a new one, and now run `conda activate <env>`. From there you can run

```bash
# open navigator GUI
anaconda-navigator

# spyder IDE
spyder
```

**^NOTE THE ABOVE CONTENTS DO NOT WORK**

----

**THESE INSTRUCTIONS WORK** <br>

Although Anaconda may be installed in the Win system, reasons for installing another:
  - Binaries are now optimized for Linux, rather than running commands in WSL and using Win
  - Access to `make`, `grep`, `sed`, and `awk` in developing make files
  - Rather than hacking python `PATHS` (example: `/mnt/c/Users/ge0rg/Anaconda/envs/<name>/python.exe`)

Download
1. Go to: https://www.anaconda.com/distribution/, and install the `.sh` Linux distribution. This download can go on the Win system, such as the `Downloads` folder
2. Run WSL, go to the `Downloads` folder, which is `/mnt/c/Users/ge0rg/Downloads`, and run
```bash
# version number 5.2.0, in this case
bash Anaconda3-5.2.0-Linux-x86_64.sh
```
3. Follow instructions, and agree to all defaults
4. Allow conda to init, for this time
5. Run
```bash
# this prevents conda from activating the (base) env at startup
conda config --set auto_activate_base false
```
6. source or restart shell

Manually add base env python to PATH, as there is no default python interpreter
```bash
# in .profile
export PATH="/home/mrsunny/anaconda3/bin:$PATH"
```

### Adding Windows Git credentials
Rather than making another Git SSH Key pair, use credentials from Windows (if already created)

```bash
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-wincred.exe"
```

<!-- ----------------------------------------------------------------------- -->
<!-- Windows -->
<!-- ----------------------------------------------------------------------- -->
## Windows Development

### Docker Desktop
Docker Desktop needs Hyper-V support, which is only available for Windows 10 Pro. Install here: https://hub.docker.com/editions/community/docker-ce-desktop-windows. There is a backwards compatible Docker Toolbox: https://docs.docker.com/toolbox/toolbox_install_windows/, but is not recommended to run.

Activate Docker in the bakcground by clicking its icon: ![](https://d1q6f0aelx0por.cloudfront.net/icons/whale-x-win.png), and then run these scripts in the command prompt:
```bash
# check version, docker daemon must be already on
docker version

# run simple hello-world image
docker run hello-world
```

Running Spyder or Python scripts

### Nodejs NVM Installation
Install nvm: https://github.com/coreybutler/nvm-windows
![](https://camo.githubusercontent.com/7a297909471d50f1a8afc353ecb5a07f9eb54e83/687474703a2f2f692e696d6775722e636f6d2f424e6c636269342e706e67)

Location of nvm is
```bash
C:\Users\ge0rg\AppData\Roaming\nvm\
```

Location of accessible modules (-g)
```bash
# aliased from nvm folder specific to node version in use
C:\Program Files\nodejs
```

### Anaconda and MAKE files
Steps to help with setting data science projects and MAKE files <br>
https://towardsdatascience.com/structure-and-automated-workflow-for-a-machine-learning-project-2fa30d661c1e

Installing GNU make here: http://gnuwin32.sourceforge.net/packages/make.htm, with [instructions from StackOverflow](https://stackoverflow.com/questions/32127524/how-to-install-and-use-make-in-windows):

After installation, add a variable to the `make.exe` location to the PATH (in this case, user path is fine)
![](https://helpdeskgeek.com/wp-content/pictures/2012/09/environment-variables-dialog.png)

### Accessing UNIX commands (without WSL)
- [CASH](https://github.com/dthree/cash) <br>
  ```bash
  # get commands
  npm install cash -g

  # run to get all commands as global
  npm install cash-global -g

  # run to get specific command
  npm install cash-{command} -g

  ```
  `cash-global` is stored in `node_modules` in `C:\Program Files\nodejs` (nvm symlink to nodejs version)<br>
  ```bash
  # Run node, or npm, or cash, to find location of global executables
  which node # -> C:\Users\<username>\AppData\Roaming\nvm\<version>

  # File structure of modules
  # nvm\<version>\node_modules\
    # - cash
    # - cash-{command}
    # - cash-global
    # - .bin <- this is where cash-global compiled commands live
  ```

  Going into `node_modules` and running npm build `cash-global` puts all compiled commands into `.bin` in the `node_modules` folder. However, there is an error that package `vorpal` cannot be found for commands that intake arguments for processing (e.g. `touch [args]`). The main difference between the `.cmd` files from installing each command separately than with `cash-global` is the linkage to dependent modules
  ```bash
  # command compiled from cash-<command>
  # file currently lives in root\node_modules\bin
  "%_prog%"  "%dp0%\..\cash-global\bin\cat.js" %*

  # command compiled from cash-global
  # file lives in root
  "%_prog%"  "%dp0%\node_modules\cash\bin\cash.js" %* #
  ```

  Conclusion: `cash-global` fails to build `.cmd` files, and a bit of hacking didn't help. So far, run `npm install cash-{command} -g` for individual commands. List of commands can be [found here](https://github.com/dthree/cash/wiki/Usage-%7C-Global):
  - cat
  - cp
  - kill (not really needed)
  - ls
  - mkdir
  - mv
  - pwd
  - sort (not really needed)
  - touch
  - rm

- [Cygwin](https://www.cygwin.com/) (not recommended)
- [MinGW32](http://www.mingw.org/)
- [Github](https://desktop.github.com/)

### Windows Insider Program
Join the Windows Insider Program to install the Fast or Slow Rings: https://insider.windows.com/en-us/welcome-back/

![](https://wipwebprodcdnv2.blob.core.windows.net/wipmedia/wp-content/uploads/sites/8/2018/05/for-business-getting-started-01.png)

### Windows Terminal (preview)
Install Windows Terminal: https://github.com/microsoft/terminal
![](https://i0.wp.com/www.onmsft.com/wp-content/uploads/2019/06/Windows-Terminal-Microsoft-Promo.png?fit=1365%2C768&ssl=1)

Control profile and UI via `profiles.json` in Settings.
```JSON
# Example profile
{
    "guid": "{c6eaf9f4-32a7-5fdc-b5cf-066e8a4b1e40}",
    "hidden": false,
    "name": "Ubuntu-18.04",
    "source": "Windows.Terminal.Wsl",
    "startingDirectory": "%USERPROFILE%",
    "fontSize": 10,
    "tabTitle" : "ubuntu",
    "suppressApplicationTitle" : true,
    "useAcrylic": true,
    "acrylicOpacity" : 0.85
},
```

Change ugly background directory colors. Find a comprehensive list of changes to `LS_COLORS`: http://www.bigsoft.co.uk/blog/2008/04/11/configuring-ls_colors
```bash
# in ~/.bashrc
# folders in wsl are 'Directory that is other-writable (o+w) and not sticky'
# files in wsl are executables (?)
# first two digits indiciate font-type: 0=normal, 01=bold
# second two digits indiccate color, 32=green, 34=blue, 36=cyan, 94=light blue, 97=white
LS_COLORS="ow=01;94:ex=00;94"  
export LS_COLORS
```

Hotkeys
- `ctrl+shift+t` = create new tab
- `ctrl+shift+#` = create tab based on shell number (number in array in profile.json)
- `ctrl+shift+w` = delete pane
- `alt+shift+-` = split down (vertical)
- `alt+shift++` = split right (horizontal)

### SSH and Putty

<!-- ----------------------------------------------------------------------- -->
<!-- Performance -->
<!-- ----------------------------------------------------------------------- -->
## Performance

`cmd+Q` "storage" = "Storage settings", determine which files are stale and what applications can be uninstalled.

### Increasing WLS2 Network Performance
https://medium.com/@leandrw/speeding-up-wsl-i-o-up-than-5x-fast-saving-a-lot-of-battery-life-cpu-usage-c3537dd03c74

Disable

Windows Security > Virus & Thread Protection > Virus & Threat Protection Settings - Manage Settings > Exclusions - Add or remove exclusions > Add an exclusion - Folder 