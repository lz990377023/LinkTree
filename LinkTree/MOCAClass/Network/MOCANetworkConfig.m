//
//  MOCANetworkConfig.m
//  LinkTree
//
//  Created by 李沾 on 2018/5/26.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import "MOCANetworkConfig.h"

@implementation MOCANetworkConfig

+ (instancetype)manage{
    static MOCANetworkConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[MOCANetworkConfig alloc]init];
    });
    return config;
}

- (NSDictionary *)publicParams{
    NSDictionary *params = @{@"pkg":LT_PUBLIC_PKG,
                             @"cid":@"",
                             @"did":@"",
                             @"os":@"",
                             @"version":@"",
                             @"lang":@"",
                             @"model":@"",
                             @"cert":@"",
                             @"token":@""
                             };
    return params;
}


@end
