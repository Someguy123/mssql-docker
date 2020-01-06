```
+===================================================+
|                 © 2020 Someguy123                 |
|           https://github.com/Someguy123           |
+===================================================+
|                                                   |
|        MSSQL Docker Images                        |
|        License: X11/MIT                           |
|                                                   |
|        Core Developer(s):                         |
|                                                   |
|          (+)  Chris (@someguy123) [Privex]        |
|                                                   |
+===================================================+

Microsoft SQL (MSSQL) Docker Images
Copyright (c) 2020    Someguy123 ( https://github.com/Someguy123 )
```

This repository contains the source `Dockerfile`'s for the Docker Hub binary images `someguy123/mssql`.

The docker images ease the pain of dealing with Microsoft SQL Server on Linux (as well as on other OS's which have Docker support),
with the main image containing just the ODBC driver + tools, and Python tags which additionally contain various Python ODBC / MSSQL
packages for developing Python apps that need to interact with MSSQL servers.

Docker Image Tags (available on Docker Hub - including via `docker run`)

 - `someguy123/mssql:bionic` - Ubuntu 18.04 with Microsoft SQL Server ODBC Driver + Tools (`sqlcmd` and `bcp`)
 - `someguy123/mssql:bionic-python37` - Same as `:bionic` but with Python 3.7, `pipenv`, `pyodbc` library, `ctds` library, and `freetds` package
 - `someguy123/mssql:bionic-python38` - Same as `:bionic` but with Python 3.8, `pipenv`, `pyodbc` library, `ctds` library, and `freetds` package
 - `someguy123/mssql` - Alias for `someguy123/mssql:bionic`
 - `someguy123/mssql:python37` - Alias for `someguy123/mssql:bionic-python37`
 - `someguy123/mssql:python38` - Alias for `someguy123/mssql:bionic-python38`

If you don't trust the binary images, you can build all of the above images by cloning the repo and running `build.sh`, which
is used by myself to build the production images which are pushed to DockerHub.


Quickstart
----------

If you just want to interact with an MSSQL server interactively via the CLI, you can use `docker run` to download, install, and
start a container for `someguy123/mssql` - by default if no command is specified, you'll be dropped into a Bash shell, where you can
use `sqlcmd` for interacting with MSSQL servers, and `bcp` for copying between / backing up MSSQL servers.

```sh
user@host $ docker run --rm -it someguy123/mssql

05:37:56 5a87aedbf2b8:/ # sqlcmd -?

    Microsoft (R) SQL Server Command Line Tool
    Version 17.4.0001.1 Linux
    Copyright (c) 2012 Microsoft. All rights reserved.

    usage: sqlcmd            [-U login id]          [-P password]
    [-S server or Dsn if -D is provided]
    [-H hostname]          [-E trusted connection]

```

If you have a Python project, you can use `someguy123/mssql:python37` (Python 3.7) or `someguy123/mssql:python38` (Python 3.8),
which includes both the `PyODBC` and `cTDS` libraries.

The most basic usage for the Python image is simply: import the image, copy your application which uses `pyodbc` or `ctds`, 
and run it with the python version installed (see the `examples/` folder)

```dockerfile
FROM someguy123/mssql:python38

WORKDIR /app
COPY . /app/

CMD ["sh", "-c", "python3.8 app.py"]
```

Below is an example of using the `python38` tag with a Python web application, using `pipenv` to install the packages and setup
a virtualenv - then serving the application on port 8282 using the `gunicorn` WSGI server.

```dockerfile
FROM someguy123/mssql:python38 as build

WORKDIR /build
COPY Pipfile Pipfile.lock /build/
RUN bash -c "PIPENV_VENV_IN_PROJECT=1 pipenv install"

FROM build as app

WORKDIR /app
COPY --from=build /build /app/
COPY . /app/

EXPOSE 8282

CMD ["sh", "-c", "PIPENV_VENV_IN_PROJECT=1 pipenv run gunicorn -b '0.0.0.0:8282' -w 8 myapp.wsgi"]
```



What's included?
----------------

**LEGAL DISCLAIMER**: Each library and package listed below (apart from helper scripts in `main/extras/`) may be released
under a different license than this repository itself is. It's your responsibility to check that you comply with the licenses
of any libaries/packages that you use from the published Docker images or images you've built using this repository.

Included in the base image:

 - Basic packages `curl`, `wget`, and `locales`
 
 - The locale `en_US.UTF-8` and some of the ISO locales (needed for `sqlcmd` to function correctly)

 - [Microsoft SQL Server ODBC Driver + MSSQL Tools](https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver15)
    - `msodbcsql17` - The ODBC drivers required for a lot of libraries to be able to interact with MSSQL databases
    - `mssql-tools` - The CLI tools `sqlcmd` (command line SQL client similar to `mysql` or `psql`) and `bcp`
    - `unixodbc-dev` - Development headers for ODBC drivers

 - A utility script `install_dsns` which installs all files in the folder `/opt/sg-mssql/dsns` as DSNs into `/etc/odbc.ini`



Included in the Python images:

 - Everything in the base image
 - The default system Python version for the image's distro (default is Ubuntu 18.04 at time of writing)
 - A newer version of Python as specified in the image (e.g. 3.7, 3.8, or 3.9 when it's ready)
 
 - Additional Python packages pre-installed into both the default Python version + the newer Python version
    - The [PyODBC Python Library](https://github.com/mkleehammer/pyodbc) (backed by Microsoft) - A library for interacting with MSSQL
    - The [cTDS Python Library](https://github.com/zillow/ctds) - Another library for interacting with MSSQL
    - [Pipenv](https://pipenv.readthedocs.io/en/latest/) - A popular tool for managing both `pip` dependencies and virtual environments
 
 - The library [FreeTDS](https://www.freetds.org/) - which is required by certain MSSQL libraries / clients (such as cTDS)

