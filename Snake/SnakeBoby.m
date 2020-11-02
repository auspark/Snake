//
//  SnakeBoby.m
//  Snake
//
//  Created by Jerry.Yang on 2020/11/2.
//  Copyright © 2020 Jerry.Yang. All rights reserved.
//

#import "SnakeBoby.h"

@implementation BodyUnit : NSObject
@end


@interface SnakeBoby ()
{
    unsigned short xMax,yMax;
}

@end


@implementation SnakeBoby

-(id)init{
    if(self=[super init]){
        self.units=[NSMutableArray array];
    }
    return self;
}

-(id)initX:(unsigned short)xMax Y:(unsigned short)yMax{
    if (self=[self init]) {
        self->xMax=xMax;
        self->yMax=yMax;
        self.direction=0;
        [self addInitBody];
    }
    return self;
}

-(void)addInitBody{
    for (int i=self->xMax/2-2; i<self->xMax/2+2; i++) {
        BodyUnit *bu=[[BodyUnit alloc]init];
        bu.x=i;
        bu.y=self->yMax/2;
        [self.units addObject:bu];
    }
}

-(void)setDirection:(unsigned short)direction{
    switch (direction) {
        case 0:
            _direction=0;
            break;
        case 1:
            if (_direction!=2) {
                _direction=direction;
            }
            break;
        case 2:
            if (_direction!=1) {
                _direction=direction;
            }
            break;
        case 3:
            if (_direction!=4) {
                _direction=direction;
            }
            break;
        case 4:
            if (_direction!=3) {
                _direction=direction;
            }
            break;
        default:
            break;
    }
}

-(BOOL)doMoveStep{
//    NSLog(@"%d",self.direction);
    switch (self.direction) {
        case 0:
            return YES;
        case 1:
            return [self leftStep];
            break;
        case 2:
            return [self rightStep];
            break;
        case 3:
            return [self upStep];
            break;
        case 4:
            return [self downStep];
            break;
        default:
            break;
    }
    return NO;
}

-(BOOL)checkMoveRight:(BodyUnit *)b{
    for (int i=1;i<self.units.count;i++) {
        BodyUnit *b1 = self.units[i];
        if (b.x==b1.x && b.y==b1.y) {
            return NO;
        }
    }
    return YES;
}


-(void)nextValue{
    for (int i=(int)self.units.count-2; i>=0; i--) {
        BodyUnit *b2 = self.units[i+1];
        BodyUnit *b1 = self.units[i];
        b2.x=b1.x;
        b2.y=b1.y;
    }
}

-(BOOL)leftStep{
//    if (self.direction>0 && self.direction!=2) {
        [self nextValue];
        BodyUnit *b = [self.units objectAtIndex:0];
        b.x--;
        if (b.x<0) {
            return NO;
        }
    return [self checkMoveRight:b];
//        return YES;
//    }
//    return NO;
}

-(BOOL)rightStep{
//    if (self.direction>0 && self.direction!=1){
        [self nextValue];
        BodyUnit *b = [self.units objectAtIndex:0];
        b.x++;
        if (b.x>self->xMax) {
            return NO;
        }
    return [self checkMoveRight:b];

//        return YES;
//    }
//    return NO;
}

-(BOOL)upStep{
//    if (self.direction>0 && self.direction!=4){
        [self nextValue];
        BodyUnit *b = [self.units objectAtIndex:0];
        b.y++;
        if (b.y>self->yMax) {
            return NO;
        }
    return [self checkMoveRight:b];

//        return YES;
//    }
//    return NO;
}

-(BOOL)downStep{
//    if (self.direction>0 && self.direction!=3){
        [self nextValue];
        BodyUnit *b = [self.units objectAtIndex:0];
        b.y--;
        if (b.y<0) {
            return NO;
        }
    return [self checkMoveRight:b];

//        return YES;
//    }
//    return NO;
}

-(BOOL)eatFood:(Food *)f{
    BodyUnit *b = self.units[0];
    if (f.x==b.x && f.y==b.y) {
        BodyUnit *b2 = self.units[self.units.count-1];//尾巴
        BodyUnit *b1 = self.units[self.units.count-2];
        if (b1.x==b2.x) {
            BodyUnit *bx = [[BodyUnit alloc]init];
            if (b1.y>b2.y) {
                bx.y=b2.y-1;
            }
            else if (b1.y<b2.y){
                bx.y=b2.y+1;
            }
            bx.x=b2.x;
            [self.units addObject:bx];
        }
        else if(b1.y==b2.y){
            BodyUnit *bx = [[BodyUnit alloc]init];
            if (b1.x>b2.x) {
                bx.x=b2.x-1;
            }
            else if (b1.x<b2.x){
                bx.x=b2.x+1;
            }
            bx.y=b2.y;
            [self.units addObject:bx];
        }
        [f newFood];
        return YES;
    }
    return NO;
}

@end
