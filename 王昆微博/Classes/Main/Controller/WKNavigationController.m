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


+ (void)initialize {

    //设置外观对象
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    NSMutableDictionary *hightDict = [NSMutableDictionary dictionary];
    hightDict[NSForegroundColorAttributeName] = [UIColor redColor];
    hightDict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:hightDict forState:UIControlStateHighlighted];

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
