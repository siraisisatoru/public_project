#include "convertion_functions.h"



convertion_functions::convertion_functions()
{
}


string convertion_functions::numberWordCOnvertion(int N) {
	string returnW = "";
	switch (N) {
	case 0: {
		returnW = "spade";
		break;
	}

	case 1: {
		returnW = "heart";
		break;
	}

	case 2: {
		returnW = "club";
		break;
	}

	case 3: {
		returnW = "diam";
		break;
	}

	default: {
		returnW = "error";
	}
	}
	return returnW;
}

bool convertion_functions::datachecking(int up, int down, int num) {// up 15 down 2
	bool result;
	if ((num <= up) && (num >= down)) {
		result = true;
	}
	else {
		result = false;
	}
	return result;
}


bool convertion_functions::compareMAX(int a, int b) {
	//return (a < b ? true : false);
	bool result;
	if (a < b)
		result = true;
	else
		result = false;
	return result;
}

convertion_functions::~convertion_functions()
{
}
