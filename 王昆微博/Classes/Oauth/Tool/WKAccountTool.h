//
//  WKAccountTool.h
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/15.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKAccountResult.h"
#import "WKAccountRequest.h"
#import "WKAccount.h"
#import "WKAssessTokenRequest.h"
#import "WKBaseTool.h"
@class WKAccount;

@interface WKAccountTool : WKBaseTool



/**
 获取用户信息
 */
+ (WKAccount *)getAccount;

/**
 保存用户信息
 */
+ (void)saveAccount: (WKAccount*)account;

/**
 获取最新的微博数据
 
 @param url 请求地址
 @param parameters 请求参数模型
 @param success 成功之后的回调
 @param failure 失败之后的回调
 */
+ (void)accountGetNameWithUrl: (NSString *)url parameters:(WKAccountRequest *)parameters success:(void(^)(WKAccountResult *responseObject))success failure:(void(^)(NSError *error))failure;

/**
 获取最新的微博数据
 
 @param url 请求地址
 @param parameters 请求参数模型
 @param success 成功之后的回调
 @param failure 失败之后的回调
 */
+ (void)accountPostAccesTokenWithUrl: (NSString *)url parameters:(WKAssessTokenRequest *)parameters success:(void(^)(WKAccount *responseObject))success failure:(void(^)(NSError *error))failure;
@end
