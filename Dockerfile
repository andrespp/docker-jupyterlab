FROM continuumio/miniconda3:4.8.2
MAINTAINER Andre Pereira andrespp@gmail.com

RUN apt-get update && \
    apt-get install -y vim build-essential libpq-dev python3-dev \
			unixodbc-dev python3-pyodbc nodejs npm && \
    apt-get clean && rm -rf /var/lib/apt/list

COPY ./requirements.txt ./

# Aditional Packages
RUN apt-get install -y  firebird-dev

RUN pip install -r requirements.txt

RUN jupyter labextension install @jupyterlab/toc && \
    jupyter labextension install @jupyterlab/github && \
    jupyter labextension install jupyterlab-drawio && \
    jupyter labextension install @jupyterlab/plotly-extension

RUN conda install -c conda-forge jupyterlab jupyterlab-git && \
	jupyter lab build

# Configure timezone and locale
RUN rm /etc/localtime && \
    ln -s /usr/share/zoneinfo/America/Belem /etc/localtime && \
    apt-get install -y locales && \
    dpkg-reconfigure -f noninteractive tzdata && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8 LC_MONETARY=pt_BR.UTF-8

WORKDIR /opt/app/data

COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["jupyterlab"]
