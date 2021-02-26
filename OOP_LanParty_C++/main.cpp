#include <iostream>
#include <fstream>
#include <list>
#include <queue>
#include <stack>
#include "TestHelper.hpp"
#include "team.hpp"
#include "match.hpp"
#include "utils.hpp"

using namespace std;

int main(int argc, char ** argv)
{

        char demand_arr[10];
        ifstream demand(argv[1]);
        demand.getline(demand_arr,10);//citim cerintele cerute
        TestHelper solveHomework;

        list<Team> teams;
        stack<Team> top8;
        set<Team, struct compareTeams> sortedTop8;

        ifstream input(argv[2]);
        ofstream output(argv[3]);
        if(demand_arr[0] == '1')
        {
                solveHomework.Cerinta1(teams, input);
        }
        if(demand_arr[2] == '1')
        {
                solveHomework.Cerinta2(teams);
        }
        //afisam echipele participante
        list<Team>::const_iterator it;
        for(it=teams.begin();it!=teams.end();++it)
        {
                output << (*it) << '\n';
        }
        if(demand_arr[4] == '1')
        {
                deque<Match> matches;
                stack<Team> winners;
                stack<Team> losers;
                solveHomework.Cerinta3(teams, matches, winners, losers,
                                                        output, top8);

        }
        if(demand_arr[6] == '1')
        {
                solveHomework.Cerinta4(top8, sortedTop8, output);
        }
        if(demand_arr[8] == '1')
        {
                solveHomework.Cerinta5(sortedTop8, output);
        }
        
        

}