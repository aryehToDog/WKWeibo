//
//  WKStatuesTool.h
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/17.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKStatuesResult.h"
#import "WKStatuesRequest.h"
#import "WKSendMessageRequest.h"
#import "WKSendMessageResult.h"
#import <AFNetworking.h>
#import "WKBaseTool.h"
@interface WKStatuesTool : WKBaseTool


/**
 获取最新的微博数据

 @param url 请求地址
 @param parameters 请求参数模型
 @param success 成功之后的回调
 @param failure 失败之后的回调
 */
+ (void)statuesWithUrl: (NSString *)url parameters:(WKStatuesRequest *)parameters success:(void(^)(WKStatuesResult *responseObject))success failure:(void(^)(NSError *error))failure;

/**
 发微博(不带消息的微博)
 
 @param url 请求地址
 @param parameters 请求参数模型
 @param success 成功之后的回调
 @param failure 失败之后的回调
 */
+ (void)sendMessageStatuesWithUrl: (NSString *)url parameters:(WKSendMessageRequest *)parameters success:(void(^)(WKSendMessageResult *responseObject))success failure:(void(^)(NSError *error))failure;

/**
 发微博(带图片的微博消息)
 
 @param url 请求地址
 @param parameters 请求参数模型
 @param success 成功之后的回调
 @param failure 失败之后的回调
 */
+ (void)sendMessageWithPictureStatuesWithUrl: (NSString *)url parameters:(WKSendMessageRequest *)parameters data:(void(^)(id<AFMultipartFormData> formData))data success:(void(^)(WKSendMessageResult *responseObject))success failure:(void(^)(NSError *error))failure;

@end
