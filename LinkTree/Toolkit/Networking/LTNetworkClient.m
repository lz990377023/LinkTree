//
//  LTNetworkClient.m
//  LinkTree
//
//  Created by lizhan on 2018/3/13.
//  Copyright © 2018年 李沾. All rights reserved.
//

#import "LTNetworkClient.h"
#import <AFNetworking/AFNetworking.h>
@interface LTNetworkClient()
@property (nonatomic ,strong) AFURLSessionManager *sessionManager;
@property (nonatomic ,strong) LTMultiRequestClient *multiRequestClient;
@end


inline static AFHTTPRequestSerializer *createRequestSerializerWithRequestClient(LTRequestClient *request){
    switch (request.requestSerializerType) {
        case LTRequestSerializerTypeHTTP:{
            return [AFHTTPRequestSerializer serializer];;
        }break;
        case LTRequestSerializerTypeJSON:{
            return [AFJSONRequestSerializer serializer];
        }break;
    }
}

inline static AFHTTPResponseSerializer <AFURLResponseSerialization> *createResponseSerializerWithRequestClient(LTRequestClient *request){
    switch (request.responseSerializerType) {
        case LTResponseSerializerTypeHTTP:{
            return [AFHTTPResponseSerializer serializer];
        }break;
        case LTResponseSerializerTypeJSON:{
            return [AFJSONResponseSerializer serializer];
        }break;
        case LTResponseSerializerTypeXMLParser:{
            return [AFXMLParserResponseSerializer serializer];
        }break;
    }
}

@implementation LTNetworkClient
+ (instancetype)manager {
    static LTNetworkClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[LTNetworkClient alloc]init];
    });
    return _sharedClient;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _sessionManager = [[AFURLSessionManager alloc]initWithSessionConfiguration:[self createURLSessionConfiguration]];
    }
    return self;
}

- (NSURLSessionConfiguration *)createURLSessionConfiguration{
    NSURLSessionConfiguration *sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration;
    return sessionConfiguration;
}

//开始单个请求
-(void)startRequest:(LTRequestClient *)request{
    if (request == nil) {return;}
    [_sessionManager setResponseSerializer:createResponseSerializerWithRequestClient(request)];
    if (request.operationType == LTOperationTypeUpload) {
        //上传请求类型
        [self resumeRequest:[self requestWithUploadDataRequestClient:request completionBlock:nil]];
    }else if (request.operationType == LTOperationTypeRequest){
        //数据请求类型
        [self resumeRequest:[self requestWithRequestClient:request completionBlock:nil]];
    }
}

//开始多个请求

- (void)startMultiRequests:(LTMultiRequestClient *)multiRequests{
    if (multiRequests == nil) {return;}
    if (multiRequests.requestItems == nil) {return;}
    _multiRequestClient = multiRequests;
    __weak __typeof__ (self) weakSelf = self;
    [_multiRequestClient.requestItems enumerateObjectsUsingBlock:^(LTRequestClient * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.operationType == LTOperationTypeUpload) {
            [weakSelf resumeRequest:[self requestWithUploadDataRequestClient:obj completionBlock:^(LTRequestClient *completRequestClient) {
                if (weakSelf.multiRequestClient.didRequestClientBlock) {
                    weakSelf.multiRequestClient.didRequestClientBlock(completRequestClient,(int)[weakSelf.multiRequestClient.requestItems indexOfObject:completRequestClient]);
                }
                [weakSelf detectionMultiRequestsMultiRequestCompletionStatus];
            }]];
        }else{
            [weakSelf resumeRequest:[self requestWithRequestClient:obj completionBlock:^(LTRequestClient *completRequestClient) {
                if (weakSelf.multiRequestClient.didRequestClientBlock) {
                    weakSelf.multiRequestClient.didRequestClientBlock(completRequestClient,(int)[weakSelf.multiRequestClient.requestItems indexOfObject:completRequestClient]);
                }
                [weakSelf detectionMultiRequestsMultiRequestCompletionStatus];
            }]];
        }
    }];
}

- (void)detectionMultiRequestsMultiRequestCompletionStatus{
    __block int finishNumber = 0;
    __block int successNumber = 0;
    [_multiRequestClient.requestItems enumerateObjectsUsingBlock:^(LTRequestClient * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.requestFinish) {
            if (obj.dataTask.state == NSURLSessionTaskStateCompleted) {
                successNumber++;
            }
            finishNumber++;
        }
    }];
    if (finishNumber==_multiRequestClient.requestItems.count) {
        if (successNumber == finishNumber) {
            _multiRequestClient->completionState = MultiRequestCompletionStatusAllComplete;
        }else if (successNumber == 0){
            _multiRequestClient->completionState = MultiRequestCompletionStatusAllFailed;
        }else{
            _multiRequestClient->completionState = MultiRequestCompletionStatusPartComplete;
        }
    }
}

- (void)operationWithSerialRequest{
    __block int idx = 0;
    __weak __typeof__ (self) weakSelf = self;
    if (idx<(_multiRequestClient.requestItems.count)) {
        LTRequestClient *requestClient = _multiRequestClient.requestItems[idx];
        if (_multiRequestClient.willRequestClientBlock) {
            requestClient = _multiRequestClient.willRequestClientBlock(requestClient,idx);
        }
        if (requestClient.operationType == LTOperationTypeUpload) {
            [self resumeRequest:[self requestWithUploadDataRequestClient:requestClient completionBlock:^(LTRequestClient *completRequestClient) {
                switch (completRequestClient.dataTask.state) {
                    case NSURLSessionTaskStateRunning:{
                    }break;
                    case NSURLSessionTaskStateSuspended:{
                    }break;
                    case NSURLSessionTaskStateCanceling:{
                    }break;
                    case NSURLSessionTaskStateCompleted:{
                        idx++;
                        [weakSelf operationWithSerialRequest];
                        if (idx==_multiRequestClient.requestItems.count) {
                            [weakSelf detectionMultiRequestsMultiRequestCompletionStatus];
                        }
                    }break;
                }
            }]];
        }else{
            [self resumeRequest:[self requestWithRequestClient:requestClient completionBlock:^(LTRequestClient *completRequestClient) {
                switch (completRequestClient.dataTask.state) {
                    case NSURLSessionTaskStateRunning:{
                    }break;
                    case NSURLSessionTaskStateSuspended:{
                    }break;
                    case NSURLSessionTaskStateCanceling:{
                    }break;
                    case NSURLSessionTaskStateCompleted:{
                        idx++;
                        [weakSelf operationWithSerialRequest];
                        if (idx== weakSelf.multiRequestClient.requestItems.count) {
                            [weakSelf detectionMultiRequestsMultiRequestCompletionStatus];
                        }
                    }break;
                }
            }]];
        }
    }else{
        idx = 0;
    }
}


- (NSMutableURLRequest *)buildUrlRequestWithRequestClient:(LTRequestClient *)request error:(NSError *)serializationError{
    AFHTTPRequestSerializer *requestSerializer = createRequestSerializerWithRequestClient(request);
    NSMutableURLRequest *urlRequest = nil;
    switch (request.requestType) {
        case LTRequestTypeGET:{
            urlRequest = [requestSerializer requestWithMethod:@"GET" URLString:request.URLString parameters:request.parameters error:&serializationError] ;
        }break;
        case LTRequestTypePOST:{
            if (request.operationType == LTOperationTypeUpload){
                urlRequest = [self buildUrlRequestWithUploadRequestClient:request error:serializationError];
            }else{
                urlRequest = [requestSerializer requestWithMethod:@"POST" URLString:request.URLString parameters:request.parameters error:&serializationError];
            }
        }break;
        case LTRequestTypePUT:{
            urlRequest = [requestSerializer requestWithMethod:@"PUT" URLString:request.URLString parameters:request.parameters error:&serializationError];
        }break;
        case LTRequestTypeHEAD:{
            urlRequest = [requestSerializer requestWithMethod:@"HEAD" URLString:request.URLString parameters:request.parameters error:&serializationError];
        }break;
        case LTRequestTypePATCH:{
            urlRequest = [requestSerializer requestWithMethod:@"PATCH" URLString:request.URLString parameters:request.parameters error:&serializationError];
        }break;
        case LTRequestTypeDELETE:{
            urlRequest = [requestSerializer requestWithMethod:@"DELETE" URLString:request.URLString parameters:request.parameters error:&serializationError];
        }break;
    }
    urlRequest.timeoutInterval = request.timeoutInterval;
    return urlRequest;
}


- (NSMutableURLRequest *)buildUrlRequestWithUploadRequestClient:(LTRequestClient *)uploadRequestClient error:(NSError *)serializationError{
    AFHTTPRequestSerializer *requestSerializer = createRequestSerializerWithRequestClient(uploadRequestClient);
    __weak __typeof__ (self) weakSelf = self;
    NSMutableURLRequest *urlRequest = nil;
    NSMutableURLRequest *request = [requestSerializer multipartFormRequestWithMethod:@"POST" URLString:uploadRequestClient.URLString parameters:uploadRequestClient.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [weakSelf uploadWithMultipartFormData:formData uploadRequestClient:uploadRequestClient];
    } error:&serializationError];
    urlRequest.timeoutInterval = request.timeoutInterval;
    return urlRequest;
}

-(void)uploadWithMultipartFormData:(id<AFMultipartFormData>)formData uploadRequestClient:(LTRequestClient *)uploadRequestClient{
    switch (uploadRequestClient.uploadDataSoure.uploadStyle) {
        case UploadStyleFileData:{
            [formData appendPartWithFileData:uploadRequestClient.uploadDataSoure.fileData                         name:uploadRequestClient.uploadDataSoure.severFilePath fileName:uploadRequestClient.uploadDataSoure.fileName mimeType:uploadRequestClient.uploadDataSoure.mimeType];
        }break;
        case UploadStyleFilePath:{
            NSError *error = nil;
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:uploadRequestClient.uploadDataSoure.filePath]  name:uploadRequestClient.uploadDataSoure.severFilePath fileName:uploadRequestClient.uploadDataSoure.fileName mimeType:uploadRequestClient.uploadDataSoure.mimeType error:&error];
        }break;
    }
}

- (LTRequestClient *)requestWithRequestClient:(LTRequestClient *)requestClient completionBlock:(void (^)(LTRequestClient *completRequestClient))completRequestClient{
    NSError *serializationError = nil;
    NSMutableURLRequest *urlRequest = [self buildUrlRequestWithRequestClient:requestClient error:serializationError];
    if (serializationError) {
        if (requestClient.failureCompletionBlock) {
            dispatch_async(_sessionManager.completionQueue ?: dispatch_get_main_queue(), ^{
                requestClient->error = [LTRequestError laodError:serializationError];
                requestClient->dataTask = nil;
                if (requestClient.failureCompletionBlock) {
                    requestClient.failureCompletionBlock(requestClient);
                }
            });
        }
        return nil;
    }
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [_sessionManager dataTaskWithRequest:urlRequest uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        requestClient->progrss = uploadProgress;
        if (requestClient.progressBlock) {
            requestClient.progressBlock(requestClient);
        }
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        requestClient->progrss = downloadProgress;
        if (requestClient.progressBlock) {
            requestClient.progressBlock(requestClient);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        requestClient->requestFinish = YES;
        if (error) {
            requestClient->dataTask = dataTask;
            requestClient->error = [LTRequestError laodError:error];
            if (requestClient.failureCompletionBlock) {
                requestClient.failureCompletionBlock(requestClient);
            }
        }else{
            if (requestClient.successCompletionBlock) {
                requestClient->dataTask = dataTask;
                requestClient->responseObject = responseObject;
                requestClient->error = nil;
                if (requestClient.successCompletionBlock) {
                    requestClient.successCompletionBlock(requestClient);
                }
            }
        }
        if (completRequestClient) {
            completRequestClient(requestClient);
        }
    }];
    requestClient->dataTask = dataTask;
    return requestClient;
}

- (LTRequestClient *)requestWithUploadDataRequestClient:(LTRequestClient *)uploadRequestClient completionBlock:(void (^)(LTRequestClient *completRequestClient))completRequestClient{
    NSError *serializationError = nil;
    NSMutableURLRequest *urlRequest = [self buildUrlRequestWithRequestClient:uploadRequestClient error:serializationError];
    if (serializationError) {
        if (uploadRequestClient.failureCompletionBlock) {
            dispatch_async(_sessionManager.completionQueue ?: dispatch_get_main_queue(), ^{
                uploadRequestClient->error = [LTRequestError laodError:serializationError];
                uploadRequestClient->dataTask = nil;
                if (uploadRequestClient.failureCompletionBlock) {
                    uploadRequestClient.failureCompletionBlock(uploadRequestClient);
                }
            });
        }
        return nil;
    }
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [_sessionManager uploadTaskWithStreamedRequest:urlRequest progress:^(NSProgress * _Nonnull uploadProgress) {
        uploadRequestClient->progrss = uploadProgress;
        if (uploadRequestClient.progressBlock) {
            uploadRequestClient.progressBlock(uploadRequestClient);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        uploadRequestClient->requestFinish = YES;
        if (error) {
            uploadRequestClient->dataTask = dataTask;
            uploadRequestClient->error = [LTRequestError laodError:error];
            if (uploadRequestClient.failureCompletionBlock) {
                uploadRequestClient.failureCompletionBlock(uploadRequestClient);
            }
        }else{
            if (uploadRequestClient.successCompletionBlock) {
                uploadRequestClient->dataTask = dataTask;
                uploadRequestClient->responseObject = responseObject;
                uploadRequestClient->error = nil;
                if (uploadRequestClient.successCompletionBlock) {
                    uploadRequestClient.successCompletionBlock(uploadRequestClient);
                }
            }
        }
        if (completRequestClient) {
            completRequestClient(uploadRequestClient);
        }
    }];
    uploadRequestClient->dataTask = dataTask;
    return uploadRequestClient;
}

- (void)cancelRequest:(LTRequestClient *)request{
    if (request.dataTask == nil) {return;}
    [request.dataTask cancel];
}

- (void)suspendRequest:(LTRequestClient *)request{
    if (request.dataTask == nil) {return;}
    [request.dataTask suspend];
}

- (void)resumeRequest:(LTRequestClient *)request{
    if (request.dataTask == nil) {return;}
    [request.dataTask resume];
}





@end
