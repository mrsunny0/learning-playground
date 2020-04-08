from .main import change_dir, generate_namedtuple_tree

# run local function and expose root tree
import os
root = generate_namedtuple_tree(os.getcwd())