//
//  Figure.h
//  WhiteKing
//
//  Created by admin on 02.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colors.h"

@protocol FigureDelegate <NSObject>
- (BOOL) isCellEmptyAtRow: (NSInteger)rowNum andColNum: (NSInteger)colNum;
@end

@interface Figure : UIImageView
{
@protected
    UIImage *_figureWhiteImage;
    UIImage *_figureBlackImage;
}
- (instancetype) initWithSize:(CGSize)size andColor:(PlayerColor)color;
- (BOOL) isReachableRow: (int) row andColumn: (int) column;
- (BOOL) isWayClearToCellAtRow: (int)row andColumn: (int)column;
- (void) moveToRowNum: (NSInteger)row andColNum: (NSInteger)column;
- (void) updateFigurePicture;
- (BOOL) canDestroyFigureAtCellAtRow: (NSInteger)row andColumn:(NSInteger)column;

@property (assign, nonatomic) NSInteger rowNum;
@property (assign, nonatomic) NSInteger colNum;
@property (weak, nonatomic) id<FigureDelegate> delegate;
@property (assign, nonatomic) PlayerColor figureColor;


@end
