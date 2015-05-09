#include <time.h>
#include <sys/time.h>

int main()
{
	for (int i = 0; i < 50000000; i++) {
		time_t t = time(0);
	}

	return 0;

}
