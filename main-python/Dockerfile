FROM someguy123/mssql:bionic

ARG PY_VER="python3.7"
ARG PY_PKGS="pyodbc ctds pipenv"
LABEL maintainer="Someguy123 (github.com/Someguy123)"
LABEL github="https://github.com/Someguy123/mssql-docker"
LABEL description="MSSQL ODBC Driver, CLI tools, plus pyodbc and ctds python libraries"

RUN echo " >>> Installing FreeTDS MSSQL package (for cTDS python package and other libraries that may depend on it)" \
    && apt update -qy \
    && apt install -y freetds-dev \
    && apt-get clean -qy

RUN echo " >>> Installing system python packages: python3, python3-dev, python3-venv, python3-venv" \
    && apt update -qy \
    && apt install -y python3 python3-dev python3-venv python3-pip \
    && apt-get clean -qy

ENV PY_VER ${PY_VER}

RUN echo " >>> Installing Python '${PY_VER}' plus dev headers" \
    && apt update -qy \
    && apt install -y ${PY_VER} ${PY_VER}-dev \
    && apt-get clean -qy

ENV PY_PKGS ${PY_PKGS}
# Upgrade the systemwide pip3, and ensure 'wheel' is installed, to avoid issues building certain packages.
# Then install the requested packages for the system python version.
RUN echo " >>> Ensuring systemwide 'wheel' is installed..." \
    && pip3 install wheel \
    && echo " >>> Installing systemwide pip3 packages: ${PY_PKGS}" \
    && pip3 install ${PY_PKGS}


# Now upgrade pip for the python version we actually want, and install the packages
RUN echo " >>> Ensuring ${PY_VER} 'wheel' is installed..." \
    && ${PY_VER} -m pip install wheel \
    && echo " >>> Installing ${PY_VER} pip3 packages: ${PY_PKGS}" \
    && ${PY_VER} -m pip install ${PY_PKGS}



