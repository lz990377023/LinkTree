//
//  NSArray+LGExtend.m
//  LinkTree
//
//  Created by lizhan on 2018/4/3.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import "NSArray+LGExtend.h"

@implementation NSArray (LGExtend)
- (BOOL)isNullArray{
    if (self == nil || self == Nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (self == [NSArray alloc])
    {
        return YES;
    }
    if (self.count == 0)
    {
        return YES;
    }
    if (![self isKindOfClass:[NSArray class]]) {
        return YES;
    }
    return NO;
}
@end
