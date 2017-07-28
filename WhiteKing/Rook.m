//
//  Rook.m
//  WhiteKing
//
//  Created by admin on 13.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "Rook.h"

@implementation Rook

- (instancetype) initWithSize:(CGSize)size andColor:(PlayerColor)color {
    self = [super initWithSize:size andColor:color];
    if( self != nil)
    {

        
    }
    return self;
}

- (BOOL) isReachableRow: (int) row andColumn: (int) column
{
    if ((row-self.rowNum==0) || (column-self.colNum==0))
    {
        return YES;
    }
    return NO;
}

- (BOOL) isWayClearToCellAtRow: (int)row andColumn: (int)column
{
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

-(void) updateFigurePicture
{
    switch (self.figureColor) {
        case whitePlayerColor:
            self.image = [UIImage imageNamed:@"rook-red"];;
            break;
        case blackPlayerColor:
            self.image = [UIImage imageNamed:@"rook-blue"];;
            break;
    }
}
@end
