#ifndef	USER_H
#define USER_H
#include <iostream>
#include <string>
#include <ctime>
#include <array>
#include <windows.h>
#include "convertion_functions.h"
using namespace std;
class user
{
private:
	int *userCTypes;
	int *userState;
	int size;
	int temp = 0;
	convertion_functions CF;
	//testing variables.............................


public:
	user();
	~user();
	//void setNC(int T, int C);
	void setNT(int T);
	void setNC(int C);
	void printUT(int showblind);
	void printUC(int showblind);
	int* getType();
	int* getState();
	int getSize();



	//teating methods...............................


};

#endif