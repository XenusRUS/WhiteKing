//
//  Pawn.m
//  WhiteKing
//
//  Created by admin on 13.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "Pawn.h"

@implementation Pawn
{
    BOOL _isFirstMoveDone;
}

- (instancetype) initWithSize:(CGSize)size andColor:(PlayerColor)color {
    self = [super initWithSize:size andColor:color];
    if (self != nil) {
        _isFirstMoveDone = NO;
    }
    return self;
}


- (BOOL) isReachableRow: (int) row andColumn: (int) column
{
    if(((row-self.rowNum)*_direction == 1) && (self.colNum-column == 0))
    {
        return YES;
    }
    else if(((row-self.rowNum)*_direction == 2) && (self.colNum-column == 0) && _isFirstMoveDone == NO)
    {
        return YES;
    }
    else if ((row-self.rowNum==_direction) && (ABS(column-self.colNum)==1) && ([self.delegate isCellEmptyAtRow:row andColNum:column]==NO)) {
        return YES;
    }
    return NO;
}

- (BOOL) isWayClearToCellAtRow: (NSInteger)row andColumn: (NSInteger)column
{
    if (self.colNum == column) {
        NSInteger stepLength = ABS(self.rowNum-row);
        for (NSInteger deltaRow = _direction; ABS(deltaRow)<= stepLength; deltaRow = deltaRow + _direction) {
            BOOL isCellEmpty = [self.delegate isCellEmptyAtRow:self.rowNum + deltaRow andColNum:self.colNum];
            if (isCellEmpty==NO) {
                return NO;
            }
        }
    }
    
    return YES;
}

- (void) moveToRowNum:(NSInteger)row andColNum:(NSInteger)column {
    [super moveToRowNum:row andColNum:column];
    _isFirstMoveDone = YES;
}

-(void) updateFigurePicture
{
    switch (self.figureColor) {
        case whitePlayerColor:
            self.image = [UIImage imageNamed:@"pawn-red"];;
            break;
        case blackPlayerColor:
            self.image = [UIImage imageNamed:@"pawn-blue"];;
            break;
    }
}

- (BOOL) canDestroyFigureAtCellAtRow: (NSInteger)row andColumn:(NSInteger)column {
    BOOL result = YES;
    result = result && (row-self.rowNum==_direction);
    result = result && (ABS(column-self.colNum)==1);
    result = result && ([self.delegate isCellEmptyAtRow:row andColNum:column]==NO);
    result = result && [self isWayClearToCellAtRow:row andColumn:column];
    return  result;
}
@end
