//
//  NSObject+LTExtension.m
//  LinkTree
//
//  Created by lizhan on 2018/4/3.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import "NSObject+LTExtension.h"

@implementation NSObject (LTExtension)

- (BOOL)isNullObject{
    if (self == nil || self == NULL) {return YES;}
    
    if ([self isKindOfClass:[NSNull class]]) {return YES;}
    
    if (self == [NSObject alloc]){return YES;}
    
    return NO;
}

+ (NSString *)className{
    return NSStringFromClass([self class]);
}

- (NSString *)className{
    return NSStringFromClass([self class]);
}
@end
