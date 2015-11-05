!
! Copyright (C) 2015  Timothy Brown
!
! This program is free software: you can redistribute it and/or modify
! it under the terms of the GNU General Public License as published by
! the Free Software Foundation, either version 3 of the License, or
! (at your option) any later version.
!
! This program is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU General Public License for more details.
!
! You should have received a copy of the GNU General Public License
! along with this program.  If not, see <http://www.gnu.org/licenses/>.
!
!
program iring

        use mpi

        implicit none

        integer, parameter             :: N = 100000
        integer, parameter             :: RINGTAG = 10
        integer                        :: ierr
        integer                        :: cnt
        integer                        :: nprocs
        integer                        :: id
        integer                        :: j
        integer                        :: left
        integer                        :: right
        integer                        :: mstat(MPI_STATUS_SIZE, 2)
        integer                        :: reqs(2)
        double precision, allocatable  :: x(:)

        call MPI_Init(ierr)
        call MPI_Comm_size(MPI_COMM_WORLD, nprocs, ierr)
        call MPI_Comm_rank(MPI_COMM_WORLD, id, ierr)
        if (id == 0) then
                print *, "Running on ", nprocs, "MPI processes"
        end if
        allocate(x(N*nprocs), stat=ierr)
        x(:) = id
        left = id + 1
        right = id - 1
        if (left > nprocs - 1) then
                left = 0
        end if
        if (right < 0) then
                right = nprocs-1
        end if
        cnt = 1
        do j = 1, nprocs - 1
                call MPI_Irecv(x(cnt+N), N, MPI_DOUBLE_PRECISION, &
                            & right, ringtag, MPI_COMM_WORLD, reqs(1), ierr)
                call MPI_Isend(x(cnt), N, MPI_DOUBLE_PRECISION, &
                            &  left, ringtag, MPI_COMM_WORLD, reqs(2), ierr)
                cnt = cnt + N
                call MPI_Waitall(2, reqs, mstat, ierr)
        end do

        print *, '[', id, ']', ' My answer is', sum(x)

        deallocate(x)
        call MPI_finalize(ierr)

end program iring

