//
//  WKPopMenu.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/12.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKPopMenu.h"

@interface WKPopMenu ()

@property (nonatomic,strong)UIButton *clearBtn;
@property (nonatomic,strong)UIImageView *content;
@property (nonatomic,strong)UIView *contentView;
@end

@implementation WKPopMenu

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        UIButton *clearBtn = [[UIButton alloc]init];
//        [clearBtn setBackgroundColor:[UIColor redColor]];
        [clearBtn addTarget:self action:@selector(clickClearBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clearBtn];
        self.clearBtn = clearBtn;
        
        UIImageView *content = [[UIImageView alloc]init];
//        content.backgroundColor = [UIColor yellowColor];
        content.image = [UIImage resizableImage:@"popover_background"];
        content.userInteractionEnabled = YES;
        [self addSubview:content];
        self.content = content;
    }
    return self;
}

- (void)clickClearBtn {
    
    [self dismiss];

}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    
    self.clearBtn.frame = self.bounds;
    
    
}

- (instancetype)initWith: (UIView *)contentView {

    if (self = [super init]) {
        
        self.contentView = contentView;
        
    }
    return self;
}

+ (instancetype)popMenuWith: (UIView *)contentView{
    
   return [[WKPopMenu alloc]initWith:contentView];
    
}

- (void)showInrect: (CGRect)rect{

    UIWindow *window = (UIWindow *)[UIApplication sharedApplication].keyWindow;

    [window addSubview:self];
    self.content.frame = rect;
    
    [self.content addSubview:self.contentView];
    
    CGFloat topMargin = 10;
    CGFloat leftMargin = 5;
    CGFloat rightMargin = 5;
    CGFloat bottonMargin = 5;
    
    self.contentView.x = leftMargin;
    self.contentView.y = topMargin;
    self.contentView.width = self.content.width - leftMargin - rightMargin;
    self.contentView.height = self.content.height - topMargin - bottonMargin;
    
}

- (void)dismiss {

    if ([self.delegate respondsToSelector:@selector(popMenuDidChangeImageRocation:)]) {
        
        [self.delegate popMenuDidChangeImageRocation:self];
        
    }
    
    [self removeFromSuperview];
    
}

@end
