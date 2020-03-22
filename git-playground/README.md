# Git Playground

## Downloading/updating
Installing and upgrading git: https://confluence.atlassian.com/bitbucketserver/installing-and-upgrading-git-776640906.html

Check git version using `git --version`. At the time of this writing, git version **>2.25**
### Linux/Ubuntu
```bash
sudo apt-get install git
```

### MacOS
Upgrading using with xcode via homebrew: https://medium.com/@katopz/how-to-upgrade-git-ff00ea12be18

```bash
# upgrade and install
brew update && brew upgrade
brew install git

# not necessary anymore, install git should do it
# brew link --force git

# in the future, this should be enough
brew update && brew upgrade
```

### Windows
Download from installer: https://gitforwindows.org/ <br>
Make sure download is at same place (by default), check using `which git`

## Sparse-checkout
##### [Documentation](https://git-scm.com/docs/git-sparse-checkout)
Requires git > 2.25

##### StackOverflow Q/A
- https://stackoverflow.com/questions/4114887/is-it-possible-to-do-a-sparse-checkout-without-checking-out-the-whole-repository

##### Example
```bash
# clone directory but without any checked out files
git clone <URL> --no-checkout <directory>
cd <directory>

 # to fetch only root files
git sparse-checkout init --cone

# etc, to list sub-folders to checkout
# they are checked out immediately after this command, no need to run git pull
git sparse-checkout set apps/my_app libs/my_lib...
```
