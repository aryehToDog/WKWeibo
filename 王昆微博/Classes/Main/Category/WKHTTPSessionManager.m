//
//  WKHTTPSessionManager.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/15.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKHTTPSessionManager.h"

@implementation WKHTTPSessionManager

+ (instancetype)shareManager {

    WKHTTPSessionManager *manager = [[WKHTTPSessionManager alloc]init];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",nil];

    
    return manager;
}

@end
