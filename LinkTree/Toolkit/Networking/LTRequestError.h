//
//  LTRequesError.h
//  LinkTree
//
//  Created by lizhan on 2018/3/13.
//  Copyright © 2018年 李沾. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTRequestError : NSObject
@property (nonatomic ,assign, readonly) NSError *error;
@property (nonatomic ,assign, readonly) int code;
@property (nonatomic ,strong, readonly) NSString *errorMessage;
@property (nonatomic ,strong, readonly) NSString *errorUrl;

+ (instancetype)laodError:(NSError *)error;
@end
