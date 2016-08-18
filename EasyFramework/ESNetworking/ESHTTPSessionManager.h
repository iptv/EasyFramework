//
//  ESHTTPSessionManager.h
//  EasyFramework
//
//  Created by 习聚 on 16/8/18.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (int, ESRequestDataType){
    ESFormDataType = 0,  //表单方式提交
    ESJsonType         //JSON字符串方式提交
};

@interface ESHTTPSessionManager : NSObject

+ (instancetype)manager;

- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval;

- (NSURLSessionDataTask *)sendRequest:(NSString *)requestURLString
         httpMethod:(NSString *)method
         parameters:(id)parameters
    requestDataType:(ESRequestDataType)type
           progress:(void (^)(NSProgress *uploadProgress))uploadProgress
            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
