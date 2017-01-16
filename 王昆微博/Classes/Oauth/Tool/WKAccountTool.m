//
//  WKAccountTool.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/15.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKAccountTool.h"

@implementation WKAccountTool


+ (WKAccount *)getAccount {

    //将模型信息存贮到沙盒中
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
    
    NSString *accountFile = [filePath stringByAppendingPathComponent:@"account.data"];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:accountFile];

}


+ (void)saveAccount: (WKAccount*)account {

    //将模型信息存贮到沙盒中
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
    
    NSString *accountFile = [filePath stringByAppendingPathComponent:@"account.data"];
    
    [NSKeyedArchiver archiveRootObject:account toFile:accountFile];

}

@end
