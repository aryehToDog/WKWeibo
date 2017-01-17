//
//  WKStatuesResult.h
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/17.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKStatuesResult : NSObject


/**
 微博字典数组
 */
@property (nonatomic,strong)NSArray *statuses;

/**
 total_number 返回的微博总条数
 */
@property (nonatomic,copy)NSString *total_number;

@end
