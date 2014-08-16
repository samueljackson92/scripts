#include <stdlib.h>
#include <stdio.h>

int main() {
	int x;
	int *y; //creating a pointer

	y = &x; //initilising a pointer to a memory address

	scanf("%d", y);
	printf("Value you input was: %d\n", *y); //dereference the memoyr address

	//dynamic memory allocation (c++ requires the casting)
	int *ptr = (int*) malloc( sizeof(*ptr) );

	if(NULL == ptr){
		//allocation failed
		exit(1);
	} else {
		//allocation successful
		realloc(ptr, 10  * sizeof(*ptr)); //realloc reallocates the size of the memory pointer

		free(ptr); //free memory back to OS
		ptr = NULL; // set pointer address to null, therefore stopping it for accessing that memory again
	}
	printf("Successful!");
	getchar();
	getchar();
}