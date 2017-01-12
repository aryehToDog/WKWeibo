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
@interface WKTabBarController ()

@end

@implementation WKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpOneVc];
}


/**
 创建子控制器
 */
- (void)setUpOneVc {

    WKHomeTableViewController *homeVc = [[WKHomeTableViewController alloc]init];
    [self addOneChildVc:homeVc title:@"首页" image:@"tabbar_home" selectImage:@"tabbar_home_selected"];
    
    WKMessageTableViewController *messageVc = [[WKMessageTableViewController alloc]init];
    [self addOneChildVc:messageVc title:@"消息" image:@"tabbar_message_center" selectImage:@"tabbar_message_center_selected"];
    
    WKDiscoveryTableViewController *disVc = [[WKDiscoveryTableViewController alloc]init];
    [self addOneChildVc:disVc title:@"发现" image:@"tabbar_discover" selectImage:@"tabbar_discover_selected"];
    
    WKMeTableViewController *meVc = [[WKMeTableViewController alloc]init];
    [self addOneChildVc:meVc title:@"我" image:@"tabbar_profile" selectImage:@"tabbar_profile_selected"];
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
