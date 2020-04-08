#%%
import os
import re
from contextlib import contextmanager
from collections import namedtuple

#%%
@contextmanager
def change_dir(destination):
    cwd = os.getcwd()
    try:
        cwd = os.getcwd()
        os.chdir(destination)
        yield os.getcwd() # return newly changed directory
    finally:
        os.chdir(cwd)

#%%
file_structure = {}
with change_dir("../..") as nwd:
    # create key value pair of the name and the folder path
    file_structure = { p: os.path.join(nwd, p) for p in os.listdir(nwd)}

#%%
def return_dirs(directory):
    with change_dir(directory) as nwd:
        # d = filter(os.path.isdir, os.listdir(os.getcwd()))
        sub = [ d for d in os.listdir(nwd) if os.path.isdir(d) and (d[0] != "." and d[0] != "_")]
        sub_dir = [os.path.join(nwd, s) for s in sub]

    # return both name and full path
    return sub, sub_dir

def filter_name(filename):
    return re.sub(r'[-.]', "", filename)

#%%
def generate_namedtuple_tree(d="."):
    # need to extract basename
    # all subsequent recursive calls will have a full path name
    # initial case is when searching for the root path, which contains a . qualifier
    root_dir = d
    root = os.path.basename(d) if "." not in d else "root"

    # get child dirs and full paths
    # note that sub is folder name only, sub_dir is full path
    sub, sub_dir = return_dirs(root_dir)

    # for namedtuple to work, need to remove special characters
    root = filter_name(root)
    sub = [filter_name(s) for s in sub]

    # recrusively search through sub_dir (full path)
    # generate child namedtuples by calling generate_namedtuple_tree 
    # as the argument for creating the namedtuple ntuple
    # namedtuple generation should just contain basename paths
    if sub:
        ntuple = namedtuple(root, sub + ["path"])
        return ntuple(*[generate_namedtuple_tree(s) for s in sub_dir], root_dir)   

    # break point is when there are no more subdirs
    # this indicates a leaf node (no subdirs), 
    # then the only folder to consider is the root (context dependent)
    else:
        ntuple = namedtuple(root, "path")
        return ntuple(root_dir)

#%%
if __name__ == "__main__":
    root = generate_namedtuple_tree("./test_file_tree")
    print(root)