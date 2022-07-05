#ifndef	CARDS_H
#define CARDS_H
#include <iostream>
#include <string>
#include <ctime>
#include <array>
#include <windows.h>
#include "convertion_functions.h"
using namespace std;
class cards {
private:
	int C[13];
	int c; // a return type to main function
	convertion_functions CF;
public:
	cards();
	~cards();
	int getC();
	void Shuffling();
	int returntotalnum();
};

#endif