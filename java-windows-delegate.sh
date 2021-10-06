#!/bin/sh
export WINEDEBUG="${WINEDEBUG:=-all}"
JAVA_HOME="$(winepath -w /opt/openjdk-windows)"
export JAVA_HOME
/usr/bin/wine64 "${JAVA_HOME}\\bin\\$(basename "$0").exe" "$@"
