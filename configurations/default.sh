#!/bin/bash
# This is a template script to install the external project
# You should create a configuration folder and copy this script
# to the folder for actual installation.
config=$(basename "${BASH_SOURCE[0]}" .sh)
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
root="$script_dir/.."
source_dir="$script_dir/../source"
build_dir="$script_dir/../build/$OCP_COMPILER/$config"
install_dir="$script_dir/../install/$OCP_COMPILER/$config"

mkdir -p $build_dir
cp -r $source_dir/* $build_dir
cd $build_dir/src
CC=$OCP_CC CXX=$OCP_CXX ./configure --prefix=$install_dir --with-MPI --enable-bigint --enable-shared
make -j$(($(nproc) - 1))
make install
cd -