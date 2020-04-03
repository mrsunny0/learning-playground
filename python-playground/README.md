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
