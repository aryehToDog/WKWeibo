//
//  WKTextView.h
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/16.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKTextView : UITextView


/**
 设置占位文字
 */
@property (nonatomic,copy)NSString *placeHolder;
/**
 设置占位文字颜色
 */
@property (nonatomic,strong)UIColor *placeHolderColor;
@end
