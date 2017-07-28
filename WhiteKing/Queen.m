//
//  Queen.m
//  WhiteKing
//
//  Created by admin on 13.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "Queen.h"

@implementation Queen

- (instancetype) initWithSize:(CGSize)size andColor:(PlayerColor)color
 {
    self = [super initWithSize:size andColor:color];
    if( self != nil)
    {

        
    }
    return self;
}

- (BOOL) isReachableRow: (int) row andColumn: (int) column
{
    if ((ABS((self.rowNum - row)) == ABS((self.colNum - column))) || ((row-self.rowNum==0) || (column-self.colNum==0)))
    {
        return YES;
    }
    return NO;
}

- (BOOL) isWayClearToCellAtRow: (int)row andColumn: (int)column
{
    if (self.colNum == column) {
        for (NSInteger tempRow = MIN(self.rowNum, row); tempRow<=MAX(self.rowNum, row); tempRow++) {
            if (self.rowNum != tempRow || self.colNum != column)
            {
                if (tempRow != row) {
                    BOOL isCellEmpty = [self.delegate isCellEmptyAtRow:tempRow andColNum:column];
                    if (isCellEmpty==NO) {
                        return NO;
                    }
                }
            }
        }
        return YES;
    }
    if (self.rowNum==row) {
        for (NSInteger tempCol = MIN(self.colNum, column); tempCol<=MAX(self.colNum, column); tempCol++) {
            if (self.rowNum != row || self.colNum != tempCol)
            {
                if (tempCol != column) {
                    BOOL isCellEmpty = [self.delegate isCellEmptyAtRow:row andColNum:tempCol];
                    if (isCellEmpty==NO) {
                        return NO;
                    }
                }
            }
        }
        return YES;
    }
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
            self.image = [UIImage imageNamed:@"queen-red"];;
            break;
        case blackPlayerColor:
            self.image = [UIImage imageNamed:@"queen-blue"];;
            break;
    }
}

@end
