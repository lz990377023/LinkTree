//
//  LTMultiRequestClient.m
//  LinkTree
//
//  Created by lizhan on 2018/3/22.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import "LTMultiRequestClient.h"
#import "LTNetworkClient.h"
@implementation LTMultiRequestClient

+ (instancetype)manager{
    LTMultiRequestClient *requestClient = [[LTMultiRequestClient alloc]init];
    return requestClient;
}

- (MultiRequestCompletionStatus)completionState{
    return completionState;
}

- (void)multiRequest:(NSArray<LTRequestClient *> *)requestItems didRequestClient:(MultiRequestClientIndexBlock)didRequestClientBlock completionBlock:(MultiRequestCompletionBlock)completionBlock{
    _requestItems = requestItems;
    self.didRequestClientBlock = didRequestClientBlock;
    self.completionBlock = completionBlock;
    [self request];
}

- (void)dependMultiRequest:(NSArray <LTRequestClient *>*)requestItems willRequestClient:(MultiRequestClientIndexBlock)willRequestClientBlock completionBlock:(MultiRequestCompletionBlock)completionBlock{
    _requestItems = requestItems;
    self.completionBlock = completionBlock;
    self.willRequestClientBlock = willRequestClientBlock;
    [self request];
}

- (void)request{
    [[LTNetworkClient manager] startMultiRequests:self];
};

@end

@implementation LTMultiRequestClient (LTMultiUploadClient)

- (instancetype)initWithURLString:(NSString *)URLString{
    return [self initWithURLString:URLString parameters:nil];
}

- (instancetype)initWithURLString:(NSString *)URLString parameters:(id)parameters{
    self = [super init];
    if (self) {
        _URLString = URLString;
        _parameters = parameters;
    }
    return self;
}

- (void)multiUploadWithDataSource:(NSArray <UploadDataSource *>*)dataSourceItem didRequestClient:(MultiRequestClientIndexBlock)didRequestClientBlock completionBlock:(MultiRequestCompletionBlock)completionBlock{
    [self multiRequest:[self configRequestClientWithUploadDataSourceItem:dataSourceItem] didRequestClient:didRequestClientBlock completionBlock:completionBlock];
}


- (void)dependMultiUploadWithDataSource:(NSArray <UploadDataSource *>*)dataSourceItem willRequestClient:(MultiRequestClientIndexBlock)willRequestClientBlock completionBlock:(MultiRequestCompletionBlock)completionBlock{
    [self dependMultiRequest:[self configRequestClientWithUploadDataSourceItem:dataSourceItem] willRequestClient:willRequestClientBlock completionBlock:completionBlock];
}

- (NSArray *)configRequestClientWithUploadDataSourceItem:(NSArray <UploadDataSource *>*)dataSourceItem{
    NSMutableArray *requestItems = [NSMutableArray array];
    [dataSourceItem enumerateObjectsUsingBlock:^(UploadDataSource * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LTRequestClient *requestClient = LTRequesUrlWithParameters(_URLString, _parameters);
        requestClient.uploadDataSoure = obj;
        [requestClient timeoutInterval:30];
        [requestClient requestType:LTRequestTypePOST];
        [requestClient operationType:LTOperationTypeUpload];
        [requestItems addObject:requestClient];
    }];
    return [requestItems copy];
}
@end

