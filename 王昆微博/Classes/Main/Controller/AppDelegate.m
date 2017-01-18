//
//  AppDelegate.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/12.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "AppDelegate.h"
#import "WKAccountTool.h"
#import "WKOauthViewController.h"
#import "WKAccountControllerTool.h"
#import "WKAccount.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.window makeKeyAndVisible];

    
    WKAccount *account = [WKAccountTool getAccount];
    
    if (account) {
        
        [WKAccountControllerTool getVersionController];
    }else {
        WKOauthViewController *oauthVc = [[WKOauthViewController alloc]init];
        self.window.rootViewController = oauthVc;
    }

    
    //监控网络状态
    [self reachabilityState];
    
    return YES;
}


/**
 监控网络状态
 AFNetworkReachabilityStatusUnknown          = -1,
 AFNetworkReachabilityStatusNotReachable     = 0,
 AFNetworkReachabilityStatusReachableViaWWAN = 1,
 AFNetworkReachabilityStatusReachableViaWiFi = 2,
 
 */
- (void)reachabilityState {

    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
       
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                
                [SVProgressHUD showWithStatus:@"请检查您的网络设置..."];
                
                NSLog(@"没有网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"自带网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                break;
                
            default:
                break;
        }
    }];

    //开始检测
    [mgr startMonitoring];
}

- (void)dealloc {

    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {

    //清除磁盘缓存
    [[SDImageCache sharedImageCache] clearMemory];
    //取消所有的操作
    [[SDWebImageManager sharedManager] cancelAll];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //程序进入到后台申请后台支持
   UIBackgroundTaskIdentifier taskID = [application beginBackgroundTaskWithExpirationHandler:^{
       [application endBackgroundTask:taskID];
    }];
    
    
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
