//
//  WKNavigationController.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/12.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKNavigationController.h"

@interface WKNavigationController ()

@end

@implementation WKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 这个方法的作用是在加载这个类的时候只调用一次
 */
+ (void)initialize {

    //设置nabBar
    [self setUpNabBar];
    
    //设置barButtonItem
    [self setUpBarButtonItem];

}

+ (void)setUpNabBar {

    UINavigationBar *appearce = [UINavigationBar appearance];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    dict[NSBaselineOffsetAttributeName] = [NSValue valueWithCGPoint:CGPointZero];
    
    [appearce setTitleTextAttributes:dict];
}

+ (void)setUpBarButtonItem {

    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    NSMutableDictionary *hightDict = [NSMutableDictionary dictionary];
    hightDict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    hightDict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:hightDict forState:UIControlStateHighlighted];
    
    NSMutableDictionary *disDict = [NSMutableDictionary dictionary];
    disDict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disDict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:disDict forState:UIControlStateDisabled];

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.viewControllers.count > 0) {
        
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back" HightImage:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_more" HightImage:@"navigationbar_more_highlighted" target:self action:@selector(more)];
        
        viewController.hidesBottomBarWhenPushed = YES;
        
}
    [super pushViewController:viewController animated:animated];
}

- (void)back {

    [self popViewControllerAnimated:YES];
}

- (void)more {

    [self popToRootViewControllerAnimated:YES];
}
@end
