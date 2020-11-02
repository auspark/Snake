//
//  BackgroundView.m
//  Tetris
//
//  Created by Jerry.Yang on 2020/10/29.
//  Copyright © 2020 Jerry.Yang. All rights reserved.
//

#import "BackgroundView.h"

@interface BackgroundView ()
{
    short xMax;
    short yMax;
}
@end

@implementation BackgroundView

-(void)awakeFromNib{
    [super awakeFromNib];
    self->xMax=self.frame.size.width/SquareSize-1;//0-14
    self->yMax=self.frame.size.height/SquareSize-1;//0-13
    self.food=[[Food alloc] initX:self->xMax Y:self->yMax];
    self.body=[[SnakeBoby alloc]initX:self->xMax Y:self->yMax];
    [self newGame];
}

-(void)newGame{
    @autoreleasepool {
        [self.food newFood];
        self.isPause=YES;
        if (self.mTimer) {
            [self.mTimer invalidate];
            self.mTimer=nil;
        }
        [self.body.units removeAllObjects];
        [self.body addInitBody];
        self.body.direction=0;
        self.scoreTextField.integerValue=0;
        self.mTimer=[NSTimer scheduledTimerWithTimeInterval:0.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
            if (!self.isPause) {
                if (![self.body doMoveStep]) {
                    self.needsDisplay=YES;
                    [timer invalidate];
                }else{
                    if([self.body eatFood:self.food]){
                        self.scoreTextField.integerValue+=10;
                    }
                    self.needsDisplay=YES;
                }
            }
        }];
        [self.mTimer fire];
        self.needsDisplay=YES;
    }
}

-(void)drawRect:(NSRect)dirtyRect{
    [self drawGrid];
    [self drawBody_Radius];
    [self drawFood];
}

-(void)drawGrid{
    NSBezierPath *path=[NSBezierPath bezierPath];
    //draw x line
    for (int x=0; x<=self.frame.size.width; x+=SquareSize)
    {
        [path moveToPoint:NSMakePoint(x, 0)];
        [path lineToPoint:NSMakePoint(x, self.frame.size.height)];
    }
    //draw y line
    for (int y=0; y<=self.frame.size.height; y+=SquareSize)
    {
        [path moveToPoint:NSMakePoint(0, y)];
        [path lineToPoint:NSMakePoint(self.frame.size.width, y)];
    }
    path.lineWidth=0.5;
    [[NSColor grayColor]set];
    [path stroke];
}


-(void)drawBody_Radius{
    for (int i=(int)self.body.units.count-1; i>0; i--) {
        BodyUnit *b = self.body.units[i];
        [[NSColor blueColor]set];
            NSBezierPath *path=[NSBezierPath bezierPathWithRoundedRect:NSMakeRect(b.x*SquareSize+SpaceSize, b.y*SquareSize+SpaceSize, SquareSize-2*SpaceSize, SquareSize-2*SpaceSize) xRadius:(SquareSize-2*SpaceSize)/2 yRadius:(SquareSize-2*SpaceSize)/2];
        [path fill];
    }
    [self drawSnakeHead_round];
}

-(void)drawBody_square{
    for (int i=(int)self.body.units.count-1; i>0; i--) {
        BodyUnit *b = self.body.units[i];
        [[NSColor blueColor]set];
        NSRectFill(NSMakeRect(b.x*SquareSize+SpaceSize, b.y*SquareSize+SpaceSize, SquareSize-2*SpaceSize, SquareSize-2*SpaceSize));
    }
    [self drawSnakeHead_round];
}

-(void)drawSnakeHead_round{
    BodyUnit *f=self.body.units[0];
    NSBezierPath *path=[NSBezierPath bezierPathWithRoundedRect:NSMakeRect(f.x*SquareSize+SpaceSize, f.y*SquareSize+SpaceSize, SquareSize-2*SpaceSize, SquareSize-2*SpaceSize) xRadius:(SquareSize-2*SpaceSize)/2 yRadius:(SquareSize-2*SpaceSize)/2];
    [[NSColor brownColor]set];
    [path fill];
}

-(void)drawSnakeHead_triangle{
    BodyUnit *f=self.body.units[0];
    BodyUnit *s=self.body.units[1];
    if (f.x==s.x) {
        if (f.y>s.y) {
            NSBezierPath *path=[NSBezierPath bezierPath];
            [path moveToPoint:NSMakePoint(f.x*SquareSize+SpaceSize, f.y*SquareSize+SpaceSize)];
            [path lineToPoint:NSMakePoint(f.x*SquareSize+SpaceSize, f.y*SquareSize+SpaceSize)];
            [path lineToPoint:NSMakePoint(f.x*SquareSize+SpaceSize+SquareSize-2*SpaceSize, f.y*SquareSize+SpaceSize)];
            [path lineToPoint:NSMakePoint(f.x*SquareSize+SquareSize/2, f.y*SquareSize+SpaceSize+SquareSize-2*SpaceSize)];
            [path lineToPoint:NSMakePoint(f.x*SquareSize+SpaceSize, f.y*SquareSize+SpaceSize)];
            [path stroke];
            [[NSColor blueColor]set];
            [path fill];
        }
        else if (f.y<s.y){
            NSBezierPath *path=[NSBezierPath bezierPath];
            [path moveToPoint:NSMakePoint(f.x*SquareSize+SpaceSize, f.y*SquareSize+SquareSize-SpaceSize)];
            [path moveToPoint:NSMakePoint(f.x*SquareSize+SpaceSize, f.y*SquareSize+SquareSize-SpaceSize)];
            [path lineToPoint:NSMakePoint(f.x*SquareSize+SquareSize-SpaceSize, f.y*SquareSize+SquareSize-SpaceSize)];
            [path lineToPoint:NSMakePoint(f.x*SquareSize+SquareSize/2, f.y*SquareSize+SpaceSize)];
            [path moveToPoint:NSMakePoint(f.x*SquareSize+SpaceSize, f.y*SquareSize+SquareSize-SpaceSize)];
            [path stroke];
            [[NSColor blueColor]set];
            [path fill];
        }
    }
    else if (f.y==s.y){
        if (f.x>s.x) {
            NSBezierPath *path=[NSBezierPath bezierPath];
            [path moveToPoint:NSMakePoint(f.x*SquareSize+SpaceSize, f.y*SquareSize+SpaceSize)];
            [path lineToPoint:NSMakePoint(f.x*SquareSize+SpaceSize, f.y*SquareSize+SquareSize-SpaceSize)];
            [path lineToPoint:NSMakePoint(f.x*SquareSize+SquareSize-SpaceSize, f.y*SquareSize+SquareSize/2)];
            [path lineToPoint:NSMakePoint(f.x*SquareSize+SpaceSize, f.y*SquareSize+SpaceSize)];
            [path stroke];
            [[NSColor blueColor]set];
            [path fill];
        }
        else if (f.x<s.x){
            NSBezierPath *path=[NSBezierPath bezierPath];
            [path moveToPoint:NSMakePoint(f.x*SquareSize+SquareSize-SpaceSize, f.y*SquareSize+SpaceSize)];
            [path lineToPoint:NSMakePoint(f.x*SquareSize+SquareSize-SpaceSize, f.y*SquareSize+SquareSize-SpaceSize)];
            [path lineToPoint:NSMakePoint(f.x*SquareSize+SpaceSize, f.y*SquareSize+SquareSize/2)];
            [path lineToPoint:NSMakePoint(f.x*SquareSize+SquareSize-SpaceSize, f.y*SquareSize+SpaceSize)];
            [path stroke];
            [[NSColor blueColor]set];
            [path fill];
        }
    }
}

-(void)drawFood{
    [[NSColor redColor]set];
    NSRectFill(NSMakeRect(self.food.x*SquareSize+SpaceSize, self.food.y*SquareSize+SpaceSize, SquareSize-2*SpaceSize, SquareSize-2*SpaceSize));
}



@end
