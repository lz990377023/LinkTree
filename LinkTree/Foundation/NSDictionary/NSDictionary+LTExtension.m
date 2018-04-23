//
//  NSDictionary+LTExtension.m
//  LinkTree
//
//  Created by lizhan on 2018/4/3.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import "NSDictionary+LTExtension.h"

@implementation NSDictionary (LTExtension)
- (BOOL)isNullDictionary{
    if (self == nil || self == Nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (self == [NSDictionary alloc])
    {
        return YES;
    }
    if (self.count == 0)
    {
        return YES;
    }
    if (![self isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    return NO;
}
@end
