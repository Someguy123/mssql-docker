#!/usr/bin/env bash
#########
#
# Docker Entry Point Script for someguy123/mssql
# github.com/Someguy123/mssql-docker
#
# License: MIT / X11
#
#########

. /opt/sg-mssql/colors.sh

echo 'PS1="\[\033[35m\]\t \[\033[32m\]\h\[\033[m\]:\[\033[33;1m\]\w\[\033[m\] # "' >> /root/.bashrc
chsh -s /bin/bash root

msg
msg green "#####################################################################################################################"
msg green "#"
msg green "# Welcome to Someguy123's MSSQL Docker Image  ( someguy123/mssql )   "
msg green "#"
msg green "# Microsoft SQL Server tools (MSSQL) should be installed into /opt/mssql-tools/bin"
msg green "#"
msg green "# Copy your DSN files into /opt/sg-mssql/dsns using the placeholder "
msg green "# 'MS_DRIVER' within the 'Driver =' setting."
msg green "#"
msg green "# Example DSN available at: ${BOLD}/opt/sg-mssql/example_dsn.ini"
msg green "#"
msg green "# Run ${BOLD}install_dsns${RESET}${GREEN} to install all DSN files inside of ${BOLD}/opt/sg-mssql/dsns"
msg green "# with automatic placeholder replacement of 'MS_DRIVER' with the name of the current ODBC driver."
msg green "#"
msg green "#####################################################################################################################\n"

msg yellow "\nContents of '/opt/mssql-tools/bin':\n"
ls --color=always -l /opt/mssql-tools/bin

export PATH="/opt/mssql-tools/bin:/opt/sg-mssql/bin:${PATH}"

msg magenta "\n##################################################\n"

bash

