#!/usr/bin/env bash

source /home/karl/.config/eww/psychotropic/scripts/stress.sh

# https://cssgradient.io/
#~/.cargo/bin/gradient -a -o hex -c "#efeee0" "#efeee0" "#4bd404" "#dec506" "#fe9800" "#ff1d00" "#ff0031" "#ea00ff" -P 0.0 0.1 0.2 0.6 0.8 0.9 0.95 1.0
roomtemp=21.0

# Get all cpu temperatures build an avg and display
ct=$(sysctl -a |
     perl -ne 'm!dev\.cpu\.(\d+)\.(coretemp\.tjmax|temperature):\s(\d+)! && print "$3\n"')
acputemp=acputempn=0
acpumax=acpumaxn=0

readarray cputemp <<< $ct

for i in ${!cputemp[@]};
do
  if [ $((i%2)) -eq 0 ];
  then
    acputemp=$((acputemp+cputemp[$i]))
    acputempn=$((acputempn+1))
  else
    acpumax=$((acpumax+cputemp[$i]))
    acpumaxn=$((acpumaxn+1))
  fi
done

avgtemp=$(bc -l <<< "$acputemp/$acputempn")
avgmax=$(bc -l <<< "$acpumax/$acpumaxn")

pcofmax=$(bc -l <<< "($avgtemp-$roomtemp)/($avgmax-$roomtemp)*100")
p=$(printf "%.0f" $pcofmax)
if [ $p -le 0 ];
then
  echo "#222"
else
  echo ${stress_gradient[$p]}
fi
