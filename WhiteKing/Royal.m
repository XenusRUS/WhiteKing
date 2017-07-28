//
//  Royal.m
//  WhiteKing
//
//  Created by admin on 09.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "Royal.h"

@implementation Royal
- (instancetype) initWithSize:(CGSize)size andColor:(PlayerColor)color {
    self = [super initWithSize:size andColor:color];
    if( self != nil)
    {

    }
    return self;
}

- (BOOL) isReachableRow: (int) row andColumn: (int) column
{
    if(ABS((self.rowNum - row)) == ABS((self.colNum - column)))
    {
        return YES;
    }
    return NO;
}

- (BOOL) isWayClearToCellAtRow: (int)row andColumn: (int)column
{
    NSInteger stepLength = ABS(self.rowNum-row);
    NSInteger rowIncrement = row<self.rowNum ? -1 : 1;
    NSInteger colIncrement = column<self.colNum ? -1 : 1;
    for (NSInteger deltaRow=rowIncrement, deltaCol=colIncrement; ABS(deltaRow)<stepLength || ABS(deltaCol)<stepLength; deltaRow = deltaRow + rowIncrement, deltaCol=deltaCol+colIncrement) {
        BOOL isCellEmpty = [self.delegate isCellEmptyAtRow:self.rowNum+deltaRow andColNum:self.colNum+deltaCol];
        if (isCellEmpty == NO) {
            return NO;
        }
    }
    return YES;
}

-(void) updateFigurePicture
{
    switch (self.figureColor) {
        case whitePlayerColor:
            self.image = [UIImage imageNamed:@"royal-red"];;
            break;
        case blackPlayerColor:
            self.image = [UIImage imageNamed:@"royal-blue"];;
            break;
    }
}

@end
