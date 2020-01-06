#!/usr/bin/env bash

export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

if [ -t 1 ]; then
    BOLD="$(tput bold)" RED="$(tput setaf 1)" GREEN="$(tput setaf 2)" YELLOW="$(tput setaf 3)" BLUE="$(tput setaf 4)"
    MAGENTA="$(tput setaf 5)" CYAN="$(tput setaf 6)" WHITE="$(tput setaf 7)" RESET="$(tput sgr0)"
else
    BOLD="" RED="" GREEN="" YELLOW="" BLUE=""
    MAGENTA="" CYAN="" WHITE="" RESET=""
fi

# Taken from https://github.com/Privex/shell-core/blob/master/base/colors.sh
msg () {
    if [[ "$#" -eq 0 ]]; then echo ""; return; fi;
    if [[ "$#" -eq 1 ]]; then
        echo -e "$1"
        return
    fi
    [[ "$1" == "ts" ]] && shift && _msg="[$(date +'%Y-%m-%d %H:%M:%S %Z')] " || _msg=""
    if [[ "$#" -gt 2 ]] && [[ "$1" == "bold" ]]; then
        echo -n "${BOLD}"
        shift
    fi
    (($#==1)) && _msg+="$@" || _msg+="${@:2}"

    case "$1" in
        bold) echo -e "${BOLD}${_msg}${RESET}";;
        BLUE|blue) echo -e "${BLUE}${_msg}${RESET}";;
        YELLOW|yellow) echo -e "${YELLOW}${_msg}${RESET}";;
        RED|red) echo -e "${RED}${_msg}${RESET}";;
        GREEN|green) echo -e "${GREEN}${_msg}${RESET}";;
        CYAN|cyan) echo -e "${CYAN}${_msg}${RESET}";;
        MAGENTA|magenta|PURPLE|purple) echo -e "${MAGENTA}${_msg}${RESET}";;
        * ) echo -e "${_msg}";;
    esac
}


