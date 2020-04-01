# Computer Playground - Ubuntu

## Downloading image
https://ubuntu.com/download/desktop
- [x] 2 GHz dual core processor or better
- [x] 4 GB system memory
- [ ] 25 GB of free hard drive space
- [ ] Either a DVD drive or a USB port for the installer media
- [x] Internet access is helpful

## Installing terminator
![](https://4.bp.blogspot.com/-kaRacC5Jdo8/UJUg-gTG7kI/AAAAAAAABBw/iYiRnZ0t8vA/s1600/Screenshot%2Bat%2B2012-11-03%2B19%253A08%253A57.png)
```bash
sudo apt-get update
sudo apt-get install terminator
```

## Adding git branch on command line
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

## Dual Screen

### Allow sidebars to Show
_StackOverflow Q/A_
- https://askubuntu.com/questions/966841/ubuntu-17-10-secondary-display-issue-missing-menubar-launcher-and-bar-on-top-o

![](https://i.stack.imgur.com/v8FN1.png)

### Allow both desktops to move between workspaces
_StackOverflow Q/A_
- https://askubuntu.com/questions/1059479/dual-monitor-workspaces-in-ubuntu-18-04

```bash
gsettings set org.gnome.mutter workspaces-only-on-primary false
```

### Isolating workspaces (so no duplicate apps on sidebar)
_StackOverflow Q/A_
- https://askubuntu.com/questions/305962/setting-to-only-show-applications-of-current-workspace-in-launcher

Install dconf-editor
```bash
sudo apt install dconf-editor
```

![](https://i.stack.imgur.com/QmyDh.png)

## Installing Anaconda

Install website: https://www.anaconda.com/
```bash
# when downloaded, must run bash script
bash Anaconda3-2020.02-Linux-x86_64.sh
```

Removing conda (base)
```bash
# removing (base) from terminal, do not allow conda to init at beginning
conda config --set auto_activate_base false

# to activate base
conda activate # no args

# to activate another env
conda activate env

# to deactivate
conda deactivate
```

## Accelerating Chrome
_StackOverflow Q/A_
- https://askubuntu.com/questions/712504/chrome-running-slow

Go to chrome and search for: `chrome://settings/?search=hardware`
- Turn off hardware acceleration
- Also, turn off background applications

![](https://i.stack.imgur.com/1eCDf.jpg)

**NOTE:** Firefox may be faster on Linux than Chrome, vice-versa for Windows
