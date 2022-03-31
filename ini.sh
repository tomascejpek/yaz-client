#!/bin/bash

iniFile="config.local.ini"

getValue() {
  if grep "^$1=" $iniFile >/dev/null; then
    grep -oP "^$1=\K.*" $iniFile | xargs
  fi
}

"$@"
