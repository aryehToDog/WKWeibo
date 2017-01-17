//
//  WKStatuesTool.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/17.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKStatuesTool.h"

@implementation WKStatuesTool

+ (void)statuesWithUrl: (NSString *)url parameters:(WKStatuesRequest *)parameters success:(void(^)(WKStatuesResult *responseObject))success failure:(void(^)(NSError *error))failure {
    
    [WKBaseTool getWithUrl:url parameters:parameters resuletClass:[WKStatuesResult class] success:success failure:failure];
}

+ (void)sendMessageStatuesWithUrl: (NSString *)url parameters:(WKSendMessageRequest *)parameters success:(void(^)(WKSendMessageResult *responseObject))success failure:(void(^)(NSError *error))failure {

    [WKBaseTool PostWithUrl:url parameters:parameters resuletClass:[WKSendMessageResult class] success:success failure:failure];

}

+ (void)sendMessageWithPictureStatuesWithUrl: (NSString *)url parameters:(WKSendMessageRequest *)parameters data:(void(^)(id<AFMultipartFormData> formData))data success:(void(^)(WKSendMessageResult *responseObject))success failure:(void(^)(NSError *error))failure {

    [WKBaseTool PostDownLoadWithUrl:url parameters:parameters data:data resuletClass:[WKSendMessageResult class] success:success failure:failure];

}

@end
