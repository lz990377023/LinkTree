//
//  LTRequesClient.h
//  LinkTree
//
//  Created by lizhan on 2018/3/13.
//  Copyright © 2018年 李沾. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTRequestError.h"
typedef NS_ENUM(NSInteger, LTRequestType) {
    // GET
    LTRequestTypeGET,
    // POST
    LTRequestTypePOST,
    // HEAD
    LTRequestTypeHEAD,
    // PUT
    LTRequestTypePUT,
    // DELETE
    LTRequestTypeDELETE,
    // PATCH
    LTRequestTypePATCH,
};

typedef NS_ENUM(NSInteger ,LTOperationType){
    LTOperationTypeRequest,
    LTOperationTypeUpload,
    LTOperationTypeDownload,
};

typedef NS_ENUM(NSInteger,  LTRequestSerializerType) {
    LTRequestSerializerTypeHTTP ,
    LTRequestSerializerTypeJSON,
};


typedef NS_ENUM(NSInteger,  LTResponseSerializerType) {
    /// NSData type
    LTResponseSerializerTypeHTTP,
    /// JSON object type
    LTResponseSerializerTypeJSON,
    /// NSXMLParser type
    LTResponseSerializerTypeXMLParser,
};

typedef NS_ENUM(NSInteger,UploadStyle){
    UploadStyleFileData,
    UploadStyleFilePath,
};


@interface LTRequestOptions :NSObject

+ (instancetype _Nonnull)shareInstance;
/*
 * 请求超时
 */
@property (nonatomic ,assign ) NSTimeInterval timeoutInterval;

/*
 * 请求类型 GET / POST / HEAD / PUT / DELETE / PATCH
 */
@property (nonatomic ,assign ) LTRequestType requestType;

/*
 * 请求序列化类型
 */
@property (nonatomic ,assign ) LTRequestSerializerType requestSerializerType;

/*
 *  数据返回序列化类型
 */
@property (nonatomic ,assign ) LTResponseSerializerType  responseSerializerType;

- (void)defaultOptions;

@end

@class LTRequestClient;

typedef void (^RequestCompletionBlock)(LTRequestClient *request);

typedef void (^RequestProgressBlock)(LTRequestClient *request);

@interface UploadDataSource :NSObject
@property (nonatomic ,assign) UploadStyle uploadStyle;
@property (nonatomic ,strong) NSString *fileName;
@property (nonatomic ,strong) NSString *severFilePath;
@property (nonatomic ,strong) NSString *filePath;
@property (nonatomic ,strong) NSData *fileData;
@property (nonatomic ,strong) NSString *mimeType;
@end

@interface LTRequestClient : NSObject
{
    @package
    id responseObject;
    id responseJsonObject;
    LTRequestError *error;
    BOOL requestFinish;
    NSProgress *progrss;
    NSURLSessionDataTask *dataTask;
}
/*
 * 请求地址
 */
@property (nonatomic ,strong ,readonly) NSString *URLString;

/*
 * 请求参数
 */
@property (nonatomic ,strong ,readonly) id parameters;

/*
 *  上传的数据
 */
@property (nonatomic ,strong ,readwrite) UploadDataSource *uploadDataSoure;

/*
 *  操作类型 request / uplaod / download
 */
@property (nonatomic ,assign ,readonly) LTOperationType operationType;

/*
 * 请求超时
 */
@property (nonatomic ,assign ,readonly) NSTimeInterval timeoutInterval;

/*
 *  请求是否结束
 */
@property (nonatomic ,assign ,readonly) BOOL requestFinish;

/*
 * 请求类型 GET / POST / HEAD / PUT / DELETE / PATCH
 */
@property (nonatomic ,assign ,readonly) LTRequestType requestType;

/*
 * 请求序列化类型
 */
@property (nonatomic ,assign ,readonly) LTRequestSerializerType requestSerializerType;

/*
 *  数据返回序列化类型
 */
@property (nonatomic ,assign ,readonly) LTResponseSerializerType  responseSerializerType;

/*
 * 返回数据
 */
@property (nonatomic ,strong ,readonly) id responseObject;
@property (nonatomic ,strong ,readonly) id responseJsonObject;

/*
 * 网络加载进度
 */
@property (nonatomic ,strong ,readonly) NSProgress *progrss;

/*
 * 网络请求任务
 */
@property (nonatomic ,strong ,readonly) NSURLSessionDataTask *dataTask;

/*
 * 加载失败
 */
@property (nonatomic ,strong ,readonly) LTRequestError *requestError;

/*
 *  状态回调
 */
@property (nonatomic ,copy ) RequestCompletionBlock successCompletionBlock;
@property (nonatomic ,copy ) RequestCompletionBlock failureCompletionBlock;
@property (nonatomic ,copy ) RequestProgressBlock progressBlock;

+ (instancetype)manager;

// request init
- (instancetype)init;
- (instancetype)initWithURLString:(NSString *)URLString;
- (instancetype)initWithURLString:(NSString *)URLString parameters:(id)parameters;

// request setting
- (LTRequestClient *)timeoutInterval:(NSTimeInterval)timeoutInterval;
- (LTRequestClient *)requestType:(LTRequestType)requestType;
- (LTRequestClient *)operationType:(LTOperationType)operationType;
- (LTRequestClient *)requestSerializerType:(LTRequestSerializerType)requestSerializerType;
- (LTRequestClient *)responseSerializerType:(LTResponseSerializerType)responseSerializerType;

// resume request
- (void)resume;
// suspend request
- (void)suspend;
// cancel request
- (void)cancel;

// request Operate
- (void)request;
- (void)requestCompletionBlockWithSuccess:(RequestCompletionBlock)success failure:(RequestCompletionBlock)failure;
- (void)requestCompletionBlockWithProgress:(RequestProgressBlock)progress success:(RequestCompletionBlock)success failure:(RequestCompletionBlock)failure;

@end

// LTUploadData
@interface LTRequestClient (LTUploadData)

//upload
- (void)uploadWithDataSource:(UploadDataSource *)dataSource progress:(RequestProgressBlock)progress success:(RequestCompletionBlock)success failure:(RequestCompletionBlock)failure;
@end

inline static LTRequestClient* LTRequesUrl(NSString *URLString){
    return [[LTRequestClient manager] initWithURLString:URLString];
}

inline static LTRequestClient* LTRequesUrlWithParameters(NSString *URLString,id parameters){
    return [[LTRequestClient manager] initWithURLString:URLString parameters:parameters];
}
