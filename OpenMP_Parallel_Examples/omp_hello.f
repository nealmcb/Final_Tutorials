C******************************************************************************
C FILE: omp_hello.f
C DESCRIPTION:
C   OpenMP Example - Hello World - Fortran Version
C   In this simple example, the master thread forks a parallel region.
C   All threads in the team obtain their unique thread number and print
C   it.
C   The master thread only prints the total number of threads.  Two
C   OpenMP
C   library routines are used to obtain the number of threads and each
C   threads number.
C AUTHOR: Blaise Barney  5/99
C LAST REVISED: 
C******************************************************************************

       PROGRAM HELLO
       
       INTEGER NTHREADS, TID, OMP_GET_NUM_THREADS,
     +   OMP_GET_THREAD_NUM

C     Fork a team of threads with each thread having a private TID
C     variable
!$OMP PARALLEL PRIVATE(TID)

C     Obtain and print thread id
      TID = OMP_GET_THREAD_NUM()
      PRINT *, 'Hello World from thread = ', TID

C     Only master thread does this
      IF (TID .EQ. 0) THEN
        NTHREADS = OMP_GET_NUM_THREADS()
        PRINT *, 'Number of threads = ', NTHREADS
      END IF

C     All threads join master thread and disband
!$OMP END PARALLEL

       END
