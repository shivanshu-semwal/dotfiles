#!/usr/bin/env bash

DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
THEME="$DIR/theme"

rofimoji --skin-tone neutral --selector-args "-theme '$THEME'"
