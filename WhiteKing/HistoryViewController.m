//
//  HistoryViewController.m
//  WhiteKing
//
//  Created by admin on 28.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryTableViewCell.h"
#import "LogView.h"

static const NSInteger kButtonHeight = 50;

@interface HistoryViewController ()

@end

@implementation HistoryViewController
{
    UIButton *_backButton;
    UITableView *_historyView;
    NSArray *_allLogEvents;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, kButtonHeight)];
    _backButton.backgroundColor = [UIColor redColor];
    [_backButton setTitle:@"BACK" forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    [self setupHistoryView];
}

-(void)viewWillAppear:(BOOL)animated
{
    _allLogEvents = [self reversedArray:[_delegate getHistory]];
    [_historyView reloadData];
}

- (NSArray *)reversedArray: (NSArray*)sourceArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[sourceArray count]];
    NSEnumerator *enumerator = [sourceArray reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return array;
}

- (void) setupHistoryView {
    _historyView = [[UITableView alloc] initWithFrame:CGRectMake(0, kButtonHeight+10, self.view.frame.size.width, self.view.frame.size.height-(kButtonHeight+10))];
    [self.view addSubview:_historyView];
    _historyView.dataSource = self;
    _historyView.delegate = self;
}

- (void)setDelegate:(id<HistoryViewControllerDelegate>)delegate
{
    _delegate = delegate;
    _allLogEvents = [self reversedArray:[_delegate getHistory]];
    [_historyView reloadData];

}

- (void) backButtonAction {
    [self.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype) initWithViewFrame: (CGRect)frame {
    self = [super init];
    if (self != nil) {
        self.view.frame = frame;
    }
    return self;
}

#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _allLogEvents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"LogCell";
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    LogView *currentLogView = [[LogView alloc] initWithFrame:cell.bounds];
    LogEvent *currentEvent = _allLogEvents[indexPath.row];
    [currentLogView updateWithLogEvent:currentEvent];
    [cell setContentView:currentLogView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
@end
