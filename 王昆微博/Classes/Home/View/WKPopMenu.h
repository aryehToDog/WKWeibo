//
//  WKPopMenu.h
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/12.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKPopMenu;

@protocol WKPopMenuDelegate <NSObject>

@optional
- (void)popMenuDidChangeImageRocation: (WKPopMenu *)popMenu;

@end

@interface WKPopMenu : UIView

@property (nonatomic,weak)id<WKPopMenuDelegate> delegate;

- (instancetype)initWith: (UIView *)contentView;

+ (instancetype)popMenuWith: (UIView *)contentView;

- (void)showInrect: (CGRect)rect;

- (void)dismiss;
@end
