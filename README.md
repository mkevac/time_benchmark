# Simple benchmark of time functions in Linux

## /usr/bin/time - Let's see wall time

```
$ /usr/bin/time ./time 
0.10user 0.00system 0:00.10elapsed 100%CPU (0avgtext+0avgdata 968maxresident)k
0inputs+0outputs (0major+61minor)pagefaults 0swaps
$ /usr/bin/time ./gettimeofday 
0.72user 0.00system 0:00.73elapsed 100%CPU (0avgtext+0avgdata 1076maxresident)k
0inputs+0outputs (0major+60minor)pagefaults 0swaps
$ /usr/bin/time ./clock_gettime
0.73user 0.00system 0:00.73elapsed 99%CPU (0avgtext+0avgdata 1036maxresident)k
0inputs+0outputs (0major+61minor)pagefaults 0swaps
$ /usr/bin/time ./clock_gettime_raw 
0.88user 1.76system 0:02.65elapsed 99%CPU (0avgtext+0avgdata 1084maxresident)k
0inputs+0outputs (0major+60minor)pagefaults 0swaps
```

## perf trace - Let's watch syscalls

Only `clock_gettime(CLOCK_MONOTONIC_RAW)` is using syscalls. All other are using [vdso](https://lwn.net/Articles/446528/).

```
$ sudo perf trace -s ./time

 Summary of events:

 time (5808), 49 events, 86.0%, 0.000 msec

   syscall            calls      min       avg       max      stddev
                               (msec)    (msec)    (msec)        (%)
   --------------- -------- --------- --------- ---------     ------
   read                   2     0.000     0.001     0.002    100.00%
   open                   2     0.003     0.003     0.003      5.19%
   close                  2     0.001     0.001     0.001      2.64%
   fstat                  2     0.001     0.001     0.001      0.77%
   mmap                   8     0.001     0.002     0.004     15.16%
   mprotect               4     0.003     0.004     0.006     19.50%
   munmap                 1     0.007     0.007     0.007      0.00%
   brk                    1     0.001     0.001     0.001      0.00%
   access                 1     0.003     0.003     0.003      0.00%
   execve                 1     0.000     0.000     0.000      0.00%
   arch_prctl             1     0.001     0.001     0.001      0.00%
```
```
$ sudo perf trace -s ./gettimeofday

 Summary of events:

 gettimeofday (5825), 49 events, 86.0%, 0.000 msec

   syscall            calls      min       avg       max      stddev
                               (msec)    (msec)    (msec)        (%)
   --------------- -------- --------- --------- ---------     ------
   read                   2     0.000     0.001     0.001    100.00%
   open                   2     0.003     0.003     0.003      2.33%
   close                  2     0.001     0.001     0.001      2.55%
   fstat                  2     0.001     0.001     0.001     24.86%
   mmap                   8     0.001     0.002     0.003     15.68%
   mprotect               4     0.002     0.003     0.006     28.51%
   munmap                 1     0.005     0.005     0.005      0.00%
   brk                    1     0.001     0.001     0.001      0.00%
   access                 1     0.003     0.003     0.003      0.00%
   execve                 1     0.000     0.000     0.000      0.00%
   arch_prctl             1     0.001     0.001     0.001      0.00%
```
```
$ sudo perf trace -s ./clock_gettime

 Summary of events:

 clock_gettime (5836), 49 events, 86.0%, 0.000 msec

   syscall            calls      min       avg       max      stddev
                               (msec)    (msec)    (msec)        (%)
   --------------- -------- --------- --------- ---------     ------
   read                   2     0.000     0.001     0.001    100.00%
   open                   2     0.003     0.003     0.003      5.78%
   close                  2     0.001     0.001     0.001      1.01%
   fstat                  2     0.001     0.001     0.001     25.72%
   mmap                   8     0.001     0.002     0.003     14.10%
   mprotect               4     0.002     0.003     0.006     23.10%
   munmap                 1     0.005     0.005     0.005      0.00%
   brk                    1     0.001     0.001     0.001      0.00%
   access                 1     0.003     0.003     0.003      0.00%
   execve                 1     0.000     0.000     0.000      0.00%
   arch_prctl             1     0.001     0.001     0.001      0.00%
```
```
$ sudo perf trace -s ./clock_gettime_raw

 Summary of events:

 clock_gettime_r (5845), 100000049 events, 100.0%, 0.000 msec

   syscall            calls      min       avg       max      stddev
                               (msec)    (msec)    (msec)        (%)
   --------------- -------- --------- --------- ---------     ------
   read                   2     0.000     0.001     0.001    100.00%
   open                   2     0.003     0.003     0.004      4.57%
   close                  2     0.001     0.001     0.001      0.47%
   fstat                  2     0.001     0.001     0.001     11.43%
   mmap                   8     0.001     0.002     0.004     15.94%
   mprotect               4     0.002     0.004     0.006     22.54%
   munmap                 1     0.006     0.006     0.006      0.00%
   brk                    1     0.001     0.001     0.001      0.00%
   access                 1     0.004     0.004     0.004      0.00%
   execve                 1     0.000     0.000     0.000      0.00%
   arch_prctl             1     0.001     0.001     0.001      0.00%
   clock_gettime   50000000     0.001     0.001     0.131      0.01%
```
