#!/bin/sh
export WINEDEBUG="${WINEDEBUG:=-all}"
export JAVA_HOME="Z:\opt\openjdk-windows"
/usr/bin/wine64 "${JAVA_HOME}\bin/$(basename "$0")" "$@"
