#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

char buffer[24];

int 
main() 
{
    int fd = open("/dev/flag", O_RDWR); 
    dprintf(1, "FD: %d\n", fd);                 
    memset(&buffer, 'A', 23);                
    dprintf(1, "Buffer: %s\n", buffer);
    
    read(fd, buffer, 23);
    dprintf(1, "Here is flag: %s\nRewrite your flag: ", buffer);
    memset(&buffer, 0, 24); 
    int num = read(0, buffer, 23);
    buffer[num] = '\0';
    write(fd, buffer, 23);

    read(fd, buffer, 23);  
    dprintf(1, "It here: %s\n", buffer);
}            