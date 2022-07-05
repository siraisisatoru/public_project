#include <iostream>
#include <string>
#include <ctime>
#include <array>
#include <windows.h>
#include "cards.h"
#include "user.h"
#include "convertion_functions.h"
using namespace std;

int addSum(int* arr, int size) {
	int result = 0;
	for (int i = 0; i < size; i++) {
		result = result + arr[i];
	}
	return result;
}

void giveAC(user*& U, cards *& type, int userindex = -1) { // only one new card will be given.
	// by default , -1 = all , 0 = computer , 2 = user1 , etc...
	srand((int)time(NULL));
	int T;
	if (userindex == -1) {
		T = rand() % 4;
		//......data checking 
		if (type[T].returntotalnum() == 0) {
			do {
				T = rand() % 4;
			} while (type[T].returntotalnum() == 0);
		}
		//......data checking 
		U[0].setNT(T);
		U[0].setNC(type[T].getC());
		Sleep(200);
		//.........................................
		T = rand() % 4;
		//......data checking 
		if (type[T].returntotalnum() == 0) {
			do {
				T = rand() % 4;
			} while (type[T].returntotalnum() == 0);
		}
		//......data checking
		U[1].setNT(T);
		U[1].setNC(type[T].getC());
		Sleep(200);
	}
	else if (userindex == 0) {
		T = rand() % 4;
		//......data checking 
		if (type[T].returntotalnum() == 0) {
			do {
				T = rand() % 4;
			} while (type[T].returntotalnum() == 0);
		}
		//......data checking
		U[0].setNT(T);
		U[0].setNC(type[T].getC());
		Sleep(200);
	}
	else {
		T = rand() % 4;
		//......data checking 
		if (type[T].returntotalnum() == 0) {
			do {
				T = rand() % 4;
			} while (type[T].returntotalnum() == 0);
		}
		//......data checking
		U[1].setNT(T);
		U[1].setNC(type[T].getC());
		Sleep(200);
	}

	//.........................................
	// if there are more than one user, can add 
	// the index of U to 2 or above

}

void printSeenC(user*& U, int showblind = 1) {
	// 1 show com's blind cards, 0 not
	cout << " The cards on the desk has shown below : " << endl;// seen card �W�P blind card �t�P 
	cout << "		The computer's seen card : " << endl;
	cout << "	Computer's seen card 's type :\t";
	U[0].printUT(showblind);
	cout << "	Computer's seen card 's state :\t";
	U[0].printUC(showblind);
	//...............................................
	cout << endl;
	cout << endl;
	cout << "		The user 1's seen card : " << endl;
	cout << "	User 1's seen card 's type :\t";
	U[1].printUT(1);
	cout << "	User 1's seen card 's state : \t";
	U[1].printUC(1);
	cout << "" << endl;
	cout << "" << endl;
}

void printFinalResult(int playerG, int comG, int trueend) {	// you lose / you win
	system("cls");

	if (trueend == 1) {
		cout << endl;
		cout << "\tThank you for playing this game. Here are the final result." << endl;
		cout << "\tThe rate player : computer has been show as below :" << endl;
		cout << "\t\t\t" << playerG << " : " << comG << endl;
		int winlost = (playerG) > (comG) ? 1 : ((playerG) == (comG) ? 2 : 0);

		switch (winlost) {
		case 0:
			cout << "\n\n\t\t\t\t YOU LOST  !!!!" << endl;
			break;
		case 1:
			cout << "\n\n\t\t\t\t YOU WIN  !!!!" << endl;
			break;
		case 2:
			cout << "\n\n\t\t\t\t IT IS DRAW  !!!!" << endl;
			break;
		}
	}
	else {
		cout << "\n\t Now leaving the game." << endl;
	}
	cout << "" << endl;
	cout << "\tThank you for downloading this console game." << endl;
	cout << "\tIf you found any bugs or comments, please content me by email / QQ / weibo" << endl;
}

void printIntro() {
	cout << "\tScreen testing, please move the window until the dots could show in one line." << endl;
	cout << ".........................................................................................................." << endl;
	system("pause");
	system("cls");
	cout << endl;
	cout << "\t Welcome to play this BLACKJACK console game." << endl;
	cout << "\t Thank you for downloading this game and welcome to give me any \n\t suggestions and bugs of this game.\n" << endl;
	cout << "\t Now, let me tell you about the rules of this game.\n" << endl;
	cout << "\t This game has been referenced a real gambling blackjack and \n\t simplify the rules.\n" << endl;
	cout << "\t In this game, card 1s cannot been consider as 1 or 11.\n\t Card 1s could only represent as 1s.\n" << endl;
	cout << "\t Within this game players must ensure the total value of the cards smaller or equals to 21. \n\t No matter whose total value greater than 21, another one will become the winner.\n" << endl;
	cout << "\t If both two side��s total value are the same and smaller than 21,\n\t one mark will be added to both score.\n" << endl;
	cout << ".........................................................................................................." << endl;
	cout << "\n\t 1.Computer is the dealer and you will be the player.  \n" << endl;
	cout << "\t 2. At the beginning, there are two pairs of cards, one of the \n\t\t cards of computer's will be a blind card and others are seen cards.\n" << endl;
	cout << "\t 3. Then, you will have the ability to consider stand, hit or give up.\n" << endl;
	cout << "\t 4. This console game will ask you repeatedly until you stop the process." << endl;
	cout << "\t\t (Please follow the instructions during the process.)\n" << endl;
	cout << "\t 5. The computer will process itself and given the cards \n\t\t to itself and there will show the result after the process.\n" << endl;
	cout << "\t 6. This game will run three times from rule 2 to 5 repeatedly \n\t and show the final score at the end after round 3." << endl;
	cout << ".........................................................................................................." << endl;
	cout << "\t At the last, thanks a lot for you reading the words of above." << endl;
	cout << "\t NOTE 1 : By the formatting problem, the diamond cards will only diplay diam as the symbol " << endl;//diamond
	cout << endl;
	cout << "\t IF you understand those rules press any keys to continue the process...." << endl;
	cout << endl;
	system("pause");
	system("cls");
}

// rand()%(number); in the ranghe of the number to zero
int main() {
	printIntro();
	int runcounting = 0, playerG = 0, comG = 0, trueend = 0;
	// winrate will count the rate of the player.
	// out of the while loop, WR = 0(3:0) WR = 1(2:1) WR = 2(1:2) WR = 3(0:3)
	cout << "\n\n\n\n\t\tShuffling, please wait for a few seconds." << endl;
	cards* types = new cards[4]; // [0] = spade���� [1] = heart���� [2] = club��� [3] = diamond�٧�
	convertion_functions CF;
	int *tempP, *tempP1;
	int temp = 0, temp1 = 0, selections = 0;//anything temps
	while (runcounting != 3) {
		system("cls");
		user* USER = new user[2]; // �i�]�m���h��@�H�C�� default : 0 = compomputer ,1 = user1 ,2 = user2 etc...
		runcounting++;
		trueend = 1, selections = 0;
		cout << "\t Round : " << runcounting << endl;
		for (int i = 0; i < 2; i++) {// given one to all *2
			giveAC(USER, types);
		}
		tempP = USER[0].getState();
		tempP1 = USER[1].getState();
		printSeenC(USER, 0);// 1 show com's blind cards, 0 not
		//................. user
		do {
			cout << "1\t stand" << endl;
			cout << "2\t hit" << endl;
			cout << "-1\t quit the game and you lost." << endl;
			cout << "please enter your chose. And press enter after you enter the number." << endl;
			//bool datachecking(int up, int down, int num);
			do {
				temp = 0;
				cin >> selections;
				if (CF.datachecking(2, -1, selections)) {
					if (selections == 0) {
						cout << "Enter error, please re-enter" << endl;
						temp = 1;
					}
				}
				else {
					cout << "Enter error, please re-enter" << endl;
					temp = 1;
				}
			} while (temp != 0);
			//..........
			switch (selections) {
			case -1:
				system("cls");
				cout << "\n\tWORNING : Are you sure to quit the game and lost the game ?" << endl;
				cout << "\t -1 for sure, 0 for back and re-enter the chose." << endl;
				//................. data checking
				do {
					temp = 0;
					cin >> selections;
					if (!CF.datachecking(0, -1, selections)) {
						cout << "Enter error, please re-enter" << endl;
						temp = 1;
					}
				} while (temp != 0);
				//.................
				if (selections == -1) {
					runcounting = 3;
					playerG = 0;
					trueend = 0; // 1 true end 0 end by -1
				}
				else {
					system("cls");
					printSeenC(USER, 0);
				}
				break;

			case 1:
				break;

			case 2:
				giveAC(USER, types, 1);
				tempP1 = USER[1].getState();
				system("cls");
				printSeenC(USER, 0);
				break;

			default:
				cout << "SYSTEM WORNING ! ! Program crash by some unknown reason,\n please contend your computer administrator to fix this problem." << endl;
				break;
			}

		} while (!((selections == 1) || (selections == -1))); // selection = -1 -> leave the game 
		//................. comp ���P����n�A���
		temp = 0, temp1 = 0;
		temp = addSum(tempP, USER[0].getSize() - 1);
		temp1 = addSum(tempP1, USER[1].getSize() - 1);
		if ((selections == 1) && (temp1 <= 21)) {
			do {
				if (temp <= 17) {
					giveAC(USER, types, 0);
					tempP = USER[0].getState();
				}
				temp = 0;
				temp = addSum(tempP, USER[0].getSize() - 1);
			} while (temp < 17);
		}
		//................. compute result
		if (selections == 1) {
			system("cls");
			printSeenC(USER);
			temp = 0, temp1 = 0;
			temp = addSum(tempP, USER[0].getSize() - 1);
			temp1 = addSum(tempP1, USER[1].getSize() - 1);

			//.....compute test
			cout << "	RESULT OF THE TOTAL VALUE  : " << endl;
			cout << "\tComputer's total value: " << temp << endl;
			cout << "\tPlayer's total value: " << temp1 << endl;
			system("pause");
			//.....

			if (temp <= 21 && temp1 <= 21) {
				if (temp > temp1) {
					comG++;
				}
				else if (temp < temp1) {
					playerG++;
				}
				else {
					comG++;
					playerG++;
				}
			}
			else if (temp > 21 && temp1 <= 21) {
				playerG++;
			}
			else if (temp <= 21 && temp1 > 21) {
				comG++;
			}
		}
		//.................
		delete[] USER;
	};

	// .........................
	cout << "" << playerG << endl;
	printFinalResult(playerG, comG, trueend);
	system("pause");
	delete[] types;
	return 0;
}




//.................................

/*

tempP = USER[0].getState();
tempP1 = USER[1].getState();

cout << "This is the first time print all seen card" << endl;
printSeenC(USER, 1);// first time calling the printing function
cout << "This is the second time print all seen card" << endl;
printSeenC(USER);// second time calling the printing function

//........
giveAC(USER, types, 0); // given one to com
//........
giveAC(USER, types, 1); // given one to user1
//........
printSeenC(USER); // default more than one times calling the print function

*/