#!/usr/bin/env bash
# https://cssgradient.io/
#~/.cargo/bin/gradient -a -o hex -c "#efeee0" "#efeee0" "#4bd404" "#dec506" "#fe9800" "#ff1d00" "#ff0031" "#ea00ff" -P 0.0 0.1 0.2 0.6 0.8 0.9 0.95 1.0
roomtemp=21.0

function get_gpu() {
  gt=$(nvidia-smi -q |
    perl -ne 'm!GPU\s(Current\sTemp|Max\sOperating\sTemp)[^:]+:\s(\d+)! && print "$2 "')
  read gputemp gpumax <<< "$gt"
  pgputemp=$(bc -l <<< "($gputemp-$roomtemp)/($gpumax-$roomtemp)*100")
}

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
#p=$(printf "%.${1}f" $pcofmax)
p=$(printf "%.2f°C" $avgtemp)
#o=$(printf '{ "text": "%.2f" , "class": "p%s" }' $avgtemp $cpu)

echo $p
