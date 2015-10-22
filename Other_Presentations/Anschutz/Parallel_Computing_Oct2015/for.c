/*
 *  *  Copyright (C) 2015  Timothy Brown
 *   *
 *    *  This program is free software: you can redistribute it and/or modify
 *     *  it under the terms of the GNU General Public License as published by
 *      *  the Free Software Foundation, either version 3 of the License, or
 *       *  (at your option) any later version.
 *        *
 *         *  This program is distributed in the hope that it will be useful,
 *          *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *           *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *            *  GNU General Public License for more details.
 *             *
 *              *  You should have received a copy of the GNU General Public License
 *               *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *                *
 *                 */
#define _POSIX_C_SOURCE 200809L

#include <stdlib.h>
#include <stdio.h>
#include <omp.h>
#include <err.h>
#include <sysexits.h>
#include <math.h>

#define ALIGNMENT 64

int
main(int argc, char **argv)
{

	int i = 0;
	int n = 0;
	int ierr = 0;
	double *a = NULL;
	double *b = NULL;
	double *c = NULL;

	/* Read in the size of the arrays */
	if (argc != 2) {
		errx(EX_USAGE, "Must specify the array size.");
	}
	n = strtol(argv[1], NULL, 10);

	ierr = posix_memalign((void **)&a, ALIGNMENT, n * sizeof(double));
	if (ierr) {
		err(ierr, "Unable to allocate: %ld", n * sizeof(double));
	}
	ierr = posix_memalign((void **)&b, ALIGNMENT, n * sizeof(double));
	if (ierr) {
		err(ierr, "Unable to allocate: %ld", n * sizeof(double));
	}
	ierr = posix_memalign((void **)&c, ALIGNMENT, n * sizeof(double));
	if (ierr) {
		err(ierr, "Unable to allocate: %ld", n * sizeof(double));
	}

	/* OpenMP loop addition:
 * 	 * a = b + c
 * 	 	 */
#pragma omp parallel \
	    default(none) \
	    shared(a,b,c,n) \
	    private(i)
	{
		#pragma omp for
		for (i=0; i< n; ++i) {
			a[i] = 0.0;
			b[i] = 12.0;
			c[i] = sin(2.0);
		}
		#pragma omp for
		for (i=0; i< n; ++i) {
			a[i] = b[i] + c[i];
		}
	}

	if (a) {
		free(a);
		a = NULL;
	}
	if (b) {
		free(b);
		b = NULL;
	}
	if (c) {
		free(c);
		c = NULL;
	}
        return(EXIT_SUCCESS);
}
