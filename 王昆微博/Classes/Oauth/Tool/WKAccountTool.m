//
//  WKAccountTool.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/15.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKAccountTool.h"

@implementation WKAccountTool


/**
 获取用户信息
 */
+ (WKAccount *)getAccount {

    //将模型信息存贮到沙盒中
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
    
    NSString *accountFile = [filePath stringByAppendingPathComponent:@"account.data"];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:accountFile];

}


/**
 存贮用户信息
 */
+ (void)saveAccount: (WKAccount*)account {

    //将模型信息存贮到沙盒中
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
    
    NSString *accountFile = [filePath stringByAppendingPathComponent:@"account.data"];
    
    [NSKeyedArchiver archiveRootObject:account toFile:accountFile];

}

+ (void)accountGetNameWithUrl: (NSString *)url parameters:(WKAccountRequest *)parameters success:(void(^)(WKAccountResult *responseObject))success failure:(void(^)(NSError *error))failure{

    [WKBaseTool getWithUrl:url parameters:parameters resuletClass:[WKAccountResult class] success:success failure:failure];
    
}

+ (void)accountPostAccesTokenWithUrl: (NSString *)url parameters:(WKAssessTokenRequest *)parameters success:(void(^)(WKAccount *responseObject))success failure:(void(^)(NSError *error))failure {

    [WKBaseTool PostWithUrl:url parameters:parameters resuletClass:[WKAccount class] success:success failure:failure];

}
     
@end
