#include "team.hpp"

void Team::calcScore()
{
        if (members.size() != 0)
        {
                double scoreSum = 0;
                vector<Player>::const_iterator it;
                for (it = members.begin(); it != members.end(); ++it)
                {
                        scoreSum += (double)((*it).getPoints());
                }
                score = scoreSum / (double)members.size();
        }
}

double Team::getScore() const
{
        return score;
}

string Team::getName() const
{
        return name;
}

void Team::increaseTeamPoints()
{
        if (members.size() != 0)
        {
                vector<Player>::iterator it;
                for (it = members.begin(); it != members.end(); ++it)
                {
                        (*it).increasePoints();
                }
        }
        calcScore();
}

istream &operator>>(istream &dev, Team &t)
{
        if (t.members.size() != 0)
                t.members.clear();
        dev >> t.nrMembers;
        getline(dev, t.name);
        t.name.erase(0, 1);
        if(t.name.at(t.name.length()-1) == ' ')
        {
                t.name.erase(t.name.length()-1,1);
        }
        Player tmp;
        for (int i = 0; i < t.nrMembers; i++)
        {
                dev >> tmp;
                t.members.push_back(tmp);
        }
        t.calcScore();
        return dev;
}

ostream &operator<<(ostream &dev, const Team &t)
{
        dev << t.name;
        return dev;
}