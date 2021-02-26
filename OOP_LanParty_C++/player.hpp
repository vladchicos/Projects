#pragma once
#include <iostream>
#include <string>
using namespace std;
class Player
{
private:
        string firstName;
        string secondName;
        int points;

public:
        Player();
        Player(const string &, const string &, int);
        friend istream &operator>>(istream &dev, Player &);
        friend ostream &operator<<(ostream &dev, Player &);
        int getPoints() const;
        void increasePoints();
};