#!/bin/bash
# calculate sine of argument (radians)
if [ $# -eq 1 ]; then
  sine=`echo "scale=4; s($1)" | bc -l`
  echo "The sine of $1 is $sine"
else
  echo "Usage: $0 <number in radians> "
fi

