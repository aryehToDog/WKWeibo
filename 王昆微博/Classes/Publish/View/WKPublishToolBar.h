//
//  WKPublishToolBar.h
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/16.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKPublishToolBar;
typedef enum {
    
    WKPublishToolBarButtonTpyeCamera,  //相机
    WKPublishToolBarButtonTpyePicture, //相册
    WKPublishToolBarButtonTpyeMention, //@
    WKPublishToolBarButtonTpyeTrend,   //话题
    WKPublishToolBarButtonTpyeEmotion  //表情

}WKPublishToolBarButtonTpye;


@protocol WKPublishToolBarDelegate <NSObject>

@optional
- (void)publishToolBar: (WKPublishToolBar *)pushishToolBar choseButtontype: (WKPublishToolBarButtonTpye)type;
@end


@interface WKPublishToolBar : UIView


@property (nonatomic,weak)id<WKPublishToolBarDelegate> delegate;
@end
