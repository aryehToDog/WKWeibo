//
//  WKAccount.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/15.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKAccount.h"

@implementation WKAccount

- (instancetype)initWithCoder:(NSCoder *)aDecoder {

    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
}

@end
