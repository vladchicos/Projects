#include "TestHelper.hpp"

void TestHelper::printWinner(Team &t, ofstream &output)
{
        //afisam invingator conform formatului
        output << std::left << std::setw(34) << t << "-  ";
        output << setprecision(2) << fixed;
        output << t.getScore() << '\n';
}

void TestHelper::Cerinta1(list<Team> &teams, ifstream &input)
{
        int nrTeams;
        Team tmp;
        input >> nrTeams;
        for (int i = 0; i < nrTeams; i++)
        {
                input >> tmp;
                teams.push_front(tmp);
        }
}

void TestHelper::Cerinta2(list<Team> &teams)
{
        set<double> teamScores;
        list<Team>::const_iterator iterTeams;
        for (iterTeams = teams.begin(); iterTeams != teams.end(); ++iterTeams)
        {
                teamScores.insert((*iterTeams).getScore());
        }
        int requiredTeamsNr = 1;
        while (requiredTeamsNr <= teams.size())
                requiredTeamsNr *= 2;
        requiredTeamsNr /= 2; //calculam nr maxim de echipe permis
        set<double>::const_iterator iterMinNr;
        iterMinNr = teamScores.begin();
        //stergem echipele cu cel mai mic punctaj, avand permanent grija sa nu
        //fim sub nr cerut de echipe
        while (iterMinNr != teamScores.end() && teams.size() > requiredTeamsNr)
        {
                iterTeams = teams.begin();
                while (iterTeams != teams.end() && teams.size() > requiredTeamsNr)
                {
                        if ((*iterTeams).getScore() == (*iterMinNr))
                                iterTeams = teams.erase(iterTeams);
                        else
                                ++iterTeams;
                }
                iterMinNr++;
        }
}

void TestHelper::Cerinta3(list<Team> &teams, deque<Match> &matches,
                          stack<Team> &winners, stack<Team> &losers,
                          ofstream &output, stack<Team> &top8)
{
        int roundNr;
        int maxRoundNr = 0;
        int exp = 1;
        while (exp < teams.size())
        {
                exp *= 2;
                maxRoundNr++;
        }
        list<Team>::iterator iterTeams;
        //incarcam echipele din lista pentru runda1
        output << "\n--- ROUND NO:" << 1 << '\n';
        for (iterTeams = teams.begin(); iterTeams != teams.end(); ++iterTeams)
        {
                Team tmp1 = *(iterTeams);
                Team tmp2 = *(++iterTeams);
                matches.push_back(Match(tmp1, tmp2));
                output << matches.back();
                matches.back().play();
        }
        //extragem castigatorii si invinsii
        for (roundNr = 1; roundNr <= maxRoundNr; roundNr++)
        {
                while (matches.size() != 0)
                {
                        //incarcam stack-urile si descarcam coada
                        winners.push(matches.front().getWinner());
                        losers.push(matches.front().getLoser());
                        matches.pop_front();
                }
                //salvam clasamentul pentru subpunctele urmatoare
                if (winners.size() == 8)
                        top8 = winners;
                output << "\nWINNERS OF ROUND NO:" << roundNr << '\n';
                while (winners.size() > 1)
                {
                        //descarcam stack-ul si introducem in coada
                        Team tmp1 = winners.top();
                        printWinner(tmp1, output);
                        winners.pop();
                        Team tmp2 = winners.top();
                        printWinner(tmp2, output);
                        winners.pop();
                        matches.push_back(Match(tmp1, tmp2));
                        matches.back().play();
                }
                if (winners.size() == 1)
                {
                        printWinner(winners.top(), output);
                }
                else
                {
                        output << "\n--- ROUND NO:" << roundNr + 1 << '\n';
                        deque<Match>::iterator iterDequeMatches;
                        for (iterDequeMatches = matches.begin();
                             iterDequeMatches != matches.end();
                             ++iterDequeMatches)
                        {
                                output << (*iterDequeMatches);
                        }
                }
        }
}

void TestHelper::Cerinta4(stack<Team> &unsortedWinners,
                          set<Team, struct compareTeams> &sortedWinners,
                          ofstream &output)
{
        //descarcam stack si incarcam in set-ul cu comparator custom
        while (unsortedWinners.size() != 0)
        {
                sortedWinners.insert(unsortedWinners.top());
                unsortedWinners.pop();
        }
        output << "\nTOP 8 TEAMS:\n";
        set<Team, struct compareTeams>::iterator iterW;
        for (iterW = sortedWinners.begin(); iterW != sortedWinners.end(); ++iterW)
        {
                Team tmp = *iterW;
                printWinner(tmp, output);
        }
}

void TestHelper::Cerinta5(set<Team, struct compareTeams> &sortedWinners,
                          ofstream &output)
{

        output << "\nTHE LEVEL 2 TEAMS ARE:\n";
        set<Team, struct compareTeams>::iterator iterW = sortedWinners.begin();
        for (int i = 0; i < 4; i++)
        {
                output << *iterW << '\n';
                iterW = next(iterW, 2);
        }
}