//
//  UIBarButtonItem+Extension.h
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/12.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImage: (NSString *)image HightImage: (NSString *)hightImage target:(id)target action:(SEL)action;
@end
