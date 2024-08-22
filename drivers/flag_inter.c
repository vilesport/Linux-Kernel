#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

char buffer[23];

int 
main() 
{
    setvbuf(stdin, 0, _IONBF, 0);
	setvbuf(stdout, 0, _IONBF, 0);

    int fd = open("/dev/flag", O_RDWR); 
    printf("FD: %d\n", fd);                 
    memset(&buffer, 'A', 23);                
    printf("Buffer: %s\n", buffer);
    
    read(fd, buffer, 23);
    printf("Here is flag: %s\nRewrite your flag: ", buffer);
    int num = read(0, buffer, 23);
    buffer[num] = '\0';
    write(fd, buffer, 23);

    read(fd, buffer, 23);  
    printf("It here: %s\n", buffer);
}            