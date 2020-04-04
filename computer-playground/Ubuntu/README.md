# Computer Playground - Ubuntu

<!-- ----------------------------------------------------------------------- -->
<!-- Installation -->
<!-- ----------------------------------------------------------------------- -->
## Downloading Image
https://ubuntu.com/download/desktop
- [x] 2 GHz dual core processor or better
- [x] 4 GB system memory
- [x] 25 GB of free hard drive space
- [x] Either a DVD drive or a USB port for the installer media
- [x] Internet access is helpful

<!-- ----------------------------------------------------------------------- -->
<!-- Customizing -->
<!-- ----------------------------------------------------------------------- -->
## Customizations

### Installing terminator
![](https://4.bp.blogspot.com/-kaRacC5Jdo8/UJUg-gTG7kI/AAAAAAAABBw/iYiRnZ0t8vA/s1600/Screenshot%2Bat%2B2012-11-03%2B19%253A08%253A57.png)
```bash
sudo apt-get update
sudo apt-get install terminator
```

### Adding git branch on command line
Adding git branch name to command line:
https://askubuntu.com/questions/730754/how-do-i-show-the-git-branch-with-colours-in-bash-prompt

```bash
# Show git branch name
force_color_prompt=yes
color_prompt=yes
parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
if [ "$color_prompt" = yes ]; then
 PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\$ '
else
 PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\$ '
fi
unset color_prompt force_color_prompt
```

Minor customization
- add a space before `$(parse_git_branch)` to separate the pathname from gitname
- add a new line `\n` before `\$` at the end of the script to put the user input on a new line

### Installing NVM
https://www.cyberithub.com/install-nvm-for-node-js/
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
# output should appear that ~/.bashrc was modified

# restart bash
nvm install <version>
```

### Installing Anaconda
Install website: https://www.anaconda.com/
```bash
# when downloaded, must run bash script
bash Anaconda3-2020.02-Linux-x86_64.sh
```

Removing conda (base)
```bash
# removing (base) from terminal, do not allow conda to init at beginning
conda config --set auto_activate_base false
```

Activating and deactivating environments
```bash
# to activate base
conda activate # no args

# to activate another env
conda activate env

# to deactivate
conda deactivate
```

### Changing PATH variables
Typically modify `~/.bashrc` to create aliases or bash scripts. More detailed explanation of how `$PATH` are made can be read here: https://stackoverflow.com/questions/37676849/where-is-path-variable-set-in-ubuntu

### Creating a .bash_profile
Create a separate file called ~/.bash_profile (in home folder), and place all modifications (e.g. NVM, Anaconda PATHs, PS1 and LS_COLORS changes, aliases, etc.)

<!-- ----------------------------------------------------------------------- -->
<!-- Commands and Variables -->
<!-- ----------------------------------------------------------------------- -->
## Commands and Variables

### Variables
- `''` single quotes escape all characters <br>
  `""` double quotes escape all exepct for `$` expansion <br>
  `\` alternatively, use literal escape character
- `$` expands a variable
- `CDPATH=:...` = customizes `cd` search tree, anything after `:` will be searched even if not in the current folder
- `SHELL` = which shell is run
- `BASH`
- `TERM`

### Commands
- `echo $<NAME>` = `$` expands the variable and echoes it to screen
- `which` = find location of executed command
- `whereis` = find all searched paths that correspond to the command
- `printenv` = prints all environment variables
- `ls`
  - `-F` adds `/` or `*` for directories or executables
  - `l` long format
  - `a` all content (i.e. timestamps, etc.)
- `find`
  - `-f` searches for files
  - `-d` searches for directories

<!-- ----------------------------------------------------------------------- -->
<!-- Workspace -->
<!-- ----------------------------------------------------------------------- -->
## Managing Workspaces
Allow sidebars to show <br>
https://askubuntu.com/questions/966841/ubuntu-17-10-secondary-display-issue-missing-menubar-launcher-and-bar-on-top-o

![](https://i.stack.imgur.com/v8FN1.png)

### Simultaneous Workspace Management
All monitor workspaces change simultaneously <br>
https://askubuntu.com/questions/1059479/dual-monitor-workspaces-in-ubuntu-18-04

```bash
gsettings set org.gnome.mutter workspaces-only-on-primary false
```

### Isolating Workspaces
Having apps on sidebar be specific per workspace <br>
https://askubuntu.com/questions/305962/setting-to-only-show-applications-of-current-workspace-in-launcher

Install [dconf-editor](https://wiki.gnome.org/Projects/dconf)
```bash
sudo apt install dconf-editor
```

![](https://i.stack.imgur.com/QmyDh.png)

<!-- ----------------------------------------------------------------------- -->
<!-- Performance -->
<!-- ----------------------------------------------------------------------- -->
## Performance

### Accelerating Chrome
Go to chrome and search for: `chrome://settings/?search=hardware`
- Turn off hardware acceleration
- Also, turn off background applications

![](https://i.stack.imgur.com/1eCDf.jpg)

**NOTE:** Firefox may be faster on Linux than Chrome, vice-versa for Windows

### Install VMWare Tools
Need to uninstall existing open-vm-tools

```bash
sudo apt-get purge --auto-remove open-vm-tools
```

Then install vmware-tools: https://docs.vmware.com/en/VMware-Workstation-Player-for-Windows/15.0/com.vmware.player.win.using.doc/GUID-08BB9465-D40A-4E16-9E15-8C016CC8166F.html

```bash
#1 - Go to VM -> install VMWare Tools

#2 - Mount Disk, or it should be present on the Desktop, otherwise, type
mount

#3 - Open Terminal
cd /tmp
tar zxpf /[mount-location]/VMwareTools-x.x.x-yyyy.tar.gz

#4 - Run the installer
cd vmware-tools-distrib
sudo ./vmware-install.pl
```

### Host/Guest Hacks
- Run full screen mode
- Dismount CDRom
- Defragment computer: C:\, right-click 'Properties' > 'Tools Tab' > 'Defragment'
- Disable Windows Visual Effect (not recommended)
  Control Panel > System > Advanced Tab > Performance Settings > Adjust for best performance

### Test Performance
Testing performance of VM: https://askubuntu.com/questions/110744/how-do-i-measure-performance-of-a-virtual-server

```bash
wget https://github.com/kdlucas/byte-unixbench/archive/master.zip
unzip ./master.zip
cd ./byte-unixbench-master/UnixBench
./Run
```
Anecdotal metrics
> Which means that the VPS in question has a score of **249.7** for single task and **592.5** for parallel processing.
> My desktop machine, while having similar or lower specs to the physical machine my VPS is running on, produced a score of **1409.7** for single task and **5156.3** for parallel processing. Exactly the kind of metric I was looking for.

| Date            | Single | Dual  | Comments                |
|-----------------|--------|-------|-------------------------|
| April 1st, 2020 |        | >1500 | Base                    |
| April 1st, 2020 |        | 897.3 | Installed VMWare Tools  |
| April 4th, 2020 | 690.4  | 1632  | Upgraded to Windows Pro |
