//
//  King.m
//  WhiteKing
//
//  Created by admin on 13.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "King.h"

@implementation King

- (instancetype) initWithSize:(CGSize)size andColor:(PlayerColor)color {
    self = [super initWithSize:size andColor:color];
    if( self != nil)
    {

        
    }
    return self;
}

- (BOOL) isReachableRow: (int) row andColumn: (int) column
{
//    if (((row-_rowNum == 0) && (abs(_colNum-column) == 1)) || ((abs(row-_rowNum) == 1) && (_colNum-column == 0)) || (abs(_rowNum - row) == (abs((_colNum - column)) && (abs(_rowNum - row)==1))))
    if(((ABS(row-self.rowNum) == 1) && (ABS(self.colNum-column) == 1)) || ((ABS(row-self.rowNum) == 0) && (ABS(self.colNum-column) == 1)) || ((ABS(row-self.rowNum) == 1) && (ABS(self.colNum-column) == 0)))
    {
        return YES;
    }
    return NO;
}

- (BOOL) isWayClearToCellAtRow: (int)row andColumn: (int)column
{
    return YES;
}

-(void) updateFigurePicture
{
    switch (self.figureColor) {
        case whitePlayerColor:
            self.image = [UIImage imageNamed:@"king-red"];;
            break;
        case blackPlayerColor:
            self.image = [UIImage imageNamed:@"king-blue"];;
            break;
    }
}
@end
