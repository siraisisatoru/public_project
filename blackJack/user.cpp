#include "user.h"
user::user()
{
	userCTypes = new int[1];
	userState = new int[1];
	size = 1;

	//testing initialization

}

int* user::getType() {
	return userCTypes;
}

int* user::getState() {
	return userState;
}

int user::getSize() {
	return size;
}

void user::setNT(int T) {
	int *temp = userCTypes;
	userCTypes = new int[size];
	for (int i = 0; i < size - 1; i++) {
		userCTypes[i] = temp[i];
	}
	userCTypes[size - 1] = T;
	delete[] temp;
}

void user::setNC(int C) {
	int *temp = userState;
	userState = new int[size];
	for (int i = 0; i < size - 1; i++) {
		userState[i] = temp[i];
	}
	userState[size - 1] = C;
	delete[] temp;
	size++;
}

void user::printUT(int showblind) {
	cout << CF.numberWordCOnvertion(userCTypes[0]);
	if (showblind == 1) {
		for (int i = 1; i < size - 1; i++) {
			cout << "\t," << CF.numberWordCOnvertion(userCTypes[i]);
		}
		cout << ". " << endl;
	}
	else {
		cout << "\t," << " ?? ";
		cout << ". " << endl;
	}
	cout << endl;
}

void user::printUC(int showblind) {
	cout << userState[0];
	if (showblind == 1) {
		for (int i = 1; i < size - 1; i++) {
			cout << "\t," << userState[i];
		}
		cout << ". " << endl;
	}
	else {
		cout << "\t," << " ?? ";
		cout << ". " << endl;
	}
	cout << endl;
}




user::~user()
{
	delete[] userCTypes;
	userCTypes = NULL;
	delete[] userState;
	userState = NULL;
}


