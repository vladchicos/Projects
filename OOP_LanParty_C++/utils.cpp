#include "utils.hpp"
bool compareTeams::operator()(const Team &A, const Team &B) const
{
        //dorim ordonare descrescatoare
        if(A.getScore() > B.getScore())
                return true;
        else if(A.getScore() < B.getScore())
                return false;
        else if(A.getName() > B.getName())
                return true;
        else
                return false;
        
}