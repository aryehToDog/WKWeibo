//
//  WKAccountRequest.h
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/17.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKAccountRequest : NSObject


/**
 采用OAuth授权方式为必填参数，OAuth授权后获得。
 */
@property (nonatomic,copy)NSString *access_token;

/**
需要查询的用户ID。
 */
@property (nonatomic,copy)NSString *uid;


@end
