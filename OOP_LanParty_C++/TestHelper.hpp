#include <fstream>
#include <iostream>
#include <list>
#include <set>
#include <deque>
#include <stack>
#include "team.hpp"
#include "match.hpp"
#include "utils.hpp"
using namespace std;

class TestHelper
{
public:
        void Cerinta1(list<Team> &, ifstream &);
        void Cerinta2(list<Team> &);
        void Cerinta3(list<Team> &, deque<Match> &, stack<Team> &,
                      stack<Team> &, ofstream &m, stack<Team> &);
        void Cerinta4(stack<Team> &, set<Team, struct compareTeams> &,
                                         ofstream &);
        void Cerinta5(set<Team, struct compareTeams> &, ofstream &);
        void printWinner(Team &, ofstream &);
};