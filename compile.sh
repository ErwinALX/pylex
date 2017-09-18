#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

mkdir build

lex --outfile=build/LAB01_Bustillo_Garrido.c src/LAB01_Bustillo_Garrido.l && \
gcc build/LAB01_Bustillo_Garrido.c -o build/LAB01_Bustillo_Garrido.out -ll
