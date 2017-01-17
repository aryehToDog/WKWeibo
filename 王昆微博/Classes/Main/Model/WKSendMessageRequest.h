//
//  WKSendMessageRequest.h
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/17.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKSendMessageRequest : NSObject

/**
 采用OAuth授权方式为必填参数，OAuth授权后获得。
 */
@property (nonatomic,copy)NSString *access_token;

/**
 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 */
@property (nonatomic,copy)NSString *status;


/**
 要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
 */
@property (nonatomic,strong)UIImage *pic;
@end
