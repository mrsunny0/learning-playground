# Git Playground

<!-- ----------------------------------------------------------------------- -->
<!-- Downloading/Updating -->
<!-- ----------------------------------------------------------------------- -->
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

### Windows WSL
Need to access git ppa repo for download: https://askubuntu.com/questions/1135023/how-to-install-git-on-windows-subsystem-for-linux
```bash
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git
```

<!-- ----------------------------------------------------------------------- -->
<!-- Git Commands -->
<!-- ----------------------------------------------------------------------- -->
## Git clone / pull / fetch

_Documentation_
- [Fork]()
- [Pull]()
- [Clone]()
- [Fetch]()
- [Rebase](https://git-scm.com/docs/git-rebase) ``
- [Merge](https://git-scm.com/docs/git-merge)   ``


### Pull versus fetch

_StackOverflow Q/A_
- https://stackoverflow.com/questions/292357/what-is-the-difference-between-git-pull-and-git-fetch

### When to merge versus rebase

### Forcing git pull to override local changes

_Website_
- https://www.w3docs.com/snippets/git/how-to-force-git-pull-to-override-local-files.html

_Example_
```bash
git fetch
git reset --hard origin/master

# to store or remove local changes
git stash
git stash drop

# or to bring back local changes
git stash
git stash pop
# ... git add, git commit
```

<!-- ----------------------------------------------------------------------- -->
<!-- Tracking Changes -->
<!-- ----------------------------------------------------------------------- -->
## Tracking changes

### Updating .gitignore
_StackOverflow Q/A_
- https://stackoverflow.com/questions/1274057/how-to-make-git-forget-about-a-file-that-was-tracked-but-is-now-in-gitignore

_Example_
```bash
# removing single file from cache
git rm --cached <file>
# removing entire directory from cache
git rm -r --cached <folder>
```

### Seeing which files are tracked
_StackOverflow Q/A_
- https://stackoverflow.com/questions/15606955/how-can-i-make-git-show-a-list-of-the-files-that-are-being-tracked/15606998

_Example_
```bash
# see tracked files in current directory
git ls-files

# see tracked files in branch
git ls-tree -r master --name-only

# see tracked files from current branch
git ls-tree -r HEAD --name-only
```

### Difference between rm and reset
_Documentation_
- rm: https://git-scm.com/docs/git-rm
- reset:

_StackOverflow Q/A_
- https://stackoverflow.com/questions/38001223/what-is-the-difference-between-git-rm-cached-and-git-reset-file

_Example_
```bash
# un-add all files
git reset <file>

# git rm will prevent file from tracking index (if not already in index)
git rm <file>

# git rm --cache will remove a file from tracked index, and its entire history
git rm --cache
```

### Stashing changes
_Documentation_
- stash: https://git-scm.com/docs/git-stash

_Example_
```bash
# stash files
git stash

# unstash the top-most stashed files
git stash pop
```

### Sparse-checkout
_Documentation_
 - sparse-checkout: https://git-scm.com/docs/git-sparse-checkout) <br>Requires git > 2.25

_StackOverflow Q/A_
- https://stackoverflow.com/questions/4114887/is-it-possible-to-do-a-sparse-checkout-without-checking-out-the-whole-repository
- https://stackoverflow.com/questions/35925631/git-commit-push-pull-with-sparse-checkout (useful diagram)

_Example_
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

To check which files are sparse-checkout, or update, navigate and edit
```bash
.git/info/sparse-checkout

# if needed, update head
git read-tree -m -u HEAD
```
