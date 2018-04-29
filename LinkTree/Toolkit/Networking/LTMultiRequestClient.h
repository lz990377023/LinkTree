//
//  LTMultiRequestClient.h
//  LinkTree
//
//  Created by lizhan on 2018/3/22.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTRequestClient.h"


typedef NS_ENUM(NSInteger,MultiRequestCompletionStatus){
    MultiRequestCompletionStatusAllComplete,
    MultiRequestCompletionStatusPartComplete,
    MultiRequestCompletionStatusAllFailed,
};


@class LTMultiRequestClient;

typedef void(^MultiRequestCompletionBlock)(LTMultiRequestClient *multiRequest);

typedef LTRequestClient *(^MultiRequestClientIndexBlock)(LTRequestClient *requestClient,int index);

@interface LTMultiRequestClient : NSObject
{
    @package
    MultiRequestCompletionStatus completionState;
}
/*
 * 请求地址
 */
@property (nonatomic ,strong ,readonly) NSString *URLString;

/*
 * 请求内容
 */
@property (nonatomic ,strong ,readonly) id parameters;

@property (nonatomic ,strong ,readonly) NSArray <LTRequestClient *>* requestItems;

/*
 * 多个请求完成状态
 */
@property (nonatomic ,assign ,readonly) MultiRequestCompletionStatus completionState;

/*
 * 多个请求完成block
 */
@property (nonatomic ,copy) MultiRequestCompletionBlock completionBlock;

/*
 * 将要请求的block
 */
@property (nonatomic ,copy) MultiRequestClientIndexBlock willRequestClientBlock;

/*
 * 已经请求的block
 */
@property (nonatomic ,copy) MultiRequestClientIndexBlock didRequestClientBlock;

+(instancetype)manager;

// multiRequest
- (void)multiRequest:(NSArray <LTRequestClient *>*)requestItems didRequestClient:(MultiRequestClientIndexBlock)didRequestClientBlock completionBlock:(MultiRequestCompletionBlock)completionBlock;

// dependMultiRequest
- (void)dependMultiRequest:(NSArray <LTRequestClient *>*)requestItems willRequestClient:(MultiRequestClientIndexBlock)willRequestClientBlock completionBlock:(MultiRequestCompletionBlock)completionBlock;

@end

// LTMultiUploadClient
@interface LTMultiRequestClient (LTMultiUploadClient)

// init
- (instancetype)initWithURLString:(NSString *)URLString;
- (instancetype)initWithURLString:(NSString *)URLString parameters:(id)parameters;

// multiUpload
- (void)multiUploadWithDataSource:(NSArray <UploadDataSource *>*)dataSourceItem didRequestClient:(MultiRequestClientIndexBlock)didRequestClientBlock completionBlock:(MultiRequestCompletionBlock)completionBlock;

// dependMultiUpload
- (void)dependMultiUploadWithDataSource:(NSArray <UploadDataSource *>*)dataSourceItem willRequestClient:(MultiRequestClientIndexBlock)willRequestClientBlock completionBlock:(MultiRequestCompletionBlock)completionBlock;

@end


