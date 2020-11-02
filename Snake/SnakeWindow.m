//
//  SnakeWindow.m
//  Snake
//
//  Created by Jerry.Yang on 2020/11/2.
//  Copyright © 2020 Jerry.Yang. All rights reserved.
//

#import "SnakeWindow.h"

@implementation SnakeWindow

-(void)awakeFromNib{
    self.title=@"简易怀旧版贪吃蛇";
}


-(void)keyDown:(NSEvent *)event{
    BackgroundView *bv = (BackgroundView *)self.contentView;
    NSString *fcstr = event.charactersIgnoringModifiers;
    if ([fcstr characterAtIndex:0] == NSLeftArrowFunctionKey) {
        [self setBodyDirection:1];
    }
    else if ([fcstr characterAtIndex:0] == NSRightArrowFunctionKey) {
        [self setBodyDirection:2];
    }
    else if ([fcstr characterAtIndex:0] == NSUpArrowFunctionKey) {
        [self setBodyDirection:3];
    }
    else if ([fcstr characterAtIndex:0] == NSDownArrowFunctionKey) {
        [self setBodyDirection:4];
    }
    else if ([fcstr characterAtIndex:0] == ' '){
        bv.isPause=!bv.isPause;
    }
    else{
        [super keyDown:event];
    }
}

-(void)setBodyDirection:(short)d{
    BackgroundView *bv = (BackgroundView *)self.contentView;
    if (bv.isPause) {
        return;
    }
    bv.body.direction=d;
    [bv.body eatFood:bv.food];
    self.contentView.needsDisplay=YES;
}

@end
