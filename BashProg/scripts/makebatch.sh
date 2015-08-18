#!/bin/bash
# set up parameter and batch files for a set of cluster
#  runs, then submit those jobs to the queue
xmax=30
ymax=20
x=10
while [ $x -le $xmax ] ; do
  y=10  # need to reinitialize y each time thru the x loop
  while [ $y -le $ymax ] ; do
    # use "here document" to create parameter file
    cat > param_${x}_${y} <<ENDofDOC
    $x
    $y
    3700
    output_${x}_${y}
ENDofDOC

    # use "echo" commands to create batch scripts; compare with "here document" method
    echo "#!/bin/bash" > batch_${x}_${y}
    echo "#PBS -N ${x}_${y}" >> batch_${x}_${y}
    echo "#PBS -l nodes=3:ppn=8" >> batch_${x}_${y}
    echo 'cd $PBS_O_WORKDIR' >> batch_${x}_${y}
    echo "./my_prog.x < param_${x}_${y}" >> batch_${x}_${y}
    #submit job
    qsub -q queue batch_${x}_${y}
    y=$((y+5))   # increment y
  done # repeat inner loop over y
  x=$((x+10)) # increment x
done  # repeat outer loop over x  

