//gpg --keyserver keyserver.ubuntu.com --send-keys yourkeyID



#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void manual(void)
{
	printf("\033[1m");
    printf("GPG Manual\n\n");
    printf("\033[0m");
    printf("Please enter a valid command.\n\n");
    printf("Usage:\n");
    printf("\tIf this is your first time using GPG, create a keypair and publish it to the Ubuntu keychain.\n\n");
    printf("Available commands:\n\n");
    printf("\033[1m");
    printf("%-30s %-70s\n", "generate-keypair", "Generates a default keypair.");
    printf("%-30s %-70s\n", "generate-encryption-keypair", "Generates a keypair that can be used to encrypt files.");
    printf("%-30s %-70s\n", "publish-keypair", "Publishes keypair to the Ubuntu keychain.");
    printf("%-30s %-70s\n", "encrypt [filename]", "Encrypts the given file.");
    printf("%-30s %-70s\n", "", "Valid flags:");
    printf("%-30s %-70s\n", "", "-o Outputfile (specify an output file)");
    printf("%-30s %-70s\n", "", "-r receiver (specify a recipient)");
    printf("%-30s %-70s\n", "decrypt [filename]", "Decrypts the given file.");
    printf("%-30s %-70s\n", "", "Valid flags:");
    printf("%-30s %-70s\n", "", "-o Outputfile (specify an output file)");
    printf("\033[0m");
}

int main (int argc, char **argv)
{
	if (argc == 1)
	{
		manual();
		return (0);
	}
	if (argc == 2)
	{
		if (strcmp(argv[1], "generate-keypair") == 0)
		{
			printf("Please use your email address as the name\n");
			int status = system("gpg --default-new-key-algo rsa4096 --gen-key");
			if (WEXITSTATUS(status) == 0)
			{
				printf("Successfully created gpg key\n");	
			} 
			else 
			{
				printf("Error creating gpg key\n");
			}
		}
	}
}
