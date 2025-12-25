# Get arguments for python version (in this case, python 3.13 image is used)
# ARG VARIANT="3.12-bullseye"
FROM mcr.microsoft.com/vscode/devcontainers/python:3.13-bullseye

# linux settings
# `-y` option is used to automatically answer yes to all prompts
RUN apt-get update && apt-get -y upgrade && apt-get install -y --no-install-recommends \
    byobu \
    aria2 \
    libcurl4-gnutls-dev \
    libssl-dev \
    libxml2-dev \
    build-essential \
    libgmp-dev \
    libmagick++-dev \
    libglpk-dev

# install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# update pip & install packages (including CWL tool)
# version update 2025-12-24
RUN pip install \
    --upgrade pip \
    jupyter==1.0.0 \
    upsetplot==0.9.0 \
    cwl_runner==1.0 \
    retry==0.9.2 \
    ipykernel==7.1.0 \
    pandas==2.3.3 \
    pyarrow==22.0.0 \
    polars==1.36.1 \
    numpy==2.4.0 \
    matplotlib==3.10.8 \
    seaborn==0.13.2 \
    scipy==1.16.3 \
    statsmodels==0.14.6 \
    urllib3==2.6.2 \
    requests==2.32.5 \
    # papermill==2.6.0 \
    goatools==1.5.2 \
    # geofetch==0.12.8 \
    # peppy==0.40.7 \
    PyYAML==6.0.3 \
    qrcode==8.2 \
    plotly==6.5.0 \
    cwltool==3.1.20251031082601 \
    cwltest==2.6.20250818005349 \
    pipx==1.8.0
    # pytximport==0.12.0
    # marimo==0.17.7

# install biotite https://www.biotite-python.org/latest/install.html
RUN pip install biotite==1.5.0

RUN pipx install benten==2021.1.5

# Jupyter Notebook settings
RUN python3 -m ipykernel install --user --name=python3
RUN jupyter notebook --generate-config

# Add TEA convert tool (2025-12-21)
RUN python3 -m pip install git+https://github.com/PickyBinders/tea.git