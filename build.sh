#!/bin/sh

set -eux

PROJECT_ROOT="/rust/build/${GITHUB_REPOSITORY}"

mkdir -p $PROJECT_ROOT
rmdir $PROJECT_ROOT
ln -s $GITHUB_WORKSPACE $PROJECT_ROOT
cd $PROJECT_ROOT

BINARY=$(cargo read-manifest | jq ".name" -r)

if [ -x "./build.sh" ]; then
  OUTPUT=`./build.sh "${CMD_PATH}"`
else
  OPENSSL_LIB_DIR=/usr/lib64 OPENSSL_INCLUDE_DIR=/usr/include/openssl cargo build --release"
  OUTPUT="target/release/$BINARY"
fi

mv "$OUTPUT" "./$BINARY"
echo "$BINARY"
