/*
 * Copyright (C) 2015  Timothy Brown
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

#include <stdlib.h>
#include <stdio.h>
#include <mpi.h>
#include <err.h>
#include <sysexits.h>

int
main(int argc, char **argv)
{
	int ierr = 0;
	int id = 0;
	int nprocs = 0;

	ierr = MPI_Init(&argc, &argv);
	if (ierr) errx(ierr, "Unable to initialize MPI");

	ierr = MPI_Comm_rank(MPI_COMM_WORLD, &id);
	if (ierr) {
		warnx("Unable to initialize MPI");
		MPI_Abort(MPI_COMM_WORLD, ierr);
	}

	ierr = MPI_Comm_size(MPI_COMM_WORLD, &nprocs);
	if (ierr) {
		warnx("Unable to initialize MPI");
		MPI_Abort(MPI_COMM_WORLD, ierr);
	}

	printf("Processor %2d of %2d\n", id, nprocs);

	ierr = MPI_Finalize();
	if (ierr) errx(ierr, "Unable to finalize MPI");

	return(EXIT_SUCCESS);
}
