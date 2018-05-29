//
//  MOCARequestManage.m
//  LinkTree
//
//  Created by 李沾 on 2018/5/29.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import "MOCARequestManage.h"
#import <objc/runtime.h>

@implementation MOCARequestManage
+ (instancetype)manage{
    id instance = objc_getAssociatedObject(self, @"instance");
    if (!instance)
    {
        instance = [[super allocWithZone:NULL] init];
        objc_setAssociatedObject(self, @"instance", instance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return instance;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [self manage] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    Class selfClass = [self class];
    return [selfClass manage] ;
}

@end
