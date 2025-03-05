#!/usr/bin/env bash
freecolor -m -o | perl -ne 'if(m!Swap:\s+(\d+)\s+(\d+)\s+.*!){if($2 > 0) {printf("%05.1f%", $1/$2)} else { print "000.0%"}}'
