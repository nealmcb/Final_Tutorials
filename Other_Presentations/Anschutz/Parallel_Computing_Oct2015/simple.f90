       program simple 
       include 'mpif.h'

       integer numtasks, rank, len, ierr 
       character(MPI_MAX_PROCESSOR_NAME) hostname 

       call MPI_INIT(ierr)  ! initializes MPI execution environment 
       if (ierr .ne. MPI_SUCCESS) then 
          print *,'Error starting MPI program. Terminating.' 
          call MPI_ABORT(MPI_COMM_WORLD, rc, ierr) 
       end if 

       ! returns the rank of the calling MPI process within the
       ! specified communicator
       call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr) 

       ! returns the total number of MPI processes in the specified
       ! communicator
       call MPI_COMM_SIZE(MPI_COMM_WORLD, numtasks, ierr) 

       ! Returns the name of the processor (hostname) the process is
       ! running on
       call MPI_GET_PROCESSOR_NAME(hostname, len, ierr) 

       print *, 'Number of tasks=',numtasks,' My rank=',rank, & 
       ' Running on=',hostname 

       ! ****** do some work ****** 

       call MPI_FINALIZE(ierr) 

       end

