//
//  AppDelegate.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/12.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "AppDelegate.h"
#import "WKTabBarController.h"
#import "WKNewFeatureViewController.h"

#define  WKVersionKey @"CFBundleShortVersionString"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //获取到老的版本
   NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:WKVersionKey];
    
    //获取到新的版本
    NSString *newVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:WKVersionKey];
    
    if ([lastVersion isEqualToString:newVersion]) {
        
        WKTabBarController *tabBarVc = [[WKTabBarController alloc]init];
        self.window.rootViewController = tabBarVc;
    }else {
    
        //不相等就进入新特性界面
        WKNewFeatureViewController *newFeatureVc = [[WKNewFeatureViewController alloc]init];
        self.window.rootViewController = newFeatureVc;
        
        //保存本次的版本号
        [[NSUserDefaults standardUserDefaults]setObject:newVersion forKey:WKVersionKey];
    }


    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
