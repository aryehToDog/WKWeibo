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
        self.titleLabel.font = [UIFont systemFontOfSize:14];
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
    CGFloat imageW = self.height;
    CGFloat imageH = imageW;
    CGFloat imageX = self.width - imageW;
    return  CGRectMake(imageX, imageY, imageW, imageH);
    
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect {

    CGFloat titleY = 0;
    CGFloat titleX = 0;
    CGFloat titleH = self.height;
    CGFloat titleW = self.width - self.height;
    return  CGRectMake(titleX, titleY, titleW, titleH);

}


- (void)setTitle:(NSString *)title forState:(UIControlState)state {

    [super setTitle:title forState:state];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = self.titleLabel.font;
    
    CGSize size = [title sizeWithAttributes:dict];
    
    self.width = size.width + self.height + 10;
    
}

@end
