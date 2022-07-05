#include "cards.h"

cards::cards()
{

	c = 0;
	for (int i = 0; i < 10; i++) {
		C[i] = i + 1;
	}
	C[10] = C[11] = C[12] = 10;
	int i = 0;
	while (i < 5) {
		Shuffling();
		i++;
	}
	
	//...............TESTING ...............
	/*
	cout << "...............TESTING ..............." << endl;
	for (int i = 0; i < 13; i++) {
	cout << C[i] << endl;
	}
	cout << "...............TESTING ..............." << endl;
	*/
}

void cards::Shuffling() {
	Sleep(75);
	srand((int)time(NULL));
	for (int i = 0; i < 12; i++) {
		int r = i + (rand() % (13 - i));
		int number = C[i];
		C[i] = C[r];
		C[r] = number;
	}
}

cards::~cards()
{

}

int cards::getC() {
	int i = 0;
	do {
		i = rand() % (12);
		c = C[i];
	} while (c == 0);
	C[i] = 0;
	return c;
}
int cards::returntotalnum() {
	int num = 0;
	for (int i = 0; i < 13; i++) {
		num = C[i] + num;
	}
	return num;
}
