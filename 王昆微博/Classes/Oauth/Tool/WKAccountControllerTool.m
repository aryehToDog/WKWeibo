//
//  WKAccountControllerTool.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/15.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKAccountControllerTool.h"
#import "WKTabBarController.h"
#import "WKNewFeatureViewController.h"

#define  WKVersionKey @"CFBundleShortVersionString"
@implementation WKAccountControllerTool

+ (void)getVersionController {

    //获取到老的版本
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:WKVersionKey];
    
    //获取到新的版本
    NSString *newVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:WKVersionKey];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([lastVersion isEqualToString:newVersion]) {
        
        WKTabBarController *tabBarVc = [[WKTabBarController alloc]init];
        window.rootViewController = tabBarVc;
    }else {
        
        //不相等就进入新特性界面
        WKNewFeatureViewController *newFeatureVc = [[WKNewFeatureViewController alloc]init];
        window.rootViewController = newFeatureVc;
        
        //保存本次的版本号
        [[NSUserDefaults standardUserDefaults]setObject:newVersion forKey:WKVersionKey];
    }
}

@end
