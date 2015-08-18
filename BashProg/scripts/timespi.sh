#!/bin/bash

# picks out lines that contain the string "data"
# and prints the third field and the second field times pi

cat mydata |\
while read line; do
 if [[ $line =~ data ]]; then
  echo $line | awk '{print $3, $2*3.14}'
 fi
done

