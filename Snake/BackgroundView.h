//
//  BackgroundView.h
//  Tetris
//
//  Created by Jerry.Yang on 2020/10/29.
//  Copyright © 2020 Jerry.Yang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SnakeBoby.h"
#import "Food.h"
NS_ASSUME_NONNULL_BEGIN

#define TimerInterval 0.5

@interface BackgroundView : NSView
@property(nonatomic) Food *food;
@property(nonatomic) SnakeBoby *body;
@property(nonatomic,nullable) NSTimer *mTimer;
@property(nonatomic) BOOL isPause;

@property(nonatomic) NSTextField *scoreTextField;


-(void)newGame;

@end

NS_ASSUME_NONNULL_END
