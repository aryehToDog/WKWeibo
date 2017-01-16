//
//  WKPictureView.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/16.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKPictureView.h"

@interface WKPictureView ()
@property (nonatomic,strong)UIImageView *imageView;
@end

@implementation WKPictureView

- (void)layoutSubviews {

    [super layoutSubviews];
    
    NSInteger subviewsCount = self.subviews.count;
    
    NSInteger maxCount = 3;
    CGFloat margin = 10;
    
    CGFloat imageViewW = (self.width - (maxCount + 1) * margin) / maxCount;
    CGFloat imageViewH = imageViewW;
    
    for (int i = 0; i < subviewsCount ; i ++) {
        
        NSInteger row = i / maxCount;
        NSInteger col = i % maxCount;
        CGFloat imageViewX = margin + (imageViewW + margin) * col;
        CGFloat imageViewY = margin + (imageViewH + margin) * row;
        UIImageView *imageview = self.subviews[i];
        imageview.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    }

}


- (void)addImageView: (UIImage *)image {
 
    UIImageView *imageView = [[UIImageView alloc]init];
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageView];
    self.imageView = imageView;
    self.imageView.image = image;
}

@end
