//
//  WKTabBar.h
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/13.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKTabBar;

@protocol  WKTabBarDelegate<NSObject>

@optional
- (void)tabBarDidClickPublish: (WKTabBar *)tabBar;

@end

@interface WKTabBar : UITabBar

@property (nonatomic,weak)id<WKTabBarDelegate> tabBarDelegate;


@end
