//
//  HistoryView.m
//  WhiteKing
//
//  Created by admin on 28.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "HistoryTableViewCell.h"

@implementation HistoryTableViewCell
{
    UIView *_contentView;
}

-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _contentView.frame = self.bounds;
}

-(void) setContentView:(UIView*)contentView {
    [_contentView removeFromSuperview];
    _contentView = contentView;
    [self addSubview:_contentView];
}

@end
