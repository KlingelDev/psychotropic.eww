#!/usr/bin/env bash
freecolor -t -m -o | perl -ne 'if(m!Mem:\s+(\d+)\s+(\d+)!){if($2 > 0) {printf("%05.1f%", $2/$1*100)} else { print "000.0%"}}'
