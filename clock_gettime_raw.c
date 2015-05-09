#include <time.h>
#include <sys/time.h>

int main()
{
	struct timespec tp;
	for (int i = 0; i < 50000000; i++) {
		clock_gettime(CLOCK_MONOTONIC_RAW, &tp);
	}
	return 0;

}
