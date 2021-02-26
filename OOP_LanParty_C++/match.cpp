#include "match.hpp"

Match::Match(Team &t1, Team &t2)
{
        opponent1 = t1;
        opponent2 = t2;
}
void Match::play()
{
        if (opponent1.getScore() > opponent2.getScore())
        {
                opponent1.increaseTeamPoints();
        }
        else
        {
                opponent2.increaseTeamPoints();
        }
}

Team &Match::getWinner()
{
        if (opponent1.getScore() > opponent2.getScore())
                return opponent1;
        return opponent2;
}

Team &Match::getLoser()
{
        if (opponent1.getScore() > opponent2.getScore())
                return opponent2;
        return opponent1;
}

ostream &operator<<(ostream &dev, Match &m)
{
        dev << std::left << std::setw(33) << m.opponent1;
        dev << "-";
        dev << std::right << std::setw(33) << m.opponent2 << '\n';

        return dev;
}
