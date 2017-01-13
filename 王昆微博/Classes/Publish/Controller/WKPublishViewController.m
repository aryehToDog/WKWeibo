//
//  WKPublishViewController.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/13.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKPublishViewController.h"

@interface WKPublishViewController ()

@end

@implementation WKPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    
    
}

- (void)setUpUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"发帖";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back" HightImage:@"navigationbar_back_highlighted" target:self action:@selector(friendsearch)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];

    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)friendsearch {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)send {
    
    NSLog(@"%s",__func__);

}

@end
