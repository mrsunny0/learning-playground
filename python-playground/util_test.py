#%%
import os

from utils import change_dir
from utils import file_structure

#%%
with change_dir("imports") as nwd:
    print(nwd)
    print(os.listdir())

#%%
print(file_structure)