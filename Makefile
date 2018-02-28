# Python paths
VENV_DIR = venv/
PIP = $(VENV_DIR)/bin/pip
PYTHON = $(VENV_DIR)/bin/python3
JUPYTER = $(VENV_DIR)/bin/jupyter
RUN_NOTEBOOK = $(JUPYTER) nbconvert --inplace --to notebook --execute

.PHONY: cleaned_data setup rm_cleaned_data

cleaned_data: data/00_original/flabase-json/.stamp
	echo all cleaned data was made

######################################################################################
# Setup environment
######################################################################################

targets/venv: | targets/
	virtualenv -p python3.5 $(VENV_DIR)
	touch targets/venv
	
setup: FORCE
	venv/bin/pip install -r requirements.txt
	venv/bin/pip install -e python/

rm_cleaned_data:
	rm data/01_cleaned/*

requirements.txt: FORCE
	$(PIP) freeze | grep -v '^-e ' > requirements.txt

######################################################################################
# Get 'raw' data
######################################################################################

# Download ark data. This takes a while, so it is a good idea to let this run overnight!
data/00_original/ark.stamp: | data/00_original/
	wget --recursive --no-parent http://data.caida.org/datasets/topology/ark/ipv4/itdk/2016-09/ &&\
	mv data.caida.org/datasets/topology/ark/ data/00_original/ &&\
	touch data/00_original/ark.stamp &&\
	rm -r data.caida.org/

######################################################################################
# Data munging scripts
######################################################################################


######################################################################################
# Data munging notebooks
#
# The idea here is that I use notebooks anyway to design the munging, so why convert to
# a script? I can see pros and cons to both approaches, so let's see how this plays out.
######################################################################################


######################################################################################
# Analysis scripts
######################################################################################


######################################################################################
# Analysis notebooks
######################################################################################


######################################################################################
# Technical
######################################################################################
FORCE:

targets/:
	mkdir $@

logs/:
	mkdir $@

data/:
	mkdir $@

data/00_original/: | data/
	mkdir $@

data/01_interim/: | data/
	mkdir $@

