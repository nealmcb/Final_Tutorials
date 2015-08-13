#!/bin/bash
if [ $# -ge 1 ]; then 
  # reminder: $# is number of args
  echo "File types:"
  file $@ 
  echo ""
  echo "Number of lines:"
  wc -l $@
else
  echo "Usage: $0 file1 [...fileN]"
fi

