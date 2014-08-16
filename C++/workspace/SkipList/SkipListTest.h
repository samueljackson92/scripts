#ifndef SKIPLISTTEST_H_
#define SKIPLISTTEST_H_

#include <cxxtest/TestSuite.h>

class SkipListTest : public CxxTest::TestSuite
{
public:
  void testInsert() {
    SkipList list;
    list.insert(5);

    TS_ASSERT(list.contains(5));
  }
};

#endif /*SKIPLISTTEST_H_*/
