#pragma once
#include "team.hpp"
#include<iomanip>
class Match
{

        Team opponent1;
        Team opponent2;
public:
        Match(Team &, Team &);
        void play();
        Team & getWinner();
        Team & getLoser();
        friend ostream &operator<<(ostream &dev, Match &); 

};