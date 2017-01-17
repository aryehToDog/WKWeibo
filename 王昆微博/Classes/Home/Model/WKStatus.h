//
//  WKStatus.h
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/15.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WKUser;
@interface WKStatus : NSObject


/**
 微博创建时间
 */
@property (nonatomic,copy)NSString *created_at;

/**
 字符串型的微博ID
 */
@property (nonatomic,copy)NSString *idstr;

/**
	微博来源
 */
@property (nonatomic,copy)NSString *source;

/**
	微博信息内容
 */
@property (nonatomic,copy)NSString *text;

/**
 微博作者的用户信息字段
 */
@property (nonatomic,strong)WKUser *user;

/**
 被转发的原微博信息字段，当该微博为转发微博时返回
 */
@property (nonatomic,strong)WKStatus *retweeted_status;

@end
