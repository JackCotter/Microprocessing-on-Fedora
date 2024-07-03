# Microprocessing-on-Fedora

SENG440 project for programming a microprocessor on Fedora. Using Virtual-manager and QEMU.

Group Project members:
Jack Cotter
Charlie Wager

## Record 16-bit wav data with arecord on linux

``` shell
arecord -t wav -f S16_LE -d <duration of recording> <filename>
```

## Code Profiling

Code profiling will be done using gprof and valgrind tools.

### GPROF

To profile with gprof, first compile with:

``` shell
gcc <source code file> -pg <other options> -o <output filename> 
```

then run the program as normal, then execute the ```gprof``` command to get results.

### Valgrind

To profile with valgrind, first compile the source code as normal then exucute with:

``` shell
valgrind --tool=<callgrind or massif> ./<name of executable>
```

The results should then be located in a .out.PID file. This file can be annotated with the ```<tool name>_annotate <output file path>``` command.
