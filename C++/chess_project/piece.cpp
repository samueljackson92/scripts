/* 
 * File:   piece.cpp
 * Author: samuel
 * 
 * Created on 07 June 2013, 12:11
 */

#include "piece.h"

piece::piece() {
}

void piece::setPosition(int position) {
    this->position = position;
}

int piece::getPosition() const {
    return position;
}

void piece::setType(piece_type type) {
    this->type = type;
}

piece_type piece::getType() const {
    return type;
}

piece::~piece() {
}

