//
//  WKUserUnreadResult.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/18.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKUserUnreadResult.h"

@implementation WKUserUnreadResult

- (NSInteger)getUnreadMessage {
    
    return self.mention_cmt + self.group + self.private_group + self.notice + self.invite + self.badge + self.photo;
}

- (NSInteger)getAllUnreadMessage {

    return [self getUnreadMessage] + self.status + self.follower;
}

- (NSInteger)getMeUnreadMessage {

    return self.follower;
}
@end
