#!/usr/bin/env bash
# https://cssgradient.io/
#~/.cargo/bin/gradient -a -o hex -c "#efeee0" "#efeee0" "#4bd404" "#dec506" "#fe9800" "#ff1d00" "#ff0031" "#ea00ff" -P 0.0 0.1 0.2 0.6 0.8 0.9 0.95 1.0
roomtemp=21.0

stress_gradient=("#efeee0" "#efeee0" "#efeee0" "#efeee0" "#efeee0" "#efeee0"
 "#efeee0" "#efeee0" "#efeee0" "#efeee0" "#efeee0" "#eaeddb" "#deeccf" "#cdeabe"
 "#b8e6a9" "#a1e391" "#89df77" "#70db5d" "#5bd741" "#4dd523" "#4bd403" "#4cd401"
 "#4dd400" "#50d400" "#52d400" "#55d400" "#59d400" "#5dd400" "#61d400" "#65d400"
 "#6ad300" "#6ed300" "#73d300" "#78d300" "#7dd300" "#81d300" "#86d200" "#8bd200"
 "#90d200" "#94d200" "#99d100" "#9ed100" "#a2d100" "#a7d000" "#abd000" "#afcf00"
 "#b4cf00" "#b8ce00" "#bcce01" "#bfcd01" "#c3cc02" "#c7cc03" "#cacb04" "#cdca05"
 "#d0c905" "#d3c906" "#d6c806" "#d9c706" "#dbc606" "#ddc506" "#e0c406" "#e3c305"
 "#e5c105" "#e8bf04" "#eabd04" "#ecbb04" "#eeb903" "#efb703" "#f1b503" "#f2b202"
 "#f4b002" "#f5ae02" "#f6ab02" "#f7a901" "#f8a601" "#f9a301" "#faa101" "#fb9e01"
 "#fd9b00" "#fe9900" "#ff9200" "#ff8800" "#ff7d00" "#ff7200" "#ff6500" "#ff5800"
 "#ff4a00" "#ff3b00" "#ff2d00" "#ff1e00" "#ff170f" "#ff1119" "#ff0b21" "#ff0528"
 "#ff0031" "#fb1554" "#f7257e" "#f22baa" "#ed25d7" "#ea00ff")

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
