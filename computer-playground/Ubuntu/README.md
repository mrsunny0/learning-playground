# Computer Playground - Ubuntu

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
