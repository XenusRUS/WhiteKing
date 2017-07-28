//
//  Cell.m
//  WhiteKing
//
//  Created by admin on 04.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "Cell.h"

@implementation Cell
{
    Figure* _figure;
    CellColor _cellColor;
}

- (instancetype) initWithRowNum: (NSInteger) rowNum andColNum:(NSInteger) colNum
{
    self = [super init];
    if (self != nil) {
        _rowNum = rowNum;
        _colNum = colNum;
    }
    return self;
}


- (void) setCellColor: (CellColor)cellColor
{
    _cellColor = cellColor;
    [self updateBackgroundColor];
}

- (void) updateBackgroundColor
{
    
    switch (_cellColor) {
        case kBlackCellColor:
            self.backgroundColor = [UIColor blackColor];
            break;
        case kWhiteCellColor:
            self.backgroundColor = [UIColor whiteColor];
            break;
    }
}

- (void) highlightCell {
    self.backgroundColor = [UIColor yellowColor];
}

-(void) unHighlightCell {
    [self updateBackgroundColor];
}
@end
