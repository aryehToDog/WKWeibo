//
//  WKTitleBtn.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/12.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKTitleBtn.h"

@implementation WKTitleBtn


- (instancetype)initWithFrame:(CGRect)frame {

    if (self == [super initWithFrame:frame]) {
     
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.adjustsImageWhenHighlighted = NO;
        
        self.imageView.contentMode = UIViewContentModeCenter;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        self.imageView.backgroundColor = [UIColor redColor];
//        self.titleLabel.backgroundColor = [UIColor grayColor];
        
    }
    return self;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect {

    CGFloat imageY = 0;
    CGFloat imageH = self.height;
    CGFloat imageW = imageH;
    CGFloat imageX = self.width - imageW;
    return  CGRectMake(imageX, imageY, imageW, imageH);
    
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect {

    CGFloat titleY = 0;
    CGFloat titleX = 0;
    CGFloat titleW = self.width - self.imageView.width;
    CGFloat titleH = self.height;
    return  CGRectMake(titleX, titleY, titleW, titleH);

}

@end
