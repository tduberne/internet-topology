Network Analysis of Internet Topology
==============================================

This repository contains code to analyse data from the
Macroscopic Internet Topology Data Kit (ITDK)
<http://www.caida.org/data/internet-topology-data-kit/>.
It uses the data from September 2016.

The data is downloaded automatically the first time `make`
is called.
This takes quite a while, and is thus better done overnight.

Structure
=========

The structure is inspired by the [cookiecutter](https://drivendata.github.io/cookiecutter-data-science/)
project for data science.

Data is organized in 3 directories:

- `data/00_original`, containing data as it was downloaded from original sources
- `data/01_interim`, containing transformations of the datasets that are more convenient for analysis
- `data/02_final`, containing final outputs, if any

Python code is separated in two directories:

- `python/`, that contains the python "library" files
- `notebooks/`, containing Jupyter notebooks. Output is stripped using nbstripout,
	which needs to be installed (<https://github.com/kynan/nbstripout>)

Code in other languages is in additional directories.
For instance, the `awk/` directory contains a few awk scripts
that massage the raw data in a more convenient form before even thinking in
using python.

In case anything interesting comes out,
there could also be additional directories,
for instance containing "final" notebooks (where output would not be stripped
before commit).

The whole pipeline is configured through a Makefile.
Simply typing `make` should run the whole process.

Dependencies
============

The project depends on the `cartopy` python package for geographic visualization.
This project has a few non-python dependencies that have to be installed by hand,
see <http://scitools.org.uk/cartopy/docs/latest/installing.html#installing>.

On a Debian Stretch system, the following made it go through:

```
sudo apt-get install libproj-dev libgeos++-dev
```
