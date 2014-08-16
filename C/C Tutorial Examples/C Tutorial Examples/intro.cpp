#include <stdio.h>

int main(){
	int x = 1;
	printf("Hello world!\n");
	scanf("%d", &x);
	printf("You entered a %d", x);
	getchar();
	return 0;
}