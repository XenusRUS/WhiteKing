//
//  ViewController.h
//  WhiteKing
//
//  Created by admin on 02.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"
#import "HistoryViewController.h"

@interface GameManager : UIViewController <BoardDelegate,HistoryViewControllerDelegate>


@property (nonatomic, assign) IBOutlet UILabel * label;

@end

