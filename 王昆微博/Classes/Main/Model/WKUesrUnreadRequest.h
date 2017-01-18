//
//  WKUesrUnreadRequest.h
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/18.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKUesrUnreadRequest : NSObject


/**
 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 */
@property (nonatomic,copy)NSString *access_token;


/**
 需要获取消息未读数的用户UID，必须是当前登录用户。
 */
@property (nonatomic,copy)NSString *uid;
@end
