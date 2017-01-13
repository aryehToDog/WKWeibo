//
//  WKNewFeatureViewController.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/13.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKNewFeatureViewController.h"
#import "WKTabBarController.h"
@interface WKNewFeatureViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIPageControl *pageControl;

@end

@implementation WKNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addScrollView];
    
    [self addPageController];
    
}

- (void)addPageController {

    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = 4;
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl = pageControl;
    
    //设置pageControl的位置
    pageControl.centerX = self.view.width * 0.5;
    pageControl.centerY = self.view.height * 0.9;
    
    [self.view addSubview:pageControl];

}

- (void)addScrollView {

    //创建一个UIScrollview
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    for (int i = 0; i < 4; i ++) {
        
        //创建图片
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.userInteractionEnabled = YES;
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        imageView.image = [UIImage imageNamed:imageName];
        
        CGFloat imageViewW = scrollView.width;
        CGFloat imageViewH = scrollView.height;
        CGFloat imageViewY = 0;
        CGFloat imageViewX = i * imageViewW;
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        [scrollView addSubview:imageView];
        
        //在最后一张图片上添加两个按钮
        if (i == 3) {
            
            [self setUpStartBtnWith:imageView];
            
            [self setUpShareBtnWith:imageView];
        }
        
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.width * 4, 0);
    
}

- (void)setUpShareBtnWith:(UIImageView *)imageView {

    UIButton *shareBtn = [[UIButton alloc]init];
    [shareBtn setTitle:@"点击进行分享" forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    shareBtn.size = CGSizeMake(130, 35);
    shareBtn.centerX = self.view.width * 0.5;
    shareBtn.centerY = self.view.height * 0.7;
    [shareBtn addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];

}

- (void)shareBtn: (UIButton *)shareBtn {

    shareBtn.selected = !shareBtn.selected;

}


- (void)setUpStartBtnWith: (UIImageView *)imageView {
    
    UIButton *startBtn = [[UIButton alloc]init];
    [startBtn setTitle:@"开始体验" forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn addTarget:self action:@selector(starting) forControlEvents:UIControlEventTouchUpInside];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = self.view.width * 0.5;
    startBtn.centerY = self.view.height * 0.8;
    
    [imageView addSubview:startBtn];
}


- (void)starting {

    NSLog(@"%s",__func__);

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    WKTabBarController *tabBarVc = [[WKTabBarController alloc]init];
    window.rootViewController = tabBarVc;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    double floatIndex = scrollView.contentOffset.x / self.view.width;

    int index = (int)(floatIndex + 0.5);
    
    self.pageControl.currentPage = index;
}



@end
