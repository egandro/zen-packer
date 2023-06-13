#!/bin/bash

mkdir -p /tmp/amd64/usr/include
mkdir -p /tmp/amd64/usr/lib

cp /workdir/bindings/ffi/bindings.h /tmp/amd64/usr/include
cp /workdir/target/release/libzen_ffi.a /tmp/amd64/usr/lib

# get from Cargo.toml (https://github.com/rust-lang/cargo/issues/4082)
VERSION="0.0.1"

archs="amd64"
targets="deb rpm"
name="zen"

# https://www.digitalocean.com/community/tutorials/how-to-use-fpm-to-easily-create-packages-in-multiple-formats

# fpm -s dir -t deb -C /tmp/project --name project_name --version 1.0.0 --iteration 1
# --depends debian_dependency1  .


for arch in $archs; do
    for target in $targets; do
        fpm -s dir -t ${target} -v ${VERSION} -n ${name}  \
           --description "GoRules.io ZEN bindings" \
           -a ${arch} -f -C /tmp/${arch} -p /workdir/target/release
    done
done

dpkg --contents /workdir/target/release/${name}_${VERSION}_amd64.deb

# sudo apt-get install ./zen_0.0.1_amd64.deb
# sudo apt-get remove zen


# https://fpm.readthedocs.io/en/v1.15.1/packages/osxpkg.html
# mac - set target to osxpkg (ensure what paths you need)
