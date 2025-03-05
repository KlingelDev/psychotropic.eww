#!/usr/bin/env bash
# https://cssgradient.io/
#~/.cargo/bin/gradient -a -o hex -c "#efeee0" "#efeee0" "#4bd404" "#dec506" "#fe9800" "#ff1d00" "#ff0031" "#ea00ff" -P 0.0 0.1 0.2 0.6 0.8 0.9 0.95 1.0
roomtemp=21.0

source /home/karl/.config/eww/psychotropic/scripts/stress.sh

gt=$(nvidia-smi -q |
  perl -ne 'm!GPU\s(Current\sTemp|Max\sOperating\sTemp)[^:]+:\s(\d+)! && print "$2 "')
read gputemp gpumax <<< "$gt"
pgputemp=$(bc -l <<< "($gputemp-$roomtemp)/($gpumax-$roomtemp)*100")

p=$(printf "%.0f" $pgputemp)
echo ${stress_gradient[$p]}
