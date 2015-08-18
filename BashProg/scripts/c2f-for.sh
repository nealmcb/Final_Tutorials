#!/bin/bash
# Calculate Fahrenheit equivalents of Celsius temperatures
#  from -40 to 40
for c in {-40..40}; do
  echo $c `echo "scale=3; (9/5)*$c+32" |bc`  # use "bc" for non-integer math
done

