//
//  Figure.m
//  WhiteKing
//
//  Created by admin on 02.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "Figure.h"


@implementation Figure
{
    
}

- (instancetype) initWithSize:(CGSize)size andColor:(PlayerColor)color
{
    self = [super init];
    if (self != nil)
    {
        self.frame = CGRectMake(0, 0, size.width, size.height);
        self.contentMode = UIViewContentModeScaleToFill;
        self.figureColor = color;
        [self updateFigurePicture];
    }
    
    return self;
}

- (BOOL) isReachableRow: (int) row andColumn: (int) column
{
    return YES;
}

- (BOOL) isWayClearToCellAtRow: (NSInteger)row andColumn: (NSInteger)column
{
    return YES;
}

- (void) moveToRowNum: (NSInteger)row andColNum: (NSInteger)column {
    self.rowNum = row;
    self.colNum = column;
}

-(void) updateFigurePicture
{
//    switch (_figureColor) {
//        case whitePlayerColor:
//            self.image = _figureWhiteImage;
//            break;
//        case blackPlayerColor:
//            self.image = _figureBlackImage;
//            break;
//    }
}

- (BOOL) canDestroyFigureAtCellAtRow: (NSInteger)row andColumn:(NSInteger)column {
    return ([self isReachableRow:row andColumn:column] && [self isWayClearToCellAtRow:row andColumn:column]);
}

@end
