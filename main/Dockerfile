FROM ubuntu:bionic

LABEL maintainer="Someguy123 (github.com/Someguy123)"
LABEL github="https://github.com/Someguy123/mssql-docker"
LABEL description="MSSQL ODBC Driver plus CLI tools"

RUN apt update -qy \
    && echo " +++ Installing essential base packages: curl wget locales ..." \
    && apt install -y curl wget locales \
    && apt-get clean -qy

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8

RUN echo " +++ Generating locale files to avoid issues..." \
    && sh -c "sed -i '/^#.* en_US.*/s/^# //g' /etc/locale.gen" \
    && locale-gen

RUN echo "Downloading and installing Microsoft's APT package signing key and and APT repository list..."
RUN sh -c "curl https://packages.microsoft.com/keys/microsoft.asc > /etc/apt/trusted.gpg.d/microsoft.asc"
RUN sh -c "curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list"

RUN apt update -qy \
    && echo " +++ Installing packages: msodbcsql17 mssql-tools ..." \
    && ACCEPT_EULA=Y apt install -y msodbcsql17 mssql-tools \
    && echo " +++ Installing package: unixodbc-dev ..." \
    && apt install -y unixodbc-dev \
    && echo " +++ Cleaning any leftover apt packages, then prepending /opt/mssql-tools/bin to PATH..." \
    && apt-get clean -qy

ENV PATH="/opt/mssql-tools/bin:/opt/sg-mssql/bin:${PATH}"



RUN echo && echo " +++ Thanks for using the someguy123/mssql Docker image :)" && \
    echo " +++ Microsoft SQL Server tools (MSSQL) should be installed into /opt/mssql-tools/bin" && \
    echo " +++ Copy your DSN files into /opt/sg-mssql/dsns using the placeholder 'MS_DRIVER' within the 'Driver =' setting." && \
    echo " +++ Run 'install_dsns' (available in the PATH) to install all DSN files in /opt/sg-mssql/dsns with automatic placeholder replacement" && \
    echo

COPY extra /opt/sg-mssql

CMD "/opt/sg-mssql/entry.sh"


