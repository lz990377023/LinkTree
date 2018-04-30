//
//  GIFDotNetAPIClient.h
//  GIFLibrary
//
//  Created by lizhan on 2017/12/15.
//  Copyright © 2017年 lizhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
@interface LTDotNetAPIClient : AFHTTPSessionManager
+ (instancetype)sharedClient;
@end
