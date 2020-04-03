#################################################################################
# GLOBALS                                                                       #
#################################################################################
# PROJECT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
# BUCKET = {{ cookiecutter.s3_bucket }}
# PROFILE = {{ cookiecutter.aws_profile }}
# PROJECT_NAME = {{ cookiecutter.repo_name }}
# PYTHON_INTERPRETER = {{ cookiecutter.python_interpreter }}


# ifeq (,$(shell where conda))
# HAS_CONDA=False
# else
# HAS_CONDA=True
# endif

# $(shell dirname $(realpath))
# ,$(shell where conda)

# .DEFAULT_GOAL

# content := $(shell which cmd.exe)
# activate := $(shell ${content} /c activate work3)
# cmd := ${content} /c where python
# paths := $(shell ${cmd})

content := $(shell where cmd.exe)

#################################################################################
# GOALS                                        
#################################################################################
# all: step1 step2  #step3

#################################################################################
# Commands                                                                      #
#################################################################################
step1: 
	@echo ${PWD}
	@echo ${content}
	@echo ${SHELL}
# 	@echo ${content}
# 	@echo ${cmd}
# 	@echo ${paths}
# 	@echo ${activate}

step2: 
# 	python file2.py

step3:
	python file3.py

#################################################################################
# PROJECT RULES                                                                 #
#################################################################################
.PHONY: clean help

clean: 
	@echo "WHA"
	@echo $(HAS_CONDA)

help:
	@echo "HELLO"