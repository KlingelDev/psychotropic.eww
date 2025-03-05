#!/usr/bin/env bash

source /home/karl/.config/eww/psychotropic/scripts/stress.sh

cpuuse=$(top -n 0 | perl -ne 'if(m!(\d+\.\d+)\%\sidle!){printf("%d", 100.0 - $1);}')
echo ${stress_gradient[$cpuuse]}

