/* 
 * File:   piece.h
 * Author: samuel
 *
 * Created on 07 June 2013, 12:11
 */

#ifndef PIECE_H
#define	PIECE_H

#include <vector>

enum piece_type {
    KNIGHT,
    ROOK,
    BISHOP,
    QUEEN,
    KING,
    PAWN
};

enum team {
    BLACK,
    WHITE
};

class piece {
public:
    piece();
    virtual ~piece();
    virtual std::vector<int> getMoves(void);
    
    void setPosition(int position);
    int getPosition() const;
    
    void setType(piece_type type);
    piece_type getType() const;
private:
    piece_type type;
    int position;

};

#endif	/* PIECE_H */

