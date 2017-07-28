//
//  ViewController.m
//  WhiteKing
//
//  Created by admin on 02.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "GameManager.h"
#import "Board.h"
#import "Figure.h"
#import "TurnManager.h"
#import "LogManager.h"
#import "LogView.h"

static const CGFloat kLogViewHeight = 34;

@interface GameManager ()

@end
@implementation GameManager {
    Board *_board;
    NSTimer *_whiteTimer;
    NSTimer *_blackTimer;
    CGFloat _totalWhiteTime;
    CGFloat _totalBlackTime;
    TurnManager *_turnManager;
    UILabel *_currentPlayerLabel;
    UILabel *_whiteTimeLabel;
    UILabel *_blackTimeLabel;
    LogManager *_logManager;
    NSTimer *_totalTimer;
    CGFloat _totalTime;
    LogView *_lastEventView;
    LogView *_preLastEventView;
    LogView *_prePreLastEventView;
    HistoryViewController *_historyViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //board set up
    [self createGameBorder];
    
    
    _turnManager = [[TurnManager alloc]init];
    [self setupPlayerLabel];
    
    [self setupTimers];
    [self setupTimeLabels];
    
    _logManager = [LogManager new];
    
    //--
    [self createLogView];
    [self setupHistoryViewController];
    [self createViewHistoryButton];
}

- (void) fullHistoryButtonAction {
    [self.view addSubview:_historyViewController.view];
}

- (void) createViewHistoryButton {
    UIButton *fullHistoryButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
    fullHistoryButton.backgroundColor = [UIColor redColor];
    [fullHistoryButton setTitle:@"Show History" forState:UIControlStateNormal];
    [fullHistoryButton addTarget:self action:@selector(fullHistoryButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fullHistoryButton];
}

- (void) setupHistoryViewController {
    _historyViewController = [[HistoryViewController alloc] initWithViewFrame:self.view.frame];
    _historyViewController.delegate = self;
}

- (void)createGameBorder
{
    _board = [[Board alloc] init];
    //    board.clipsToBounds = YES;
    _board.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height*0.5);
    [self.view addSubview:_board];
    
    _board.delegate = self;

}

- (void)createLogView
{
    _lastEventView = [[LogView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-3*kLogViewHeight, self.view.frame.size.width, kLogViewHeight)];
    [_lastEventView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:_lastEventView];
    
    _preLastEventView = [[LogView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-2*kLogViewHeight, self.view.frame.size.width, kLogViewHeight)];
    [_preLastEventView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:_preLastEventView];
    
    _prePreLastEventView = [[LogView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-kLogViewHeight, self.view.frame.size.width, kLogViewHeight)];
    [_prePreLastEventView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:_prePreLastEventView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupPlayerLabel {
    _currentPlayerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    _currentPlayerLabel.textAlignment = NSTextAlignmentCenter;
    _currentPlayerLabel.font = [UIFont fontWithName:nil size:20.0f];
    _currentPlayerLabel.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height*0.15);
    [self.view addSubview:_currentPlayerLabel];
    [self updatePlayerLabel];
}

- (void) setupTimers {
    _whiteTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateWhiteTotalTime) userInfo:nil repeats:YES];
    _totalWhiteTime = 0;
    _totalBlackTime = 0;
    
    _totalTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTotalTime) userInfo:nil repeats:YES];
    _totalTime = 0;
}

- (void) updateTotalTime {
    _totalTime += 1;
}

- (void) setupTimeLabels {
    _whiteTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    _whiteTimeLabel.textAlignment = NSTextAlignmentCenter;
    _whiteTimeLabel.font = [UIFont fontWithName:nil size:10.0f];
    _whiteTimeLabel.center = CGPointMake(self.view.frame.size.width*0.5,self.view.frame.size.height*0.8);
    _whiteTimeLabel.textColor = [UIColor redColor];
    [self.view addSubview:_whiteTimeLabel];
    
    _blackTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    _blackTimeLabel.textAlignment = NSTextAlignmentCenter;
    _blackTimeLabel.font = [UIFont fontWithName:nil size:10.0f];
    _blackTimeLabel.center = CGPointMake(self.view.frame.size.width*0.5,self.view.frame.size.height*0.2);
    _blackTimeLabel.textColor = [UIColor blueColor];
    [self.view addSubview:_blackTimeLabel];
    [self updateTimeLabels];
}

- (void) updateTimeLabels {
    NSInteger whiteTimeMinutes = floor(_totalWhiteTime / 60);
    NSInteger whiteTimeSeconds = (NSInteger)_totalWhiteTime % 60;
    _whiteTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",whiteTimeMinutes,whiteTimeSeconds];
    
    NSInteger blackTimeMinutes = floor(_totalBlackTime / 60);
    NSInteger blackTimeSeconds = (NSInteger)_totalBlackTime % 60;
    _blackTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",blackTimeMinutes,blackTimeSeconds];
}

- (void) updateWhiteTotalTime {
    _totalWhiteTime += 1;
    [self updateTimeLabels];
 }

- (void) updateBlackTotalTime {
    _totalBlackTime += 1;
    [self updateTimeLabels];
}

- (void) updatePlayerLabel {
    NSString* currentPlayerString = [_turnManager getCurrentPlayerString];
    _currentPlayerLabel.text = currentPlayerString;
    PlayerColor currentPlayerColor = [_turnManager getCurrentPlayer];
    switch (currentPlayerColor) {
        case whitePlayerColor:
            _currentPlayerLabel.textColor = [UIColor redColor];
            break;
        case blackPlayerColor:
            _currentPlayerLabel.textColor = [UIColor blueColor];
            break;
    }
}

- (NSMutableArray *) cellsAroundKing:(King *)king {
    NSMutableArray *cellsAroundKing = [NSMutableArray new];
    for (NSInteger deltaRow=-1; deltaRow<2; deltaRow++) {
        for (NSInteger deltaCol=-1; deltaCol<2; deltaCol++) {
            NSInteger row = king.rowNum + deltaRow;
            NSInteger col = king.colNum + deltaCol;
            Cell *cell = [_board findCellByRow:row ByColumn:col];
            if (cell) {
                [cellsAroundKing addObject:cell];
            }
        }
    }
    return cellsAroundKing;
}

#pragma mark - BoardDelegate
- (KingSituation) checkKingOnMate:(King *)king {
    NSMutableArray *cellsAroundKing = [self cellsAroundKing:king];
    NSMutableArray *freeCells = [NSMutableArray new];
    NSMutableArray *safeCells = [NSMutableArray new];
    PlayerColor enemyColor = 0;
    switch (king.figureColor) {
        case whitePlayerColor:
            enemyColor = blackPlayerColor;
            break;
        case blackPlayerColor:
            enemyColor = whitePlayerColor;
            break;
    }
    for (NSInteger i=0; i<cellsAroundKing.count; i++) {
        Cell *currentCell = cellsAroundKing[i];
        BOOL isCellFilled = [_board isCellFilled:currentCell byFigureOfColor:king.figureColor];
        BOOL isCellUnderFire = [_board isCellUnderFire:currentCell byFiguresOfColor:enemyColor kingCell:NO];
        if (!isCellFilled) {
            [freeCells addObject:currentCell];
            if (!isCellUnderFire) {
                [safeCells addObject:currentCell];
            }
        }
    }
    Cell *kingCell = [_board findCellByRow:king.rowNum ByColumn:king.colNum];
    BOOL isKingCellUnderFire = [_board isCellUnderFire:kingCell byFiguresOfColor:enemyColor kingCell:YES];
    BOOL isFreeCells = (freeCells.count==0) ? NO:YES;
    BOOL isSafeCells = (safeCells.count!=0);
    if (isKingCellUnderFire && isSafeCells)
    {
        return check;
    }
    else if (!isKingCellUnderFire && isFreeCells && !isSafeCells) {
        return stalemate;
    }
    else if (isKingCellUnderFire && !isSafeCells && !isFreeCells) {
        return mate;
    }
    else
    {
        return noState;
    }
}

- (void) playerTurnEndWithFigure:(Figure*)figure fromCell:(Cell *)fromCell ToCell:(Cell*)toCell figureKilled:(Figure*)figureKilled{
    PlayerColor currentPlayerColor = [_turnManager getCurrentPlayer];
    switch (currentPlayerColor) {
        case whitePlayerColor:
            [_whiteTimer invalidate];
            _blackTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateBlackTotalTime) userInfo:nil repeats:YES];
            break;
        case blackPlayerColor:
            [_blackTimer invalidate];
            _whiteTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateWhiteTotalTime) userInfo:nil repeats:YES];
            break;
    }
    [_turnManager changePlayerToNext];
    [self updatePlayerLabel];
    
    if (figureKilled == nil) {
        [_logManager saveLastEventWith:figure.image andRowFrom:fromCell.rowNum andColFrom:fromCell.colNum andRowTo:toCell.rowNum andColTo:toCell.colNum andTime:_totalTime];
    }
    else {
        [_logManager saveLastEventWith:figure.image andRowFrom:fromCell.rowNum andColFrom:fromCell.colNum andRowTo:toCell.rowNum andColTo:toCell.colNum andTime:_totalTime andFigureKilledImage:figureKilled.image];
    }
    
    NSMutableArray* lastEvents = [_logManager getLastEvents];
    [_lastEventView updateWithLogEvent:lastEvents[0]];
    if (lastEvents.count>1) {
        [_preLastEventView updateWithLogEvent:lastEvents[1]];

    }
    if (lastEvents.count>2) {
        [_prePreLastEventView updateWithLogEvent:lastEvents[2]];
    }
   // [_logView updateLogDataFigureImage:[UIImage imageNamed:@"knight-red"]];
}

- (PlayerColor) getCurrentPlayer {
    return [_turnManager getCurrentPlayer];
}

#pragma mark - History View Controller Delegate
- (NSArray *)getHistory {
    return [_logManager getAllEvents];
}

@end
