! Program to create a HDF5 file.
!
program hdf_swrite

        use hdf5
        use kinds, only : r_dp

        implicit none

        ! Data array is 20 x 20
        integer, parameter :: N     = 20
        integer, parameter :: ndims = 2

        integer             :: argc               ! Number of arguments
        character(len=1024) :: filename           ! File name to create
        integer             :: ierr               ! Error status

        integer             :: i,j                ! Loop indexers
        real(kind=r_dp), allocatable :: grid(:,:) ! Data array

        ! HDF5 variables
        integer(kind=hid_t)   :: f_id             ! File id
        integer(kind=hid_t)   :: s_id             ! File space id
        integer(kind=hid_t)   :: d_id             ! File data id
        integer(kind=hid_t)   :: p_id             ! Data chunking property
        integer(kind=hsize_t) :: d_size(ndims)    ! Data size
        integer(kind=hsize_t) :: u_size(ndims)    ! Total data size

        argc = 0
        ierr = 0

        ! get the filename
        argc = command_argument_count()
        if (argc .lt. 1 ) then
                write(0, *) 'Must supply a filename'
                call exit(1)
        endif
        call get_command_argument(1, filename)


        ! Init the HDF5 library
        call h5open_f(ierr)

        ! Open the file
        call h5fcreate_f(filename, H5F_ACC_TRUNC_F, f_id, ierr)
        if (ierr .ne. 0) then
                write(0,*) 'Unable to open: ', trim(filename), ': ', ierr
                stop 1
        endif

        ! Generate our 4x4 matrix with a 1x1 halo
        allocate(grid(N,N), stat=ierr)

        ! init the local data
        do j = 1, N
                do i = 1, N
                        grid(i,j) = (i - 1 + (j-1)*N)
                enddo
        enddo

        ! Create the file sizes (and their max sizes)
        d_size = N
        u_size = H5S_UNLIMITED_F

        call h5screate_simple_f(ndims, d_size, s_id, ierr, &
                                maxdims=u_size)
        if (ierr .ne. 0) then
                write(0,*) 'Unable create data space'
                stop 1
        endif

        ! Unlimited datasets must be written in chunks
        call h5pcreate_f(H5P_DATASET_CREATE_F, p_id, ierr)
        call h5pset_chunk_f(p_id, ndims, d_size, ierr)

        ! Create the dataset id
        call h5dcreate_f(f_id, "/data", H5T_IEEE_F64LE, s_id, d_id, &
                         ierr, dcpl_id=p_id)
        if (ierr .ne. 0) then
                write(0,*) 'Unable create dataset'
                stop 1
        endif

        ! Write the data
        call h5dwrite_f(d_id, H5T_IEEE_F64LE, grid, d_size, ierr)
        if (ierr .ne. 0) then
                write(0,*) 'Unable write dataset'
                stop 1
        endif

        if (allocated(grid)) then
                deallocate(grid)
        endif

        ! Close everything and exit
        call h5dclose_f(d_id, ierr)
        call h5sclose_f(s_id, ierr)
        call h5fclose_f(f_id, ierr)
        call h5close_f(ierr)

end program hdf_swrite
