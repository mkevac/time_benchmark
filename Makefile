all:
	gcc -O0 -ggdb3 -fno-omit-frame-pointer -std=gnu99 -o clock_gettime clock_gettime.c
	gcc -O0 -ggdb3 -fno-omit-frame-pointer -std=gnu99 -o clock_gettime_raw clock_gettime_raw.c
	gcc -O0 -ggdb3 -fno-omit-frame-pointer -std=gnu99 -o gettimeofday gettimeofday.c
	gcc -O0 -ggdb3 -fno-omit-frame-pointer -std=gnu99 -o time time.c

clean:
	rm time
	rm clock_gettime
	rm clock_gettime_raw
	rm gettimeofday
