//
//  GIFDotNetAPIClient.m
//  GIFLibrary
//
//  Created by lizhan on 2017/12/15.
//  Copyright © 2017年 lizhan. All rights reserved.
//

#import "LTDotNetAPIClient.h"
static NSString * const LTDotNetAPIBaseURLString = @"https://www.apple.com";
@implementation LTDotNetAPIClient
+ (instancetype)sharedClient {
    static LTDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[LTDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:LTDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    return _sharedClient;
}
@end
