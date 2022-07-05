
#ifndef	CONVERTION_FUNCTION_H
#define CONVERTION_FUNCTION_H
#include <iostream>
#include <string>
#include <ctime>
#include <array>
#include <windows.h>
using namespace std;
class convertion_functions
{
private:

public:

	convertion_functions();
	~convertion_functions();
	//.........................................
	// functions :
	string numberWordCOnvertion(int N);
	bool datachecking(int up, int down, int num);
	bool compareMAX(int a, int b = 21);

};
#endif 
