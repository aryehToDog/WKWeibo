//
//  WKStatuesRequest.h
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/17.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKStatuesRequest : NSObject


/**
 采用OAuth授权方式为必填参数，OAuth授权后获得。
 */
@property (nonatomic,copy)NSString *access_token;

/**
	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 */
@property (nonatomic,copy)NSNumber *since_id;

/**
若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 */
@property (nonatomic,strong)NSNumber *max_id;

@end
