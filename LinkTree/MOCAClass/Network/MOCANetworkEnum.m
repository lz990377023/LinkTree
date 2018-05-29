//
//  MOCANetworkEnum.m
//  LinkTree
//
//  Created by 李沾 on 2018/5/26.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import "MOCANetworkEnum.h"

@implementation MOCANetworkEnum
+ (NSString *)urlWithRequest:(MOCARequest)request{
    NSString *url = @"";
    switch (request) {
        case MOCARequestUserRegisterUrl:{
            url = @"/user/register";
        }break;
        case MOCARequestUserVerificationCodeUrl:{
            url = @"/user/verificationCode";
        }break;
        case MOCARequestUserLoginUrl:{
            url = @"/user/login";
        }break;
        case MOCARequestUserLogoutUrl:{
            url = @"/user/logout";
        }break;
        case MOCARequestUserPasswordUrl:{
            url = @"/user/password";
        }break;
    }
    return url;
}
@end
