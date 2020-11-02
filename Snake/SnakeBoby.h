//
//  SnakeBoby.h
//  Snake
//
//  Created by Jerry.Yang on 2020/11/2.
//  Copyright © 2020 Jerry.Yang. All rights reserved.
//

#import <Foundation/Foundation.h>


#define SquareSize 20
#define SpaceSize 2
#import "Food.h"

@interface BodyUnit : NSObject
@property(nonatomic) short x,y;
@end

@interface SnakeBoby : NSObject
/*
 direction:
 0:stop
 1:left
 2:right
 3:up
 4:down
 */
@property(nonatomic) unsigned short direction;
@property(nonatomic) NSMutableArray *units;
-(id)initX:(unsigned short)xMax Y:(unsigned short)yMax;
-(void)addInitBody;
-(BOOL)doMoveStep;
-(BOOL)leftStep;
-(BOOL)rightStep;
-(BOOL)upStep;
-(BOOL)downStep;
-(BOOL)eatFood:(Food *)f;
@end

