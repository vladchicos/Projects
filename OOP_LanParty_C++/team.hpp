#pragma once
#include <vector>
#include "player.hpp"
class Team
{
private:
        string name;
        double score;
        vector<Player> members;

public:
        int nrMembers;
        friend istream &operator>>(istream &dev, Team &);
        friend ostream &operator<<(ostream &dev, const Team &);
        void increaseTeamPoints();
        void calcScore();
        double getScore() const;
        string getName() const;
};