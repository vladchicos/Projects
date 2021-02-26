#pragma once
#include "team.hpp"
struct compareTeams
{
        bool operator()(const Team &, const Team &) const;
};