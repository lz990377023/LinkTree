//
//  LTRequesError.m
//  LinkTree
//
//  Created by lizhan on 2018/3/13.
//  Copyright © 2018年 李沾. All rights reserved.
//

#import "LTRequestError.h"

@implementation LTRequestError
+ (instancetype)laodError:(NSError *)error{
    LTRequestError *requestError = [[LTRequestError alloc]initWithError:error];
    return requestError;
}

- (instancetype)initWithError:(NSError *)error{
    self = [super init];
    if (self) {
        _error = error;
    }
    return self;
}


@end
