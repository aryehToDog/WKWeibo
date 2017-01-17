//
//  WKBaseTool.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/17.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKBaseTool.h"
#import "WKHttpTool.h"
#import <MJExtension.h>

@implementation WKBaseTool

+ (void)getWithUrl:(NSString *)url parameters:(id)parameters resuletClass:(Class)resuletClass success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure {

    
    NSDictionary *parmae = [parameters mj_keyValues];
    
    [WKHttpTool getWithUrl:url parameters:parmae success:^(id responseObject) {
        
        if (success) {
            id  result = [[resuletClass class] mj_objectWithKeyValues:responseObject];
            success(result);
        }  
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}


+ (void)PostWithUrl:(NSString *)url parameters:(id)parameters resuletClass:(Class)resuletClass success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure {
    NSDictionary *parmae = [parameters mj_keyValues];
    
    [WKHttpTool postWithUrl:url parameters:parmae success:^(id responseObject) {
        
        if (success) {
            id  result = [[resuletClass class] mj_objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];

}

+ (void)PostDownLoadWithUrl:(NSString *)url parameters:(id)parameters data:(void(^)(id<AFMultipartFormData> formData))data resuletClass:(Class)resuletClass success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure {
    
    NSDictionary *parmae = [parameters mj_keyValues];
    
    [WKHttpTool postDownloadWithUrl:url parameters:parmae
                               data:^(id<AFMultipartFormData> formData) {
                                   if (data) {
                                       data(formData);
                                   }
                                   
                               } success:^(id responseObject) {
                                   if (success) {
                                       id  result = [[resuletClass class] mj_objectWithKeyValues:responseObject];
                                       success(result);
                                   }
                                   
                               } failure:^(NSError *error) {
                                   
                                   if (failure) {
                                       failure(error);
                                   }
                               }];

}

@end
