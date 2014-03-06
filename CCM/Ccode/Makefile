CC=g++
CFLAGS=.

all: ccm.o 
	$(CC) -o ccm ccm.o 

verify: CCM_verify.o
	$(CC) -o CCM_verify CCM_verify.o

clean:
	$(RM) ccm ccm.o CCM_verify CCM_verify.o
