#!/usr/bin/env bash
nvidia-smi -q | perl -ne 'if(m!Gpu\s+:\s(\d+)\s\%!) { printf("%05.1f%", $1); }'
