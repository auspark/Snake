//
//  Food.m
//  Snake
//
//  Created by Jerry.Yang on 2020/11/2.
//  Copyright © 2020 Jerry.Yang. All rights reserved.
//

#import "Food.h"

@interface Food ()
{
    unsigned short xMax,yMax;
}

@end

@implementation Food

-(id)initX:(unsigned short)xMax Y:(unsigned short)yMax{
    if (self=[super init]) {
        self->xMax=xMax;
        self->yMax=yMax;
        self.x=0;
        self.y=0;
    }
    return self;
}

-(void)newFood{
    self.x=(unsigned short)arc4random()%(self->xMax+1);//0-6
    self.y=(unsigned short)arc4random()%(self->yMax+1); //0-3
}

@end
