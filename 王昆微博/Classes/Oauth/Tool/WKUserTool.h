//
//  WKUserTool.h
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/18.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKUserUnreadResult.h"
#import "WKUesrUnreadRequest.h"
#import "WKBaseTool.h"
@interface WKUserTool : WKBaseTool

/**
 获取最新的微博数据
 
 @param url 请求地址
 @param parameters 请求参数模型
 @param success 成功之后的回调
 @param failure 失败之后的回调
 */
+ (void)userGetUnreadWithUrl: (NSString *)url parameters:(WKUesrUnreadRequest *)parameters success:(void(^)(WKUserUnreadResult *responseObject))success failure:(void(^)(NSError *error))failure;
@end
