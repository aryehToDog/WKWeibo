//
//  WKUser.h
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/15.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKUser : NSObject


/**
 用户头像地址（中图），50×50像素
 */
@property (nonatomic,copy)NSString *profile_image_url;

/**
 用户昵称
 */
@property (nonatomic,copy)NSString *screen_name;



@end
