//
//  TurnManager.m
//  WhiteKing
//
//  Created by admin on 12.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "TurnManager.h"
static NSString* const kWhitePlayerString = @"RED";
static NSString* const kBlackPlayerString = @"BLUE";

@implementation TurnManager
{
    PlayerColor _currentPlayer;
}

- (instancetype) init {
    self = [super init];
    if (self != nil)
    {
        _currentPlayer = whitePlayerColor;
    }
    return self;
}

- (PlayerColor) getCurrentPlayer {
    return _currentPlayer;
}

- (void) setCurrentPlayer: (PlayerColor)playerColor {
    _currentPlayer = playerColor;
}

- (void) changePlayerToNext {
    switch (_currentPlayer) {
        case blackPlayerColor:
            _currentPlayer = whitePlayerColor;
            break;
        case whitePlayerColor:
            _currentPlayer = blackPlayerColor;
            break;
    }
}

- (NSString*) getCurrentPlayerString {
    switch (_currentPlayer) {
        case whitePlayerColor:
            return kWhitePlayerString;
            break;
        case blackPlayerColor:
            return kBlackPlayerString;
            break;
    }
}
@end
