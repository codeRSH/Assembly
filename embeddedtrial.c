#include"reg51.h"

int main()
{ 
	P1 = 0x55;
	P1 = ~P1;
	return 0;
}
