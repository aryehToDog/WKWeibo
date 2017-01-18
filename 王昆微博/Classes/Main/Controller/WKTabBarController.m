//
//  WKTabBarController.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/12.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKTabBarController.h"
#import "WKHomeTableViewController.h"
#import "WKMessageTableViewController.h"
#import "WKDiscoveryTableViewController.h"
#import "WKMeTableViewController.h"
#import "WKNavigationController.h"
#import "WKTabBar.h"
#import "WKPublishViewController.h"
#import "WKUserTool.h"
#import "WKUesrUnreadRequest.h"
#import "WKAccountTool.h"
#import "WKUserUnreadResult.h"
#import "WKHomeTableViewController.h"
@interface WKTabBarController ()<WKTabBarDelegate,UITabBarControllerDelegate>

@property (nonatomic,weak)WKHomeTableViewController *homeVc;
@property (nonatomic,weak)WKMessageTableViewController *messageVc;
@property (nonatomic,weak)WKMeTableViewController *meVc;


/**
 最后选择的那个控制器
 */
@property (nonatomic,strong)UIViewController *lastSelectControllerView;
@end

@implementation WKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpOneVc];
    
    WKTabBar *wkTabBar = [[WKTabBar alloc]init];
    wkTabBar.tabBarDelegate = self;
    [self setValue:wkTabBar forKeyPath:@"tabBar"];
    
    //发送网络请求获取新的提示数据
    //开启定时器不断检测
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(getUnreadMidMessage) userInfo:nil repeats:YES];
    
    //更改定时器的模式
    [[NSRunLoop mainRunLoop]addTimer:time forMode:NSRunLoopCommonModes];
    
    //设置控制器的代理
    self.delegate = self;
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController {
    
    UIViewController *homeViewControllView = viewController.viewControllers.firstObject;
    
    if ([homeViewControllView isKindOfClass:[WKHomeTableViewController class]]) {
        
        if (self.lastSelectControllerView == homeViewControllView) {
            [self.homeVc refresh:YES];
        }else {
            [self.homeVc refresh:NO];
        }
        
    }
    self.lastSelectControllerView = homeViewControllView;
}

- (void)getUnreadMidMessage {

    NSString *url = @"https://rm.api.weibo.com/2/remind/unread_count.json";
    WKUesrUnreadRequest *parmae = [[WKUesrUnreadRequest alloc]init];
    parmae.access_token = [WKAccountTool getAccount].access_token;
    parmae.uid = [WKAccountTool getAccount].uid;
    [WKUserTool userGetUnreadWithUrl:url parameters:parmae success:^(WKUserUnreadResult *responseObject) {
        
        WKUserUnreadResult *result = responseObject;
        
        if (result.status == 0) {
            self.homeVc.tabBarItem.badgeValue = nil;
        }else {
            self.homeVc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)result.status];
        }
        
        if (result.getUnreadMessage == 0) {
            self.messageVc.tabBarItem.badgeValue = nil;
        }else {
            self.messageVc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",[result getUnreadMessage]];
        }
        
        if (result.getMeUnreadMessage == 0) {
            self.meVc.tabBarItem.badgeValue = nil;
        }else {
            self.meVc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",[result getMeUnreadMessage]];
        }
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.getAllUnreadMessage;
        NSLog(@"%zd-----------------result.status",result.status);
        NSLog(@"%zd--------------getAllUnreadMessage",result.getAllUnreadMessage);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}


/**
 创建子控制器
 */
- (void)setUpOneVc {

    WKHomeTableViewController *homeVc = [[WKHomeTableViewController alloc]init];
    [self addOneChildVc:homeVc title:@"首页" image:@"tabbar_home" selectImage:@"tabbar_home_selected"];
    self.homeVc = homeVc;
    
    WKMessageTableViewController *messageVc = [[WKMessageTableViewController alloc]init];
    [self addOneChildVc:messageVc title:@"消息" image:@"tabbar_message_center" selectImage:@"tabbar_message_center_selected"];
    self.messageVc = messageVc;
    
    WKDiscoveryTableViewController *disVc = [[WKDiscoveryTableViewController alloc]init];
    [self addOneChildVc:disVc title:@"发现" image:@"tabbar_discover" selectImage:@"tabbar_discover_selected"];
    
    WKMeTableViewController *meVc = [[WKMeTableViewController alloc]init];
    [self addOneChildVc:meVc title:@"我" image:@"tabbar_profile" selectImage:@"tabbar_profile_selected"];
    self.meVc =meVc;
}


- (void)addOneChildVc: (UIViewController *)childVc title: (NSString *)title image: (NSString *)image selectImage: (NSString *)selectImage{

    childVc.tabBarItem.title = title;
    childVc.navigationItem.title = title;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    UIImage *selectedImage = [UIImage imageNamed:selectImage];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    WKNavigationController *navVc = [[WKNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:navVc];
}

@end
