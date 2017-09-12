#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

./compile.sh && cat data/simple.py | ./build/LAB01_Bustillo_Garrido.out
