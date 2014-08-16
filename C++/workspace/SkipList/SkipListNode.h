#ifndef LISTNODE_H_
#define LISTNODE_H_

/*
 * ListNode.h
 *
 *  Created on: 6 Jul 2013
 *      Author: samuel
 */

class SkipListNode
{
public:
  SkipListNode(double data, const int level);
  virtual ~SkipListNode();

  void setForward(const int index, SkipListNode* node);
  SkipListNode* getForward(const int index) const;

  double getData() const;
  void setData(double data);

private:
  double m_data;
  SkipListNode* m_forward[];
};

#endif /* LISTNODE_H_ */
