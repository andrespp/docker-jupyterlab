FROM continuumio/miniconda3:23.5.2-0

# Basic packages
RUN apt-get update -q && apt-get install -y -qq vim build-essential && cd ~/ && \
 wget https://raw.githubusercontent.com/andrespp/dotfiles/master/.vimrc-basic && \
 mv .vimrc-basic .vimrc

# Timezone and locale settings
RUN rm /etc/localtime && \
    ln -s /usr/share/zoneinfo/America/Belem /etc/localtime && \
    apt-get install -y -qq locales && \
    dpkg-reconfigure -f noninteractive tzdata && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8 LC_MONETARY=pt_BR.UTF-8

# Aditional packages
RUN apt-get update -qq && \
    apt-get -y -qq install unixodbc-dev python3-psycopg2 libpq-dev

# Setup Conda Environment
ARG CONDA_ENV_NAME=jlab
COPY ./environment.yml ./
RUN conda env create -q -f environment.yml
RUN echo "source activate $CONDA_ENV_NAME" > ~/.bashrc
ENV PATH /opt/conda/envs/$CONDA_ENV_NAME/bin:$PATH

# Jupyterlab Extensions
RUN \
  pip install jupyterlab-git==0.44.0 && \
  pip install jupyterlab-github==4.0.0

WORKDIR /opt/app/data

COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["jupyterlab"]
