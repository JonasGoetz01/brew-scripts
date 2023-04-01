#include <stdio.h>
#include <unistd.h>

int main (int argc, char  **argv)
{
	if(argc < 2)
	{
		printf("Please enter parameter!");
	}
	else
	{
		printf("The parameter is: %s", argv[1]);
	}
	return 0;
}
