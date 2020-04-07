import os
from contextlib import contextmanager

@contextmanager
def change_dir(destination):
    cwd = os.getcwd()
    try:
        cwd = os.getcwd()
        os.chdir(destination)
        yield os.getcwd() # return newly changed directory
    finally:
        os.chdir(cwd)

file_structure = {}
with change_dir("../..") as nwd:
    # create key value pair of the name and the folder path
    file_structure = { p: os.path.join(nwd, p) for p in os.listdir(nwd)}