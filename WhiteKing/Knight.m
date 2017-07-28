//
//  Knight.m
//  WhiteKing
//
//  Created by admin on 09.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "Knight.h"

@implementation Knight


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
    if((ABS(self.rowNum - row) == 2 && ABS(self.colNum - column) == 1 ) || (ABS(self.rowNum - row) == 1 && ABS(self.colNum - column) == 2))
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
            self.image = [UIImage imageNamed:@"knight-red"];;
            break;
        case blackPlayerColor:
            self.image = [UIImage imageNamed:@"knight-blue"];;
            break;
    }
}
@end
