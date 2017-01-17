//
//  WKHttpTool.h
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/17.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface WKHttpTool : NSObject



/**
 发送GET请求

 @param url 请求路径
 @param parameters 请求参数
 @param success 成功之后的回调
 @param failure 失败之后的回调
 */
+ (void)getWithUrl: (NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure: (void(^)(NSError *error))failure;


/**
 发送POST请求
 
 @param url 请求路径
 @param parameters 请求参数
 @param success 成功之后的回调
 @param failure 失败之后的回调
 */
+ (void)postWithUrl: (NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure: (void(^)(NSError *error))failure;



/**
  发送POST上传文件

 @param url 请求路径
 @param parameters 求参数
 @param data 上传的二进制文件
 @param success 成功之后的回调
 @param failure 失败之后的回调
 */
+ (void)postDownloadWithUrl: (NSString *)url parameters:(NSDictionary *)parameters data:(void(^)(id<AFMultipartFormData> formData))data success:(void(^)(id responseObject))success failure: (void(^)(NSError *error))failure;


@end
