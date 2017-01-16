//
//  WKAccountTool.h
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/15.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WKAccount;

@interface WKAccountTool : NSObject



/**
 获取用户信息
 */
+ (WKAccount *)getAccount;

/**
 保存用户信息
 */
+ (void)saveAccount: (WKAccount*)account;

@end
