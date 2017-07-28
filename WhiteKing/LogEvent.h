//
//  LogEvent.h
//  WhiteKing
//
//  Created by admin on 21.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LogEvent : NSObject
@property(strong,nonatomic) UIImage *figureImage;
@property(strong,nonatomic) NSString *rowFrom;
@property(strong,nonatomic) NSString *rowTo;
@property(strong,nonatomic) NSString *colFrom;
@property(strong,nonatomic) NSString *colTo;
@property(strong,nonatomic) UIImage *killedFigureImage;
@property(assign,nonatomic) BOOL isSomeFigureKilled;
@property(assign,nonatomic) CGFloat time;
@end
