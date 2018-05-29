//
//  MOCALoginRequesManage.h
//  LinkTree
//
//  Created by 李沾 on 2018/5/29.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import "MOCARequestManage.h"
#import "MOCAUserInfoModel.h"
@interface MOCALoginRequesManage : MOCARequestManage
- (void)requestLoginWithParams:(NSDictionary *)params success:(void (^)(MOCAUserInfoModel *userInfoModel))success failure:(void (^)(LTRequestClient *request))failure;



@end
