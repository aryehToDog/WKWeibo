//
//  WKBaseTool.h
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/17.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface WKBaseTool : NSObject



/**
 GET封装网络请求

 @param url 请求地址
 @param parameters 请求参数
 @param resuletClass 请求之后的返回的模型类型
 @param success 请求成功之后的回调
 @param failure 请求失败之后的回调
 */
+ (void)getWithUrl:(NSString *)url parameters:(id)parameters resuletClass:(Class)resuletClass success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;


/**
POST封装网络请求
 
 @param url 请求地址
 @param parameters 请求参数
 @param resuletClass 请求之后的返回的模型类型
 @param success 请求成功之后的回调
 @param failure 请求失败之后的回调
 */
+ (void)PostWithUrl:(NSString *)url parameters:(id)parameters resuletClass:(Class)resuletClass success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;



/**
 上传文件网络请求

 @param url 请求地址
 @param parameters 请求参数
 @param data 上传的二进制文件
 @param resuletClass 请求之后的返回的模型类型
 @param success 请求成功之后的回调
 @param failure 请求失败之后的回调
 */
+ (void)PostDownLoadWithUrl:(NSString *)url parameters:(id)parameters data:(void(^)(id<AFMultipartFormData> formData))data resuletClass:(Class)resuletClass success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

@end
