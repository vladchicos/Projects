#include "player.hpp"

Player::Player()
{
        firstName = "";
        secondName = "";
        points = 0;
}

Player::Player(const string & firstName, const string & secondName, int points)
{
        this->firstName = firstName;
        this->secondName = secondName;
        this->points = points;
}

int Player::getPoints() const
{
        return points;
}

void Player::increasePoints()
{
        points+=1;
}

istream & operator>>(istream &dev, Player & p)
{
        dev >> p.firstName;
        dev >> p.secondName;
        dev >> p.points;
        return dev;
}

ostream & operator<<(ostream & dev, Player & p)
{
        dev << p.firstName << ' ';
        dev << p.secondName << ' ';
        dev << p.points << ' ';
        return dev;
}