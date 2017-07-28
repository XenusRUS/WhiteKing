//
//  TurnManager.h
//  WhiteKing
//
//  Created by admin on 12.07.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Colors.h"

@interface TurnManager : NSObject
- (PlayerColor) getCurrentPlayer;
- (void) setCurrentPlayer: (PlayerColor)playerColor;
- (void) changePlayerToNext;
- (NSString*) getCurrentPlayerString;
@end
