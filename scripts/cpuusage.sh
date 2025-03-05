#!/usr/bin/env bash

top -n 0 | perl -ne 'if(m!(\d+\.\d+)\%\sidle!){printf("%05.1f%", 100.0 - $1);}'

