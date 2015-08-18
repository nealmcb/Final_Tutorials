#!/bin/bash
#SBATCH -N 1			# Number of requested nodes
#SBATCH --time=0:05:00		# Max walltime
#SBATCH --output=hostname.txt	# Output file name

srun hostname
