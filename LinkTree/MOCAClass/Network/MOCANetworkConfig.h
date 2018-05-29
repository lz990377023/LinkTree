//
//  MOCANetworkConfig.h
//  LinkTree
//
//  Created by 李沾 on 2018/5/26.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTRequestClient.h"
#import "MOCANetworkEnum.h"

@interface MOCANetworkConfig : NSObject
@property (nonatomic ,strong) NSString *hostAddress;
@property (nonatomic ,strong) NSString *scoketAddress;

+ (instancetype)manage;

- (NSDictionary *)publicParams;

@end

LTRequestClient *MOCARequestClient(MOCARequest request,NSDictionary *params){
    NSDictionary *publicParam = [[MOCANetworkConfig manage] publicParams];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:publicParam];
    [dict addEntriesFromDictionary:params];
    return LTRequesUrlWithParameters([MOCANetworkEnum urlWithRequest:request], [dict copy]);
}
