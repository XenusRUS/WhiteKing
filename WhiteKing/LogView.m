//
//  LogView.m
//  WhiteKing
//
//  Created by admin on 23.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "LogView.h"

static const NSInteger kFigureImageSize = 30;
static const NSInteger kLabelSize = 30;

@implementation LogView
{
    UIImageView* _figureLogImage;
    UILabel *_moveFigureLogLabel;
    UILabel *_timeLogLabel;
    UILabel *_killLogLabel;
    UIImageView *_figureKilledLogImage;

}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self createFigureLogImage];
        [self createMoveLogLabel];
        [self timeLogLabel];
        [self setupKilledFigureImageView];
        [self killLogLabel];

    }
    return self;
}

- (void)createFigureLogImage
{
    _figureLogImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, kFigureImageSize, kFigureImageSize)];
    [self addSubview:_figureLogImage];
}

- (void)createMoveLogLabel
{
    _moveFigureLogLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLabelSize+5, 5, kLabelSize, kLabelSize)];
    [_moveFigureLogLabel sizeToFit];
    [self addSubview:_moveFigureLogLabel];
}

- (void) timeLogLabel
{
    _timeLogLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - kLabelSize*1.5, 5, kLabelSize, kLabelSize)];
    [_timeLogLabel sizeToFit];
    [self addSubview:_timeLogLabel];
}

- (void) killLogLabel
{
    _killLogLabel = [[UILabel alloc] initWithFrame:CGRectMake(4*kLabelSize, 5, kLabelSize, kLabelSize)];
    _killLogLabel.text = @"and has killed";
    _killLogLabel.hidden = YES;
    [_killLogLabel sizeToFit];
    [self addSubview:_killLogLabel];
}

-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _timeLogLabel.frame = CGRectMake(frame.size.width - kLabelSize*1.5, 5, kLabelSize, kLabelSize);
    [_timeLogLabel sizeToFit];
}

- (void) setupKilledFigureImageView
{
    _figureKilledLogImage = [[UIImageView alloc] initWithFrame:CGRectMake(kLabelSize*8, 2, kFigureImageSize, kFigureImageSize)];
    [self addSubview:_figureKilledLogImage];
}

- (void) updateWithLogEvent:(LogEvent *)event
{
    NSInteger minutes = floor(event.time/60);
    NSInteger seconds = (NSInteger)event.time % 60;
    _figureLogImage.image = event.figureImage;
    _moveFigureLogLabel.text = [NSString stringWithFormat:@"%@%@ - %@%@", event.colFrom, event.rowFrom, event.colTo, event.rowTo];
    [_moveFigureLogLabel sizeToFit];
    _timeLogLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", minutes, seconds];
    [_timeLogLabel sizeToFit];
    if (event.isSomeFigureKilled) {
        _killLogLabel.hidden = NO;
        _figureKilledLogImage.image = event.killedFigureImage;
        _figureKilledLogImage.hidden = NO;
    }
    else {
        _killLogLabel.hidden = YES;
        _figureKilledLogImage.hidden = YES;
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
//moveFrom:(UILabel*)moveFrom moveTo:(UILabel*)moveTo withTime:(UILabel*)time