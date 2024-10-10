#!/usr/bin/env bash

killall Dock

killall SystemUIServer

fc-cache -fv

bat cache --build
