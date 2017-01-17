//
//  WKAccount.h
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/15.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKAccount : NSObject<NSCoding>


/**
 用户授权的唯一票据，用于调用微博的开放接口
 */
@property (nonatomic,copy)NSString *access_token;

/**
 access_token的生命周期，单位是秒数。
 */

@property (nonatomic,copy)NSString *expires_in;

/**
 授权用户的UID
 */
@property (nonatomic,copy)NSString *uid;

/**
 用户的昵称
 */
@property (nonatomic,copy)NSString *name;

@end
