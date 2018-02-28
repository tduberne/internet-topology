# Python paths
VENV_DIR = venv/
PIP = $(VENV_DIR)/bin/pip
PYTHON = $(VENV_DIR)/bin/python3
JUPYTER = $(VENV_DIR)/bin/jupyter
RUN_NOTEBOOK = $(JUPYTER) nbconvert --inplace --to notebook --execute

# Type of measurement
# See http://www.caida.org/data/internet-topology-data-kit/ for details
# Start with MIDAR only, as resulting data is smaller
TOPOLOGY=midar-iff
#TOPOLOGY=kapar-midar-iff
ARK_PATH=ark/ipv4/itdk/2016-09/

.PHONY: cleaned_data setup rm_cleaned_data

cleaned_data: data/01_interim/nodes_geo.csv data/01_interim/network_links.csv data/01_interim/nodes_AS.csv\
		data/01_interim/cliques.csv
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
	wget --recursive --no-parent http://data.caida.org/datasets/topology/$(ARK_PATH) &&\
	mv data.caida.org/datasets/topology/ark/ data/00_original/ &&\
	touch data/00_original/ark.stamp &&\
	rm data/00_original/$(ARK_PATH)/index.html* &&\
	rm -r data.caida.org/

######################################################################################
# Data munging scripts
######################################################################################

data/01_interim/nodes_geo.csv: data/00_original/ark.stamp | data/01_interim/
	bzip2 -cd data/00_original/$(ARK_PATH)/$(TOPOLOGY).nodes.geo.bz2 | awk -f awk/format_geolocation.awk > $@

data/01_interim/network_links.csv: data/00_original/ark.stamp | data/01_interim/
	bzip2 -cd data/00_original/$(ARK_PATH)/$(TOPOLOGY).links.bz2 | awk -f awk/format_links.awk > $@

data/01_interim/cliques.csv: data/00_original/ark.stamp | data/01_interim/
	bzip2 -cd data/00_original/$(ARK_PATH)/$(TOPOLOGY).links.bz2 | awk -f awk/format_cliques.awk > $@

data/01_interim/nodes_AS.csv: data/00_original/ark.stamp | data/01_interim/
	bzip2 -cd data/00_original/$(ARK_PATH)/$(TOPOLOGY).nodes.as.bz2 | awk -f awk/format_AS.awk > $@

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

