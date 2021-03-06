/*
 * SkipList.h
 *
 *  Created on: 6 Jul 2013
 *      Author: samuel
 */

#ifndef SKIPLIST_H_
#define SKIPLIST_H_

#include "SkipListNode.h"

class SkipList
{
public:
	SkipList(const int maxLevel);
	virtual ~SkipList();

	void insert(const double key);
	bool contains(const double key);
	bool remove();
	bool isEmpty();
	void printOut();

private:
	SkipListNode m_head;
	const int m_maxLevel;

	int generateRandomLevel() const;
	double uniformRand() const;
};

#endif /* SKIPLIST_H_ */
