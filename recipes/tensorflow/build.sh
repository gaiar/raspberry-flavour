#!/bin/bash

# install using pip from the whl files on PyPI

#https://github.com/lhelontra/tensorflow-on-arm/releases/download/v1.8.0/tensorflow-1.8.0-cp35-none-linux_armv7l.whl
#https://github.com/lhelontra/tensorflow-on-arm/releases/download/v1.8.0/tensorflow-1.8.0-cp27-none-linux_armv7l.whl

if [ `uname` == Linux ]; then
    if [ "$PY_VER" == "2.7" ]; then
        WHL_FILE=https://github.com/lhelontra/tensorflow-on-arm/releases/download/v${PKG_VERSION}/tensorflow-${PKG_VERSION}-cp27-none-linux_armv7l.whl
    elif [ "$PY_VER" == "3.5" ]; then
        WHL_FILE=https://github.com/lhelontra/tensorflow-on-arm/releases/download/v${PKG_VERSION}/tensorflow-${PKG_VERSION}-cp35-none-linux_armv7l.whl
    fi
fi

pip install --no-deps $WHL_FILE
