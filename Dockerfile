FROM continuumio/miniconda3
MAINTAINER Andre Pereira andrespp@gmail.com

RUN apt-get update && \
    apt-get install -y vim build-essential && \
    apt-get clean && rm -rf /var/lib/apt/list

COPY ./requirements.txt ./

RUN conda install -c conda-forge --yes --file requirements.txt

#RUN jupyter labextension install @jupyterlab/git --debug
RUN cd && \
    git clone https://github.com/jupyterlab/jupyterlab-git.git && \
    cd jupyterlab-git && \
    npm install && \
    npm run build && \
    jupyter labextension link . && \
    npm run build && \
    pip install . && \
    jupyter serverextension enable --py jupyterlab_git
    # rm -rf jupyterlab-git

WORKDIR /opt/app/data

COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["jupyterlab"]
