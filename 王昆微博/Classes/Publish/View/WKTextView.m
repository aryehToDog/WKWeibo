//
//  WKTextView.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/16.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKTextView.h"

@interface WKTextView ()
@property (nonatomic,strong)UILabel *placeHolderLable;
@end

@implementation WKTextView


- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        UILabel *placeHolderLable = [[UILabel alloc]init];
        self.font = [UIFont systemFontOfSize:14];
        placeHolderLable.textColor = [UIColor lightGrayColor];
        [self addSubview:placeHolderLable];
        self.placeHolderLable = placeHolderLable;
        
        //文字改变发送通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didChangeNotification) name:UITextViewTextDidChangeNotification object:self];
    }

    return self;
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter]removeObserver:self];

}


/**
 文字改变发送通知
 */
- (void)didChangeNotification {
    
    self.placeHolderLable.hidden = !(self.text.length == 0);

}

- (void)layoutSubviews {

    [super layoutSubviews];
    CGFloat placeHolderLableY = 8;
    CGFloat placeHolderLableX = 5;
    CGFloat placeHolderLableW = self.width;
    
    CGSize size = CGSizeMake(self.width, MAXFLOAT);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    CGSize placeHolderLableSize = [self.placeHolderLable.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    self.placeHolderLable.frame = CGRectMake(placeHolderLableX, placeHolderLableY, placeHolderLableW, placeHolderLableSize.height);
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    
    _placeHolder = placeHolder;
    
    self.placeHolderLable.text = placeHolder;
    self.placeHolderLable.font = self.font;
}


- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {

    _placeHolderColor = placeHolderColor;
    self.placeHolderLable.font = self.font;
}
@end
