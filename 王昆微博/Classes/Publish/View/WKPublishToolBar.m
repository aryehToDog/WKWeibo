//
//  WKPublishToolBar.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/16.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKPublishToolBar.h"

@implementation WKPublishToolBar

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage resizableImage:@"compose_toolbar_background"]];
        
        //添加按钮
        [self addChildBtn:@"compose_camerabutton_background" hightlightImage:@"compose_camerabutton_background_highlighted" type:WKPublishToolBarButtonTpyeCamera];
        [self addChildBtn:@"compose_toolbar_picture" hightlightImage:@"compose_toolbar_picture_highlighted" type:WKPublishToolBarButtonTpyePicture];
        [self addChildBtn:@"compose_mentionbutton_background" hightlightImage:@"compose_mentionbutton_background_highlighted" type:WKPublishToolBarButtonTpyeMention];
        [self addChildBtn:@"compose_trendbutton_background" hightlightImage:@"compose_trendbutton_background_highlighted" type:WKPublishToolBarButtonTpyeTrend];
        [self addChildBtn:@"compose_emoticonbutton_background" hightlightImage:@"compose_emoticonbutton_background_highlighted" type:WKPublishToolBarButtonTpyeEmotion];
        
    }

    return self;
}

- (void)layoutSubviews {

    [super layoutSubviews];

    NSInteger count = self.subviews.count;
    
    for (int i = 0; i < count; i ++) {
        UIButton *btn = self.subviews[i];
        
        CGFloat btnW = self.width / count;
        CGFloat btnH = self.height;
        CGFloat btnY = 0;
        CGFloat btnX = btnW * i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
}

- (void)addChildBtn: (NSString *)image hightlightImage: (NSString *)hightlightImage type:(WKPublishToolBarButtonTpye) type{

    UIButton *button = [[UIButton alloc]init];
    button.tag = type;
    [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:hightlightImage] forState:UIControlStateHighlighted];
    [self addSubview:button];

}

- (void)clickBtn:(UIButton *)btn{

    //点击按钮进行处理事件
    if ([self.delegate respondsToSelector:@selector(publishToolBar:choseButtontype:)]) {
        [self.delegate publishToolBar:self choseButtontype:(WKPublishToolBarButtonTpye)btn.tag];
    }

}

@end
