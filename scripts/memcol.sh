#!/usr/bin/env bash
source /home/karl/.config/eww/psychotropic/scripts/stress.sh
memuse=$(freecolor -t -m -o | perl -ne 'if(m!Mem:\s+(\d+)\s+(\d+)!){if($2 > 0) {printf("%d", $2/$1*100)} else { print "0"; }}')
echo ${stress_gradient[$memuse]}
