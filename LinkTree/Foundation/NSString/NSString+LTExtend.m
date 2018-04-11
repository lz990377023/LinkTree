//
//  NSString+LTExtend.m
//  LinkTree
//
//  Created by lizhan on 2018/4/3.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import "NSString+LTExtend.h"

@implementation NSString (LTExtend)
- (BOOL)isNullString{
    if (self == nil || self == Nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (self == [NSString alloc]) {
        return YES;
    }
    if (self.length == 0) {
        return YES;
    }
    if (![self isKindOfClass:[NSString class]]) {
        return YES;
    }
    return NO;
}


@end
