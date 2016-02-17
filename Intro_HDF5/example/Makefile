#
# HDF5 example programs
#

# Serial compiler helpers
HCC      = h5cc
HFC      = h5fc

# Parallel compiler helpers
HPCC     = h5pcc
HPFC     = h5pfc

# Compiler flags
CFLAGS   = -O3
FCFLAGS = -O3


EXES = hdf_swrite \
       hdf_pwrite

.SUFFIXES:
.SUFFIXES:    .c .f90 .o
.PHONEY:      clean

all: $(EXES)

hdf_pwrite: kinds.o hdf_pwrite.o
	$(HPFC) $(FCFLAGS) -o $@ $^ $(LDFLAGS)

hdf_pwrite.o: hdf_pwrite.f90
	$(HPFC) -c $(FCFLAGS) -o $@ $<

hdf_swrite: kinds.o hdf_swrite.o
	$(HFC) $(FCFLAGS) -o $@ $^ $(LDFLAGS)

.f90.o:
	-$(RM) $*.o $*.mod
	$(HFC) -c $(FCFLAGS) -o $@ $<

clean:
	-$(RM) *.h5 *.o *.mod $(EXES)

