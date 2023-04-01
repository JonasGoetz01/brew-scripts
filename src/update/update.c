#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv)
{
	if (argc == 1)
	{
		system("brew update");
		system("brew outdated");
		system("brew cleanup");
	}

	if (argc == 2 && strcmp(argv[1], "-y") == 0) 
	{
		system("brew update");
		system("brew upgrade");
		system("brew upgrade --cask --greedy");
		system("brew upgrade $(brew outdated --cask --greedy --quiet)");
		system("brew cleanup");
	}
	return 0;
}
