//
//  Food.h
//  Snake
//
//  Created by Jerry.Yang on 2020/11/2.
//  Copyright © 2020 Jerry.Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Food : NSObject
@property(nonatomic) unsigned short x,y;
-(id)initX:(unsigned short)xMax Y:(unsigned short)yMax;
-(void)newFood;
@end

NS_ASSUME_NONNULL_END
