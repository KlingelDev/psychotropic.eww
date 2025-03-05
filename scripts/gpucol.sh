#!/usr/bin/env bash

source /home/karl/.config/eww/psychotropic/scripts/stress.sh

gpuuse=$(nvidia-smi -q | perl -ne 'if(m!Gpu\s+:\s(\d+)\s\%!) { printf("%d", $1); }')
echo ${stress_gradient[$gpuuse]}
