#!/bin/bash
# first, generate a file containing x-y coordinates of a sine function
#  from -10 to 10 radians
i=-100
while [ $i -le 100 ]; do
  # since we can only increment on integers in bash, have to divide in order
  # to get enough data points on x-axis
  x=`echo "scale=3; $i/10" | bc`
  y=`echo "scale=3; s($x)" | bc -l`   # need -l to enable trig functions
  echo "$x $y" > datafile.txt
  i=$((i+1))
done
# now plot to postscript file using gnuplot
gnuplot << EOF
set terminal postscript
set output "datafile.ps"
plot "datafile.txt" with linespoints
EOF

