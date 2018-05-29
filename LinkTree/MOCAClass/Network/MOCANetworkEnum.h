//
//  MOCANetworkEnum.h
//  LinkTree
//
//  Created by 李沾 on 2018/5/26.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger ,MOCARequest){
    MOCARequestUserRegisterUrl,
    MOCARequestUserVerificationCodeUrl,
    MOCARequestUserLoginUrl,
    MOCARequestUserPasswordUrl,
    MOCARequestUserLogoutUrl,
};

@interface MOCANetworkEnum : NSObject
+ (NSString *)urlWithRequest:(MOCARequest)request;
@end
