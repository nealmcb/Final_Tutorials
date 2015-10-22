!******************************************************************************
! FILE: hello.f
! DESCRIPTION:
!   MPI Example - Hello World - Fortran Version
!   In this simple example, which is the same code used for the OpenMP example, 
!   the program creates a parallel region.
!   All processes in the program obtain their unique identifier and print
!   it.
!   The master process only prints the total number of processes.  
! AUTHOR: Blaise Barney  5/99
! LAST REVISED: 
! Shelley Knuth 10/15
!******************************************************************************

       PROGRAM HELLO
       include 'mpif.h'
 
       INTEGER NTHREADS, TID, numtasks, ierr

!     Initialize a MPI region
       call MPI_INIT(ierr)


!     Obtain and print rank
       call MPI_COMM_RANK(MPI_COMM_WORLD, TID, ierr)
       PRINT *, 'Hello World from thread = ', TID

!     Only master thread does this
       IF (TID .EQ. 0) THEN
         call MPI_COMM_SIZE(MPI_COMM_WORLD, numtasks, ierr)
         PRINT *, 'Number of threads = ', NTHREADS
       END IF

!     End MPI environment
       call MPI_FINALIZE(ierr)

       END

