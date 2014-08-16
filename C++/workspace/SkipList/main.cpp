/*
 * main.cpp
 *
 *  Created on: 6 Jul 2013
 *      Author: samuel
 */

#include "SkipList.h"

#include <iostream>

int main(int argc, char** argv) {
  SkipList list;
  list.insert(5);
  list.insert(4);
  list.insert(10);
  list.insert(6);

  list.printOut();
}



