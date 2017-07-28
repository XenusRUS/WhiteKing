//
//  Board.m
//  WhiteKing
//
//  Created by admin on 02.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "Board.h"
#import "Cell.h"
#import "Figure.h"
#import "Knight.h"
#import "Royal.h"
#import "Pawn.h"
#import "Rook.h"
#import "Queen.h"
#import "King.h"
#import "CoordinatesNaming.h"

static const CGFloat kCellSize = 35;
static const CGFloat kFigureSize = 30;
static const NSInteger kBoardSizeInCells = 8;

static const NSInteger kKnightsNumberOnOneSide = 2;
static const NSInteger kRooksNumberOnOneSide = 2;
static const NSInteger kRoyalsNumberOnOneSide = 2;


@implementation Board
{
    NSMutableArray *_cells;
    //NSMutableArray *_figures;
    NSMutableArray *_whiteFigures;
    NSMutableArray *_blackFigures;
    
    UITapGestureRecognizer *_tapRecongizer;
//    TurnManager *_turnManager;
    Figure *_currentSelectedFigure;
    
    King *_whiteKing;
    King *_blackKing;
}

- (instancetype) init
{
    self = [super init];
    
    if (self != nil)
    {

        [self setUpBoardLayout];
        _currentSelectedFigure = nil;
        
        [self setUpFigures];
        //tap recongizer set up
        _tapRecongizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHandle:)];
        [self addGestureRecognizer:_tapRecongizer];
    }
     return self;
}

- (void) setUpBoardLayout {
    self.frame = CGRectMake(0, 0, kCellSize*kBoardSizeInCells, kCellSize*kBoardSizeInCells);
    [self fillBoardWithCells];
    [self setupCoordinatesNames];
}

-(void) setupCoordinatesNames
{
    for (NSInteger i=0; i<kBoardSizeInCells; i++) {
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellSize*i, kCellSize*kBoardSizeInCells, kCellSize, kCellSize)];
        tempLabel.textAlignment = NSTextAlignmentCenter;
        tempLabel.text = kColumnsNames[i];
        tempLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:tempLabel];
    }
    for (NSInteger i=0; i<kBoardSizeInCells; i++) {
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(-kCellSize, kCellSize*i, kCellSize, kCellSize)];
        tempLabel.textAlignment = NSTextAlignmentCenter;
        tempLabel.text = kRowsNames[i];
        tempLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:tempLabel];
    }
    for (NSInteger i=0; i<kBoardSizeInCells; i++) {
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellSize*kBoardSizeInCells, kCellSize*i, kCellSize, kCellSize)];
        tempLabel.textAlignment = NSTextAlignmentCenter;
        tempLabel.text = nil;
        tempLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:tempLabel];
    }
    for (NSInteger i=0; i<kBoardSizeInCells; i++) {
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellSize*i, -kCellSize, kCellSize, kCellSize)];
        tempLabel.textAlignment = NSTextAlignmentCenter;
        tempLabel.text = nil;
        tempLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:tempLabel];
    }
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(-kCellSize, -kCellSize, kCellSize, kCellSize)];
    tempLabel.textAlignment = NSTextAlignmentCenter;
    tempLabel.text = nil;
    tempLabel.backgroundColor = [UIColor yellowColor];
    [self addSubview:tempLabel];
    
    UILabel *tempLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(kCellSize*kBoardSizeInCells, -kCellSize, kCellSize, kCellSize)];
    tempLabel2.textAlignment = NSTextAlignmentCenter;
    tempLabel2.text = nil;
    tempLabel2.backgroundColor = [UIColor yellowColor];
    [self addSubview:tempLabel2];
    
    UILabel *tempLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(-kCellSize, kBoardSizeInCells*kCellSize, kCellSize, kCellSize)];
    tempLabel3.textAlignment = NSTextAlignmentCenter;
    tempLabel3.text = nil;
    tempLabel3.backgroundColor = [UIColor yellowColor];
    [self addSubview:tempLabel3];
    
    UILabel *tempLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(kBoardSizeInCells*kCellSize, kBoardSizeInCells*kCellSize, kCellSize, kCellSize)];
    tempLabel4.textAlignment = NSTextAlignmentCenter;
    tempLabel4.text = nil;
    tempLabel4.backgroundColor = [UIColor yellowColor];
    [self addSubview:tempLabel4];
}

- (void) setUpFigures {
    _whiteFigures = [[NSMutableArray alloc] init];
    _blackFigures = [[NSMutableArray alloc] init];

    
    //white pawns creation
    for (int pawnCol = 0;pawnCol<kBoardSizeInCells;pawnCol++) {
        Pawn *pawn = [[Pawn alloc] initWithSize:CGSizeMake(kFigureSize, kFigureSize) andColor:whitePlayerColor];
        pawn.direction = upPawnDirection;
        pawn.delegate = self;
        Cell *pawnCell = [self findCellByRow:6 ByColumn:pawnCol];
        [self addFigure:pawn atCell:pawnCell];
        [_whiteFigures addObject:pawn];
    }
    
    //black pawns creation
    for (int pawnCol = 0;pawnCol<kBoardSizeInCells;pawnCol++) {
        Pawn *pawn = [[Pawn alloc] initWithSize:CGSizeMake(kFigureSize, kFigureSize) andColor:blackPlayerColor];
        pawn.direction = downPawnDirection;
        pawn.delegate = self;
        Cell *pawnCell = [self findCellByRow:1 ByColumn:pawnCol];
        [self addFigure:pawn atCell:pawnCell];
        [_blackFigures addObject:pawn];
    }
    
    //white rooks creation
    for (NSInteger i=0; i<kRooksNumberOnOneSide; i++) {
        Rook *rook = [[Rook alloc] initWithSize:CGSizeMake(kFigureSize, kFigureSize) andColor:whitePlayerColor];
        rook.delegate = self;
        NSInteger rookColumn = (kBoardSizeInCells-1)*i;
        Cell *rookCell = [self findCellByRow:7 ByColumn:rookColumn];
        [self addFigure:rook atCell:rookCell];
        [_whiteFigures addObject:rook];
    }
    
    //black rooks creation
    for (NSInteger i=0; i<kRooksNumberOnOneSide; i++) {
        Rook *rook = [[Rook alloc] initWithSize:CGSizeMake(kFigureSize, kFigureSize) andColor:blackPlayerColor];
        rook.delegate = self;
        NSInteger rookColumn = (kBoardSizeInCells-1)*i;
        Cell *rookCell = [self findCellByRow:0 ByColumn:rookColumn];
        [self addFigure:rook atCell:rookCell];
        [_blackFigures addObject:rook];
    }
    
    //white knights creation
    for (NSInteger i=0; i<kKnightsNumberOnOneSide; i++) {
        Knight *knight = [[Knight alloc] initWithSize:CGSizeMake(kFigureSize, kFigureSize) andColor:whitePlayerColor];
        knight.delegate = self;
        NSInteger knightColumn = (kBoardSizeInCells-1)*i+pow(-1, i);
        Cell* horseCell = [self findCellByRow:7 ByColumn:knightColumn];
        [self addFigure:knight atCell:horseCell];
        [_whiteFigures addObject:knight];
    }
    
    //black knights creation
    for (NSInteger i=0; i<kKnightsNumberOnOneSide; i++) {
        Knight *knight = [[Knight alloc] initWithSize:CGSizeMake(kFigureSize, kFigureSize) andColor:blackPlayerColor];
        knight.delegate = self;
        NSInteger knightColumn = (kBoardSizeInCells-1)*i+pow(-1, i);
        Cell* horseCell = [self findCellByRow:0 ByColumn:knightColumn];
        [self addFigure:knight atCell:horseCell];
        [_blackFigures addObject:knight];
    }
    
    //white royals creation
    for (NSInteger i=0; i<kRoyalsNumberOnOneSide; i++) {
        Royal *royal = [[Royal alloc] initWithSize:CGSizeMake(kFigureSize, kFigureSize) andColor:whitePlayerColor];
        NSInteger royalColumn = (kBoardSizeInCells-1)*i+pow(-1, i)*2;
        Cell *royalCell = [self findCellByRow:7 ByColumn:royalColumn];
        royal.delegate = self;
        [self addFigure:royal atCell:royalCell];
        [_whiteFigures addObject:royal];
    }

    //black royals creation
    for (NSInteger i=0; i<kRoyalsNumberOnOneSide; i++) {
        Royal *royal = [[Royal alloc] initWithSize:CGSizeMake(kFigureSize, kFigureSize) andColor:blackPlayerColor];
        NSInteger royalColumn = (kBoardSizeInCells-1)*i+pow(-1, i)*2;
        Cell *royalCell = [self findCellByRow:0 ByColumn:royalColumn];
        royal.delegate = self;
        [self addFigure:royal atCell:royalCell];
        [_blackFigures addObject:royal];
    }
    
    //white queen creation
    Queen *whiteQueen = [[Queen alloc] initWithSize:CGSizeMake(kFigureSize, kFigureSize) andColor:whitePlayerColor];
    whiteQueen.delegate = self;
    Cell *WhiteQueenCell = [self findCellByRow:7 ByColumn:3];
    [self addFigure:whiteQueen atCell:WhiteQueenCell];
    [_whiteFigures addObject:whiteQueen];
    
    //black queen creation
    Queen *blackQueen = [[Queen alloc] initWithSize:CGSizeMake(kFigureSize, kFigureSize) andColor:blackPlayerColor];
    blackQueen.delegate = self;
    Cell *BlackQueenCell = [self findCellByRow:0 ByColumn:3];
    [self addFigure:blackQueen atCell:BlackQueenCell];
    [_blackFigures addObject:blackQueen];
    
    //white king creation
    _whiteKing = [[King alloc] initWithSize:CGSizeMake(kFigureSize, kFigureSize) andColor:whitePlayerColor];
    _whiteKing.delegate = self;
    Cell *WhiteKingCell = [self findCellByRow:7 ByColumn:4];
    [self addFigure:_whiteKing atCell:WhiteKingCell];
    [_whiteFigures addObject:_whiteKing];
    
    //black king creation
    _blackKing = [[King alloc] initWithSize:CGSizeMake(kFigureSize, kFigureSize) andColor:blackPlayerColor];
    _blackKing.delegate = self;
    Cell *BlackKingCell = [self findCellByRow:0 ByColumn:4];
    [self addFigure:_blackKing atCell:BlackKingCell];
    [_blackFigures addObject:_blackKing];
    
    
    
    //проверки
    
//        _blackKing = [[King alloc] initWithSize:CGSizeMake(kFigureSize, kFigureSize) andColor:blackPlayerColor];
//        _blackKing.delegate = self;
//        Cell *BlackKingCell = [self findCellByRow:7 ByColumn:0];
//        [self addFigure:_blackKing atCell:BlackKingCell];
//        [_blackFigures addObject:_blackKing];
//    
//            Queen *whiteQueen = [[Queen alloc] initWithSize:CGSizeMake(kFigureSize, kFigureSize) andColor:whitePlayerColor];
//            whiteQueen.delegate = self;
//            Cell *WhiteQueenCell = [self findCellByRow:0 ByColumn:1];
//            [self addFigure:whiteQueen atCell:WhiteQueenCell];
//            [_whiteFigures addObject:whiteQueen];
//    
//    Queen *whiteQueen2 = [[Queen alloc] initWithSize:CGSizeMake(kFigureSize, kFigureSize) andColor:whitePlayerColor];
//    whiteQueen2.delegate = self;
//    Cell *WhiteQueenCell2 = [self findCellByRow:0 ByColumn:7];
//    [self addFigure:whiteQueen2 atCell:WhiteQueenCell2];
//    [_whiteFigures addObject:whiteQueen2];

    
//            Pawn *pawn = [[Pawn alloc] initWithSize:CGSizeMake(kFigureSize, kFigureSize) andColor:blackPlayerColor];
//            pawn.direction = downPawnDirection;
//            pawn.delegate = self;
//            Cell *pawnCell = [self findCellByRow:6 ByColumn:0];
//            [self addFigure:pawn atCell:pawnCell];
//            [_blackFigures addObject:pawn];
//    
//    Pawn *pawn2 = [[Pawn alloc] initWithSize:CGSizeMake(kFigureSize, kFigureSize) andColor:blackPlayerColor];
//    pawn2.direction = downPawnDirection;
//    pawn2.delegate = self;
//    Cell *pawnCell2 = [self findCellByRow:6 ByColumn:1];
//    [self addFigure:pawn2 atCell:pawnCell2];
//    [_blackFigures addObject:pawn2];
//    
//    Pawn *pawn3 = [[Pawn alloc] initWithSize:CGSizeMake(kFigureSize, kFigureSize) andColor:whitePlayerColor];
//    pawn3.direction = upPawnDirection;
//    pawn3.delegate = self;
//    Cell *pawnCell3 = [self findCellByRow:7 ByColumn:1];
//    [self addFigure:pawn3 atCell:pawnCell3];
//    [_blackFigures addObject:pawn3];
//
//
//    
//        Queen *whiteQueen = [[Queen alloc] initWithSize:CGSizeMake(kFigureSize, kFigureSize) andColor:whitePlayerColor];
//        whiteQueen.delegate = self;
//        Cell *WhiteQueenCell = [self findCellByRow:0 ByColumn:2];
//        [self addFigure:whiteQueen atCell:WhiteQueenCell];
//        [_whiteFigures addObject:whiteQueen];

    
}

//- (void) updatePlayerLabel {
//    NSString* currentPlayerString = [_turnManager getCurrentPlayerString];
//    _currentPlayerLabel.text = currentPlayerString;
//    PlayerColor currentPlayerColor = [_turnManager getCurrentPlayer];
//    switch (currentPlayerColor) {
//        case whitePlayerColor:
//            _currentPlayerLabel.textColor = [UIColor redColor];
//            break;
//        case blackPlayerColor:
//            _currentPlayerLabel.textColor = [UIColor blueColor];
//            break;
//    }
//}

- (Cell *) findCellByRow:(NSInteger) row ByColumn:(NSInteger) column {
    for (int i=0; i<_cells.count; i++) {
        Cell* cellContent = _cells[i];
        if ((cellContent.rowNum == row) && (cellContent.colNum == column)) {
            return _cells[i];
        }
    }
    return nil;
}

- (void) fillBoardWithCells {

    _cells = [[NSMutableArray alloc] init];
    
    for (int j=0; j<kBoardSizeInCells; j++)
    {
       
        for (NSInteger i=0; i<kBoardSizeInCells; i++) {
            Cell* cell = [[Cell alloc] initWithRowNum:j andColNum:i];
            [_cells addObject:cell];
            if ((i+j)%2 == 0) {
                [cell setCellColor: kWhiteCellColor];
            }
            else {
                [cell setCellColor:kBlackCellColor];
            }
            cell.frame = CGRectMake(i*kCellSize, j*kCellSize, kCellSize, kCellSize);
            [self addSubview:cell];
        }
    }
}

- (void) tapHandle:(UIGestureRecognizer *)recognizer
{
    CGPoint tapPoint = [recognizer locationInView:self];
    Cell* tappedCell = [self cellByPoint:tapPoint];
    if ([self isCellEmpty: tappedCell]) {
        if (_currentSelectedFigure != nil) {
            [self moveFigure:_currentSelectedFigure atCell:tappedCell];
        }
    }
    else {
        Figure *figureAtTappedCell = [self getFigureAtCell:tappedCell];
        PlayerColor currentPlayerColor = [_delegate getCurrentPlayer];
        if (figureAtTappedCell.figureColor == currentPlayerColor) {
            Cell *previousSelectedCell = [self findCellByRow:_currentSelectedFigure.rowNum ByColumn:_currentSelectedFigure.colNum];
            [previousSelectedCell unHighlightCell];
            _currentSelectedFigure = figureAtTappedCell;
            [tappedCell highlightCell];
            
        }
        else if (_currentSelectedFigure != nil) {
            [self moveFigure:_currentSelectedFigure atCell:tappedCell];
        }
    }
//    PlayerColor currentPlayerColor = [_turnManager getCurrentPlayer];
//    switch (currentPlayerColor) {
//        case whitePlayerColor:
//            [self moveFigure:_knight atCell:tappedCell];
//            break;
//        case blackPlayerColor:
//            [self moveFigure:_royal atCell:tappedCell];
//            break;
//    }
}

- (Cell *) cellByPoint:(CGPoint) point {
    NSInteger i,j;
    j = (NSInteger) floor(point.x/kCellSize);
    i = (NSInteger) floor(point.y/kCellSize);
    return [self findCellByRow:i ByColumn:j];
}

#pragma mark - move figures methods

- (void) moveFigure:(Figure *) figure atCell:(Cell *) cell
{
//    for (int i=0; i<_figures.count; i++) {
//        Figure * newFigure = _figures[i];
//        if ((newFigure.rowNum == cell.rowNum) && (newFigure.colNum == cell.colNum)) {
//            NSLog(@"cell not is empty");
//            return;
//        }
//    }
    Cell *cellFrom = [self findCellByRow:figure.rowNum ByColumn:figure.colNum];

    if([figure isReachableRow:cell.rowNum andColumn:cell.colNum] && [figure isWayClearToCellAtRow:cell.rowNum andColumn:cell.colNum])
    {
        
        Figure *figureAtEndCell = [self getFigureAtCell:cell];
        Figure *figureKilled = nil;
        if (figureAtEndCell != nil) {
            PlayerColor currentPlayerColor = [_delegate getCurrentPlayer];
            PlayerColor figureAtEndCellColor = figureAtEndCell.figureColor;
            if (currentPlayerColor!=figureAtEndCellColor) {
                figureKilled = figureAtEndCell;
                [self destroyFigure:figureAtEndCell];
            }
        }
        
        [self placeFigure:figure AtCell:cell];
        _currentSelectedFigure = nil;
        [cellFrom unHighlightCell];
        [_delegate playerTurnEndWithFigure:figure fromCell:cellFrom ToCell:cell figureKilled:figureKilled];
    }
    
    King *kingToCheck = nil;
    switch ([_delegate getCurrentPlayer]) {
        case whitePlayerColor:
            kingToCheck = _whiteKing;
            break;
        case blackPlayerColor:
            kingToCheck = _blackKing;
            break;
    }
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Игра окончена!" message:@"Мат!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    switch ([_delegate checkKingOnMate:kingToCheck]) {
        case noState:
            NSLog(@"no state");
            break;
        case check:
            NSLog(@"Шах!");
            break;
        case mate:
            [alert show];
            break;
        case stalemate:
            NSLog(@"Пат!");
            break;

    }
    

}

- (BOOL) isCellUnderFire:(Cell *)cell byFiguresOfColor:(PlayerColor)enemyFigureColor kingCell:(BOOL)kingCell {
    NSMutableArray *enemyFigures = nil;
    switch (enemyFigureColor) {
        case whitePlayerColor:
            enemyFigures = _whiteFigures;
            break;
        case blackPlayerColor:
            enemyFigures = _blackFigures;
            break;
    }
    for (NSInteger i=0; i<enemyFigures.count; i++) {
        Figure *currentFigure = enemyFigures[i];
        if ([self isCellUnderFire: cell byFigure:currentFigure kingCell:kingCell]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL) isCellUnderFire: (Cell *)cell byFigure: (Figure *)figure kingCell:(BOOL)kingCell {
    BOOL result = YES;
//    result = result && [figure isReachableRow:cell.rowNum andColumn:cell.colNum];
//    result = result && [figure isWayClearToCellAtRow:cell.rowNum andColumn:cell.colNum];
    result = result && [figure canDestroyFigureAtCellAtRow:cell.rowNum andColumn:cell.colNum];
    if (!kingCell) {
        result = result && [self isCellEmpty:cell];
    }
    return result;
}

- (BOOL) isCellFilled: (Cell*)cell byFigureOfColor:(PlayerColor)color {
    NSMutableArray *enemyFigures = nil;
    switch (color) {
        case whitePlayerColor:
            enemyFigures = _whiteFigures;
            break;
        case blackPlayerColor:
            enemyFigures = _blackFigures;
            break;
    }
    for (NSInteger i=0; i<enemyFigures.count; i++) {
        Figure *enemyFig = enemyFigures[i];
        if ((cell.rowNum == enemyFig.rowNum) && (cell.colNum == enemyFig.colNum)) {
            return YES;
        }
    }
    return NO;
}

- (void) destroyFigure: (Figure*)figure {
    [figure removeFromSuperview];
    if ([_whiteFigures containsObject:figure]) {
        [_whiteFigures removeObject:figure];
    }
    if ([_blackFigures containsObject:figure]) {
        [_blackFigures removeObject:figure];
    }
}

- (Figure *) getFigureAtCell:(Cell *)cell {
    for (int i=0; i<_whiteFigures.count; i++) {
        Figure * newFigure = _whiteFigures[i];
        if ((newFigure.rowNum == cell.rowNum) && (newFigure.colNum == cell.colNum)) {
            return newFigure;
        }
    }
    for (int i=0; i<_blackFigures.count; i++) {
        Figure * newFigure = _blackFigures[i];
        if ((newFigure.rowNum == cell.rowNum) && (newFigure.colNum == cell.colNum)) {
            return newFigure;
        }
    }
    return nil;
}

- (BOOL) isCellEmpty: (Cell *)cell {
    for (int i=0; i<_whiteFigures.count; i++) {
        Figure * newFigure = _whiteFigures[i];
        if ((newFigure.rowNum == cell.rowNum) && (newFigure.colNum == cell.colNum)) {
            return NO;
        }
    }
    for (int i=0; i<_blackFigures.count; i++) {
        Figure * newFigure = _blackFigures[i];
        if ((newFigure.rowNum == cell.rowNum) && (newFigure.colNum == cell.colNum)) {
            return NO;
        }
    }
    return YES;
}



- (void) addFigure:(Figure *) figure atCell:(Cell *) cell
{
    if(![self.subviews containsObject:figure])
    {
        [self addSubview:figure];
    }
    figure.center = cell.center;
    figure.rowNum = cell.rowNum;
    figure.colNum = cell.colNum;
//    [self placeFigure:figure AtCell:cell];

}

- (void) placeFigure: (Figure *)figure AtCell: (Cell *) cell {
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        figure.center = cell.center;
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
    
    [figure moveToRowNum:cell.rowNum andColNum:cell.colNum];
}

#pragma mark - Figure Delegate

- (BOOL) isCellEmptyAtRow: (NSInteger)rowNum andColNum: (NSInteger)colNum
{
    for (int i=0; i<_whiteFigures.count; i++) {
        Figure * newFigure = _whiteFigures[i];
        if ((newFigure.rowNum == rowNum) && (newFigure.colNum == colNum)) {
            return NO;
        }
    }
    for (int i=0; i<_blackFigures.count; i++) {
        Figure * newFigure = _blackFigures[i];
        if ((newFigure.rowNum == rowNum) && (newFigure.colNum == colNum)) {
            return NO;
        }
    }
    return YES;
}

@end
