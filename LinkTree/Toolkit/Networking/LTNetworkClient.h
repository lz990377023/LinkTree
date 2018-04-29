//
//  LTNetworkClient.h
//  LinkTree
//
//  Created by lizhan on 2018/3/13.
//  Copyright © 2018年 李沾. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTRequestClient.h"
#import "LTMultiRequestClient.h"
@interface LTNetworkClient : NSObject

+(instancetype)manager;

- (void)startRequest:(LTRequestClient *)request;

- (void)startMultiRequests:(LTMultiRequestClient *)multiRequests;

- (void)resumeRequest:(LTRequestClient *)request;

- (void)suspendRequest:(LTRequestClient *)request;

- (void)cancelRequest:(LTRequestClient *)request;

@end
