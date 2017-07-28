//
//  Pawn.h
//  WhiteKing
//
//  Created by admin on 13.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "Figure.h"

typedef NS_ENUM(NSInteger, PawnDirection)
{
    upPawnDirection = -1,
    downPawnDirection = 1
};

@interface Pawn : Figure
@property (assign,nonatomic) PawnDirection direction;
@end
