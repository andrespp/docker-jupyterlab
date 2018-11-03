Docker JupyterLab
=================

# Introduction

DockerFile for [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/).

## Python libraries

This image uses [miniconda3](https://hub.docker.com/r/continuumio/miniconda3/) as the default Python distribution, and adds a few packages to it, most of which used in Data Science projects, like: numpy, pandas, matplotlib, seaborn and more.

The additional packages installed on this image are listed on the file ([`requirements.txt`](requirements.txt))

## JupyterLab Extensions

This image also includes the 3rd-party extensions listed below:

* [jupyterlab-toc](https://github.com/jupyterlab/jupyterlab-toc): a Table of Contents extension for JupyterLab
* [jupyterlab-github](https://github.com/jupyterlab/jupyterlab-github): a JupyterLab extension for accessing GitHub repositories.
* [jupyterlab-drawio](https://github.com/QuantStack/jupyterlab-drawio): a JupyterLab extension for standalone integration of drawio / mxgraph into jupyterlab.

# Quick start

## Docker Run

```bash
$ docker run --rm -v $(pwd):/opt/app/data -p 8888:8888 andrespp/jupyterlab
```

## Docker compose

* `docker-compose.yml`

```yaml
version: '3.1'

services:
  jupyterlab:
    image: andrespp/jupyterlab
    ports:
      - "8888:8888"
    volumes:
      - ./data:/opt/app/data
```

* Bring compose up

```bash
$ docker-compose up
```

# Issues

If you have any problems with or questions about this image, please contact me through a [GitHub issue](https://github.com/andrespp/docker-jupyterlab/issues).