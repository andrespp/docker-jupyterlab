Docker JupyterLab
=================

# Introduction

DockerFile for [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/).

Curent version is 1.2.0 ([Changelog](https://jupyterlab.readthedocs.io/en/stable/getting_started/changelog.html#v1-2-0))

# Resources

## Python libraries

This image uses [miniconda3](https://hub.docker.com/r/continuumio/miniconda3/) as the default Python distribution, and adds a few packages to it, most of which used in Data Science projects, like: numpy, pandas, matplotlib, seaborn and more.

The additional packages installed on this image are listed on the file ([`requirements.txt`](https://github.com/andrespp/docker-jupyterlab/blob/master/requirements.txt))

## JupyterLab Extensions

This image also includes the 3rd-party extensions listed below:

* [jupyterlab-git](https://github.com/jupyterlab/jupyterlab-git): a JupyterLab extension for version control using Git.
* [jupyterlab-github](https://github.com/jupyterlab/jupyterlab-github): a JupyterLab extension for accessing GitHub repositories.

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

# Install

In order to run the container as if the application was installed locally, download the `jlab` script to a directory in you $PATH, for example:

```bash
$ sudo curl -fsSL https://raw.githubusercontent.com/andrespp/docker-jupyterlab/master/jlab \
       -o /usr/local/bin/jlab
$ sudo chmod +x /usr/local/bin/jlab
```

Then you'll be able to run JupyterLab in the current directory simply by calling `jlab`:

```bash
$ jlab
```

# Environment Variables

This image uses several environment variables in order to control its behavior, and some of them may be required:

| Environment variable | Default value | Note |
| -------------------- | ------------- | -----|
| KEYMAP | `default` | Available options are: `default`, `sublime`, `vim` and `emacs` |

# Issues

If you have any problems with or questions about this image, please contact me through a [GitHub issue](https://github.com/andrespp/docker-jupyterlab/issues).
