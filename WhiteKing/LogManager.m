//
//  LogManager.m
//  WhiteKing
//
//  Created by admin on 21.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "LogManager.h"
#import "CoordinatesNaming.h"

static const NSInteger kEventsCountToReturn = 3;

@implementation LogManager
{
    LogEvent *_lastEvent;
    NSMutableArray *_logEventsArray;
}

- (instancetype) init {
    self = [super init];
    if (self != nil) {
        _logEventsArray = [NSMutableArray new];
    }
    return self;
}

- (void) saveLastEventWith:(UIImage *)figureImage
                andRowFrom:(NSInteger)rowFrom
                andColFrom:(NSInteger)colFrom
                  andRowTo:(NSInteger)rowTo
                  andColTo:(NSInteger)colTo
                   andTime:(CGFloat)time
{
    _lastEvent = [LogEvent new];
    _lastEvent.figureImage = figureImage;
    _lastEvent.rowFrom = kRowsNames[rowFrom];
    _lastEvent.colFrom = kColumnsNames[colFrom];
    _lastEvent.rowTo = kRowsNames[rowTo];
    _lastEvent.colTo = kColumnsNames[colTo];
    _lastEvent.time = time;
    _lastEvent.isSomeFigureKilled = NO;
    
    [_logEventsArray addObject:_lastEvent];

}

- (void) saveLastEventWith:(UIImage *)figureImage
                andRowFrom:(NSInteger)rowFrom
                andColFrom:(NSInteger)colFrom
                  andRowTo:(NSInteger)rowTo
                  andColTo:(NSInteger)colTo
                   andTime:(CGFloat)time
      andFigureKilledImage:(UIImage*)figureKilledImage
{
    _lastEvent = [LogEvent new];
    _lastEvent.figureImage = figureImage;
    _lastEvent.rowFrom = kRowsNames[rowFrom];
    _lastEvent.colFrom = kColumnsNames[colFrom];
    _lastEvent.rowTo = kRowsNames[rowTo];
    _lastEvent.colTo = kColumnsNames[colTo];
    _lastEvent.time = time;
    _lastEvent.killedFigureImage =  figureKilledImage;
    _lastEvent.isSomeFigureKilled = YES;
    
    [_logEventsArray addObject:_lastEvent];
}

-(NSMutableArray *) getLastEvents
{
    NSMutableArray *lastEvents = [NSMutableArray new];
    NSInteger maxEventsCount = MIN(kEventsCountToReturn, _logEventsArray.count);
    for (NSInteger i=0; i<maxEventsCount; i++) {
        LogEvent *currentEvent = _logEventsArray[_logEventsArray.count-i-1];
        [lastEvents addObject:currentEvent];
    }
    return lastEvents;
}

- (NSMutableArray *) getAllEvents {
    return _logEventsArray;
}

@end
