//
//  HistoryViewController.h
//  WhiteKing
//
//  Created by admin on 28.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HistoryViewControllerDelegate <NSObject>
- (NSArray*) getHistory;
@end

@interface HistoryViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
- (instancetype) initWithViewFrame: (CGRect)frame;
@property(weak,nonatomic) id<HistoryViewControllerDelegate>delegate;
@end
