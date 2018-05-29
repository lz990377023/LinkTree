//
//  MOCALoginRequesManage.m
//  LinkTree
//
//  Created by 李沾 on 2018/5/29.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import "MOCALoginRequesManage.h"

@implementation MOCALoginRequesManage
- (void)requestLoginWithParams:(NSDictionary *)params success:(void (^)(MOCAUserInfoModel *userInfoModel))success failure:(void (^)(LTRequestClient *request))failure{
    [MOCARequestClient(MOCARequestUserLoginUrl, params) requestCompletionBlockWithSuccess:^(LTRequestClient *request) {
        
    } failure:^(LTRequestClient *request) {
        
    }];
    
}
@end
