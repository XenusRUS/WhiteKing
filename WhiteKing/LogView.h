//
//  LogView.h
//  WhiteKing
//
//  Created by admin on 23.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogEvent.h"

@interface LogView : UIView
- (void) updateWithLogEvent:(LogEvent *)event;
@end
