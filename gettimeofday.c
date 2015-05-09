#include <time.h>
#include <sys/time.h>

int main()
{
	struct timeval tv;

	for (int i = 0; i < 50000000; i++) {
		gettimeofday(&tv, NULL);
	}

	return 0;

}
