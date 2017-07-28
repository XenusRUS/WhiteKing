//
//  LogManager.h
//  WhiteKing
//
//  Created by admin on 21.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogEvent.h"


@interface LogManager : NSObject

- (void) saveLastEventWith:(UIImage *)figureImage
                andRowFrom:(NSInteger)rowFrom
                andColFrom:(NSInteger)colFrom
                  andRowTo:(NSInteger)rowTo
                  andColTo:(NSInteger)colTo
                   andTime:(CGFloat)time;

- (void) saveLastEventWith:(UIImage *)figureImage
                andRowFrom:(NSInteger)rowFrom
                andColFrom:(NSInteger)colFrom
                  andRowTo:(NSInteger)rowTo
                  andColTo:(NSInteger)colTo
                   andTime:(CGFloat)time
      andFigureKilledImage:(UIImage*)figureKilledImage;
- (NSMutableArray *) getLastEvents;
- (NSMutableArray *) getAllEvents;
@end
