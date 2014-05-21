#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#define NB_ITERATION 1000000
#define BLOCK_SIZE 40
#define BIG_BLOCK_SIZE 40

int main (int   argc, char *argv[])
{
    printf("################################\n");
    printf("##### LEAKING MALLOC !!! #######\n");
    printf("################################\n");
    int i = 0;
    char* ptrBig = (char*) malloc(BIG_BLOCK_SIZE);
    if (ptrBig == NULL)
        printf("ptrBig alloc failed \n");
    else
        memset(ptrBig,0,BIG_BLOCK_SIZE);

    while ( i < NB_ITERATION )
    {
        printf("ITERATION : %d \n",i);
        char* ptr = (char*) malloc(BIG_BLOCK_SIZE);
        if (ptr == NULL)
            printf("ptr alloc failed \n");
        else
            memset(ptr,0,BLOCK_SIZE);
            
        i++;
        usleep(100);
    }
    return 0;
}

