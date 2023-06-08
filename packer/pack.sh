#!/bin/bash

mkdir -p /tmp/amd64/usr/zen/include
mkdir -p /tmp/amd64/usr/zen/lib

cp /workdir/bindings/ffi/bindings.h /tmp/amd64/usr/zen/include
cp /workdir/target/release/libzen_ffi.a /tmp/amd64/usr/zen/lib

# get from Cargo.toml
VERSION="1.10.2"

archs="amd64"
targets="deb rpm"
name="zen"

for arch in $archs; do
    for target in $targets; do
        cd /tmp/${arch}
        fpm  -s dir -t ${target} -v ${VERSION} -n ${name}  \
            -a ${arch} ./usr/zen/include ./usr/zen/lib
    done
done

dpkg --contents /tmp/amd64/${name}_${VERSION}_amd64.deb

# https://fpm.readthedocs.io/en/v1.15.1/packages/osxpkg.html
# mac - set target to osxpkg (ensure what paths you need)