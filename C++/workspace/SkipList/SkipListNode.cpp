/*
 * ListNode.cpp
 *
 *  Created on: 6 Jul 2013
 *      Author: samuel
 */

#include "SkipListNode.h"

SkipListNode::SkipListNode(double data, const int level)
  : m_data(data)
{


}

SkipListNode::~SkipListNode()
{

}

double SkipListNode::getData() const
{
  return m_data;
}

void SkipListNode::setForward(const int index, SkipListNode* node)
{
  m_forward[index] = node;
}

SkipListNode* SkipListNode::getForward(const int index) const
{
  return m_forward[index];
}

void SkipListNode::setData(double data)
{
  m_data = data;
}
