//
//  Board.h
//  WhiteKing
//
//  Created by admin on 02.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Figure.h"
#import "King.h"
#import "Cell.h"

typedef NS_ENUM(NSInteger, KingSituation) {
    noState = 0,
    check = 1,
    mate = 2,
    stalemate = 3
};

@protocol BoardDelegate <NSObject>
- (KingSituation) checkKingOnMate: (King *)king;
- (void) playerTurnEndWithFigure:(Figure*)figure fromCell:(Cell *)fromCell ToCell:(Cell*)toCell figureKilled:(Figure*)figureKilled;
- (PlayerColor) getCurrentPlayer;
@end

@interface Board : UIView <FigureDelegate>
- (BOOL) isCellEmptyAtRow: (NSInteger)rowNum andColNum: (NSInteger)colNum;
- (Cell *) findCellByRow:(NSInteger) row ByColumn:(NSInteger) column;
- (BOOL) isCellUnderFire:(Cell *)cell byFiguresOfColor:(PlayerColor)enemyFigureColor kingCell:(BOOL)kingCell;
- (BOOL) isCellFilled: (Cell*)cell byFigureOfColor:(PlayerColor)color;
@property (weak,nonatomic) id<BoardDelegate>delegate;
@end
