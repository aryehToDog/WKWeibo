//
//  WKHttpTool.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/17.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKHttpTool.h"
#import <AFNetworking.h>
@implementation WKHttpTool

+ (void)getWithUrl: (NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure: (void(^)(NSError *error))failure {

    AFHTTPSessionManager *msg = [AFHTTPSessionManager manager];
    msg.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",nil];

    [msg GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
}


+ (void)postWithUrl: (NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure: (void(^)(NSError *error))failure {
    
    AFHTTPSessionManager *msg = [AFHTTPSessionManager manager];
    msg.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",nil];
    
    [msg POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)postDownloadWithUrl: (NSString *)url parameters:(NSDictionary *)parameters data:(void(^)(id<AFMultipartFormData> formData))data success:(void(^)(id responseObject))success failure: (void(^)(NSError *error))failure{

    AFHTTPSessionManager *msg = [AFHTTPSessionManager manager];
    msg.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",nil];
    
    [msg POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (data) {
            data(formData);
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
