#include <stdio.h>
#include <stdlib.h>

int mult (int x, int y);

int main (){
	int x = rand(); //rand function comes from the stdlib.h
	int y;
	printf("Rand value was: %d\n", x);
	scanf("%d", &y);
	printf("Multiplied values are: %d\n", mult(x,y));

	getchar();
	getchar();
	return 0;
}

int mult(int x, int y){
	return x * y;
}