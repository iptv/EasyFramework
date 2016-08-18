//
//  ESHTTPSessionManager.m
//  EasyFramework
//
//  Created by 习聚 on 16/8/18.
//
//

#import "ESHTTPSessionManager.h"
#import <AFNetworking.h>

/**
 *  默认请求超时时间
 */
static CGFloat kESHTTPTimeoutInterval = 10.0;

@interface ESHTTPSessionManager ()

@property (readwrite, nonatomic,strong) AFHTTPSessionManager *sessionManager;

@property (readwrite, nonatomic, copy) NSString *requestURLString;

@end

@implementation ESHTTPSessionManager

+ (instancetype)manager {
    return [[[self class] alloc] init];
}

- (id)init {
    self = [super init];
    if (self) {
        self.sessionManager = [AFHTTPSessionManager manager];
        AFJSONResponseSerializer *jsonResponseSerializer = [AFJSONResponseSerializer serializer];
        jsonResponseSerializer.removesKeysWithNullValues = YES;
        self.sessionManager.responseSerializer = jsonResponseSerializer;
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript",@"application/json",@"text/json", @"text/html", nil];
        self.sessionManager.requestSerializer  = [AFHTTPRequestSerializer serializer];
        [self.sessionManager.requestSerializer setTimeoutInterval:kESHTTPTimeoutInterval];
    }
    
    return self;
}

- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval{
     [self.sessionManager.requestSerializer setTimeoutInterval:timeoutInterval];
}

- ( NSURLSessionDataTask *)sendRequest:(NSString *)requestURLString
         httpMethod:(NSString *)method
         parameters:(id)parameters
    requestDataType:(ESRequestDataType)type
           progress:(void (^)(NSProgress *uploadProgress))uploadProgress
            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    self.requestURLString = requestURLString;
    NSURLSessionDataTask *dataTask;
    
    if (type == ESJsonType) {
         self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    if ([[method uppercaseString] isEqualToString:@"GET"]) {
        [self.sessionManager GET:_requestURLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(task, responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(task, error);
        }];
    }
    else if ([[method uppercaseString] isEqualToString:@"POST"]) {
        [self.sessionManager POST:_requestURLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(task, responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(task, error);
        }];
    }
    else if ([[method uppercaseString] isEqualToString:@"PUT"]) {
        [self.sessionManager PUT:_requestURLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(task, responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(task, error);
        }];
    }
    else if ([[method uppercaseString] isEqualToString:@"DELETE"]) {
        [self.sessionManager DELETE:_requestURLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(task, responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(task, error);
        }];
    }
   
    
    return dataTask;
}



@end
