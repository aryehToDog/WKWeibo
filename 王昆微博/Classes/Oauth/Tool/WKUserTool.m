//
//  WKUserTool.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/18.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKUserTool.h"

@implementation WKUserTool

+ (void)userGetUnreadWithUrl: (NSString *)url parameters:(WKUesrUnreadRequest *)parameters success:(void(^)(WKUserUnreadResult *responseObject))success failure:(void(^)(NSError *error))failure {

    [WKBaseTool getWithUrl:url parameters:parameters resuletClass:[WKUserUnreadResult class] success:success failure:failure];
    
}




@end
