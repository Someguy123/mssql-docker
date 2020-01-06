#!/usr/bin/env bash
#########
#
# Docker Image Builder Script for someguy123/mssql
# github.com/Someguy123/mssql-docker
#
# License: MIT / X11
#
#########

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

: ${BASE_TAG="someguy123/mssql"}

BUILD_ARGS=()

cd "$DIR"

. main/extra/colors.sh

dkr_build() {
    local btag bdir
    (($#<1)) && bdir="." || bdir="$1"
    (($#<2)) && btag="${BASE_TAG}" || btag="${BASE_TAG}:$2"
    msg cyan " [>>>] Building Docker Image from folder: ${BOLD}${bdir}"
    msg cyan " [>>>] Tagging final image as: ${BOLD}${btag}"
    msg yellow " [>>>] Docker build arguments: ${BOLD}${BUILD_ARGS[@]}"
    sleep 2
    msg bold green "\n [+++] Starting build process for ${BOLD}${btag}\n"
    if (( ${#BUILD_ARGS[@]} < 1 )); then
        docker build -t "$btag" "$bdir"
    else
        docker build "${BUILD_ARGS[@]}" -t "$btag" "$bdir"
    fi

    msg bold green "\n [+++] Finished building ${BOLD}${btag}\n"
}

dkr_tag() {
    local from_tag="${BASE_TAG}:$1" to_tag="${BASE_TAG}:$2"
    msg yellow " >>> Tagging '$from_tag' as '$to_tag'"
    docker tag "$from_tag" "$to_tag"
}

dkr_py() {
    local bdir="$1" btag="$2" pyver="$3"
    BUILD_ARGS=('--build-arg' "PY_VER=$pyver")

    msg cyan " [>>>] Building ${BOLD}${btag}${RESET}${CYAN} using Python package: ${pyver}"
    sleep 2
    dkr_build "${@:1:2}"
}


dkr_build main

dkr_tag "latest" "bionic"

#docker build -t "${BASE_TAG}" main

dkr_py main-python python37 'python3.7'
dkr_py main-python python38 'python3.8'

dkr_tag "python37" "bionic-python37"
dkr_tag "python38" "bionic-python38"


