//
//  Cell.h
//  WhiteKing
//
//  Created by admin on 04.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Figure.h"
#import "Colors.h"

@interface Cell : UIView
- (instancetype) initWithRowNum: (NSInteger) rowNum andColNum:(NSInteger) colNum;
- (void) setCellColor: (CellColor)cellColor;
- (void) highlightCell;
- (void) unHighlightCell;

@property (assign, nonatomic) NSInteger rowNum;
@property (assign, nonatomic) NSInteger colNum;

@end
