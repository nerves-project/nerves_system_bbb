#!/bin/sh

# configure
make -C ../nerves-system-br O=$(pwd)/_nerves NERVES_CONFIG=$(pwd)/src config

# build
make -C $(pwd)/_nerves


