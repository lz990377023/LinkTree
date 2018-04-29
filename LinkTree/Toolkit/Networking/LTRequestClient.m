 //
//  LTRequesClient.m
//  LinkTree
//
//  Created by lizhan on 2018/3/13.
//  Copyright © 2018年 李沾. All rights reserved.
//

#import "LTRequestClient.h"
#import "LTNetworkClient.h"

@implementation UploadDataSource
@end


@implementation LTRequestOptions

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static LTRequestOptions *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self shareInstance];
}

- (void)defaultOptions{
    _timeoutInterval = 30.f;
    _requestType = LTRequestTypePOST;
    _requestSerializerType = LTRequestSerializerTypeHTTP;
    _responseSerializerType = LTResponseSerializerTypeHTTP;
}


@end


@implementation LTRequestClient

+(instancetype)manager{
    LTRequestClient *requestClient = [[LTRequestClient alloc]init];
    return requestClient;
}

- (instancetype)init{
    return [self initWithURLString:@""];
}

- (instancetype)initWithURLString:(NSString *)URLString{
    return [self initWithURLString:URLString parameters:nil];
}

- (instancetype)initWithURLString:(NSString *)URLString parameters:(id)parameters{
    self = [super init];
    if (self) {
        _URLString = URLString;
        _parameters = parameters;
        [[LTRequestOptions shareInstance] defaultOptions];
        _timeoutInterval = [LTRequestOptions shareInstance].timeoutInterval;
        _requestType = [LTRequestOptions shareInstance].requestType;
        _requestSerializerType = [LTRequestOptions shareInstance].requestSerializerType;
        _responseSerializerType = [LTRequestOptions shareInstance].responseSerializerType;
    }
    return self;
}

- (id)responseObject{
    return responseObject;
}

- (id)responseJsonObject{
    return responseJsonObject;
}

- (LTRequestError *)requestError{
    return error;
}

- (BOOL)requestFinish{
    return requestFinish;
}

- (NSProgress *)progrss{
    return progrss;
}

- (NSURLSessionDataTask *)dataTask{
    return dataTask;
}

- (void)setSuccessCompletionBlock:(RequestCompletionBlock)successCompletionBlock{
    _successCompletionBlock = successCompletionBlock;
}

- (void)setFailureCompletionBlock:(RequestCompletionBlock)failureCompletionBlock{
    _failureCompletionBlock = failureCompletionBlock;
}

-(LTRequestClient *)timeoutInterval:(NSTimeInterval)timeoutInterval{
    _timeoutInterval = timeoutInterval;
    return self;
}

- (LTRequestClient *)requestType:(LTRequestType)requestType{
    _requestType = requestType;
    return self;
}

- (LTRequestClient *)operationType:(LTOperationType)operationType{
    _operationType = operationType;
    return self;
}

- (LTRequestClient *)requestSerializerType:(LTRequestSerializerType)requestSerializerType{
    _requestSerializerType = requestSerializerType;
    return self;
}

- (LTRequestClient *)responseSerializerType:(LTResponseSerializerType)responseSerializerType{
    _responseSerializerType = responseSerializerType;
    return self;
}


- (void)resume{
    [[LTNetworkClient manager] resumeRequest:self];
}

- (void)suspend{
    [[LTNetworkClient manager] suspendRequest:self];
}

- (void)cancel{
    [[LTNetworkClient manager] cancelRequest:self];
}

- (void)request{
    [[LTNetworkClient manager] startRequest:self];
};

- (void)requestCompletionBlockWithSuccess:(RequestCompletionBlock)success failure:(RequestCompletionBlock)failure{
    _successCompletionBlock = success;
    _failureCompletionBlock = failure;
    [self request];
}

- (void)requestCompletionBlockWithProgress:(RequestProgressBlock)progress success:(RequestCompletionBlock)success failure:(RequestCompletionBlock)failure{
    self.progressBlock = progress;
    _successCompletionBlock = success;
    _failureCompletionBlock = failure;
    [self request];
}

@end


@implementation LTRequestClient (LTUploadData)

- (void)uploadWithDataSource:(UploadDataSource *)dataSource progress:(RequestProgressBlock)progress success:(RequestCompletionBlock)success failure:(RequestCompletionBlock)failure{
    [self configRequestClientWithUploadDataSource:dataSource];
    self.progressBlock = progress;
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)configRequestClientWithUploadDataSource:(UploadDataSource *)dataSource{
    self.uploadDataSoure = dataSource;
    [self timeoutInterval:30];
    [self requestType:LTRequestTypePOST];
    [self operationType:LTOperationTypeUpload];
}
@end
