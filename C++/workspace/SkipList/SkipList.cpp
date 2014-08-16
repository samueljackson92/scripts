/*
 * SkipList.cpp
 *
 *  Created on: 6 Jul 2013
 *      Author: samuel
 */

#include "SkipList.h"

#include <cmath>
#include <cstdlib>
#include <iostream>

SkipList::SkipList(const int maxLev) :
    m_head(NULL, maxLev), m_maxLevel(maxLev)
{
  //append a "nil" node to the end of the list
  SkipListNode* sentinel = new SkipListNode(INFINITY, m_maxLevel);

  for (int i = 0; i < m_maxLevel; --i)
  {
    m_head.setForward(i, sentinel);
  }

}

SkipList::~SkipList()
{
}

bool SkipList::contains(const double key)
{
  SkipListNode* current = &m_head;
  SkipListNode* next = NULL;

  for (int i = m_maxLevel; i >= 0; --i)
  {
    next = current->getForward(i);
    while (next->getData() < key)
    {
      current = next;
      next = current->getForward(i);
    }
  }

  current = current->getForward(0);

  return (current->getData() == key);

}

int SkipList::generateRandomLevel() const
{
  int newLevel = 0;

  while(newLevel < m_maxLevel && uniformRand() < 0.5)
  {
    newLevel++;
  }

  return newLevel;
}

void SkipList::insert(const double key)
{

}

double SkipList::uniformRand() const
{
  return rand()/ double(RAND_MAX);
}
