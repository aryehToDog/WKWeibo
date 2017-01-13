//
//  WKTabBar.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/13.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKTabBar.h"
#import "WKNavigationController.h"
#import "WKPublishViewController.h"
@interface WKTabBar ()

@property (nonatomic,strong)UIButton *publishBtn;

@end

@implementation WKTabBar

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        //创建一个按钮
        UIButton *publishBtn = [[UIButton alloc]init];
        [publishBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [publishBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateSelected];
        
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateSelected];
        [publishBtn addTarget:self action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishBtn];
        self.publishBtn = publishBtn;
    }
    
    return self;
}


- (void)clickPublish {

    NSLog(@"%s",__func__);
    
    //点击按钮让tabbarController成为代码弹出控制器
//    if ([self.tabBarDelegate respondsToSelector:@selector(tabBarDidClickPublish:)]) {
//        
//        [self.tabBarDelegate tabBarDidClickPublish:self];
//    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    WKPublishViewController *publishVc = [[WKPublishViewController alloc]init];
    WKNavigationController *nav = [[WKNavigationController alloc]initWithRootViewController:publishVc];
    [window.rootViewController presentViewController:nav animated:YES completion:nil];
    
}

- (void)layoutSubviews {

    [super layoutSubviews];

    //设置加号按钮frame
    self.publishBtn.size = self.publishBtn.currentBackgroundImage.size;
    self.publishBtn.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    NSInteger index = 0;
    
    for (UIView *tabBarItem in self.subviews) {
        
        //如果子控件不是UITabBarButton  让循环继续下去
        if (![tabBarItem isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
            CGFloat tabBarY = 0;
            CGFloat tabBarW = self.width / 5;
            CGFloat tabBarH = self.height;
            CGFloat tabBarX;
            if (index >= 2) {
                tabBarX = (index + 1) * tabBarW;
            }else {
                tabBarX = index * tabBarW;
            }
            
            tabBarItem.frame = CGRectMake(tabBarX, tabBarY, tabBarW, tabBarH);
        
        index ++ ;
        
    }
    
}


@end
