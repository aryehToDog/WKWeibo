//
//  WKPublishViewController.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/13.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKPublishViewController.h"
#import "WKTextView.h"
#import "WKPublishToolBar.h"
#import "WKPictureView.h"
#import "WKAccount.h"
#import "WKAccountTool.h"
#import <SVProgressHUD.h>
#import "WKSendMessageRequest.h"
#import "WKStatuesTool.h"
@interface WKPublishViewController ()<WKPublishToolBarDelegate,UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,strong)WKTextView *textView;
@property (nonatomic,strong)WKPublishToolBar *publishToolBar;
@property (nonatomic,strong)WKPictureView *pictureView;
@end

@implementation WKPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    //添加一个textView
    [self setupTextView];
    
    //添加键盘上的tabbar
    [self setupKeyBoardBar];
    
    //添加一个选择图片的view
    [self setupPictureView];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)setupPictureView {

    WKPictureView *pictureView = [[WKPictureView alloc]init];
    pictureView.frame = CGRectMake(0, 200, self.view.width, self.view.height);
    [self.textView addSubview:pictureView];
    self.pictureView = pictureView;
}

- (void)setupKeyBoardBar {

    WKPublishToolBar *publishToolBar = [[WKPublishToolBar alloc]init];

    publishToolBar.width = self.view.width;
    publishToolBar.height = 44;
    publishToolBar.delegate = self;
    publishToolBar.y = self.view.height - publishToolBar.height;
    [self.view addSubview:publishToolBar];
    self.publishToolBar = publishToolBar;
    
    //接受键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)keyBoardWillShow: (NSNotification *)notification {

    
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        
        CGFloat keyboardH = frame.size.height;
        self.publishToolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardH);
        
    }];
}

- (void)keyBoardWillHide: (NSNotification *)notification {
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        
        self.publishToolBar.transform = CGAffineTransformIdentity;
        
    }];
}

#pragma mark -<WKPublishToolBarDelegate>
- (void)publishToolBar:(WKPublishToolBar *)pushishToolBar choseButtontype:(WKPublishToolBarButtonTpye)type {

    switch (type) {
        case WKPublishToolBarButtonTpyeCamera:
            NSLog(@"点击了相机");
            
            [self showPubliashCamera];
            
            break;
        case WKPublishToolBarButtonTpyePicture:
            NSLog(@"点击了相册");
            
             [self showPubliashPicuure];
            break;
        case WKPublishToolBarButtonTpyeMention:
            NSLog(@"点击了@");
            break;
        case WKPublishToolBarButtonTpyeTrend:
            NSLog(@"点击了话题");
            break;
        case WKPublishToolBarButtonTpyeEmotion:
            NSLog(@"点击了表情");
            break;
    }

}


/**
 打开相机
 */
- (void)showPubliashCamera {

    UIImagePickerController *pickerVc = [[UIImagePickerController alloc]init];
    //判断打开的类型是否匹配
    if (! [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera ])   return;
    pickerVc.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:pickerVc animated:YES completion:nil];

}



/**
 打开相册
 */
- (void)showPubliashPicuure {
  
    UIImagePickerController *pickerVc = [[UIImagePickerController alloc]init];
    
    //判断打开的类型是否匹配
    if (! [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum ])   return;
    
    pickerVc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pickerVc.delegate = self;
    [self presentViewController:pickerVc animated:YES completion:nil];
}

#pragma mark -<UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.pictureView addImageView:image];
}


/**
 添加一个textView
 */
- (void)setupTextView {

    WKTextView *textView = [[WKTextView alloc]init];
    textView.frame = self.view.bounds;
    textView.alwaysBounceVertical = YES;
    textView.placeHolder = @"分享新鲜事...";
    [self.view addSubview:textView];
    self.textView = textView;
    textView.delegate = self;
}

- (void)setUpUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"发帖";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(friendsearch)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];

    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)friendsearch {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)send {
    
    NSLog(@"%s",__func__);
    
    //发送微博消息
    NSInteger count = self.pictureView.getImage.count;
    
    if (count) {
        //发送带图片的微博消息
        [self sendPictureMessage];
    }else {
        //发送不带图片的微博消息
        [self sendeMessage];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


/**
 单张图片上传
 */
- (void)sendPictureMessage {
    
    
    NSString *url = @"https://upload.api.weibo.com/2/statuses/upload.json";
//    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
//    parame[@"access_token"] = [WKAccountTool getAccount].access_token;
//    parame[@"status"] = self.textView.text;

    WKSendMessageRequest *parame = [[WKSendMessageRequest alloc]init];
    parame.access_token = [WKAccountTool getAccount].access_token;
    parame.status = self.textView.text;
    
    [WKStatuesTool sendMessageWithPictureStatuesWithUrl:url parameters:parame data:^(id<AFMultipartFormData> formData) {
        UIImage *image = [self.pictureView.getImage firstObject];
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        
        [formData appendPartWithFileData:imageData name:@"pic" fileName:@"statue.jpg" mimeType:@"image/jpeg"];
    } success:^(WKSendMessageResult *responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"微博发送成功"];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"微博发送失败"];
    }];

}


/**
 发送消息的微博
 */
- (void)sendeMessage {
  
    NSString *url = @"https://api.weibo.com/2/statuses/update.json";
    
    WKSendMessageRequest *parame = [[WKSendMessageRequest alloc]init];
    parame.access_token = [WKAccountTool getAccount].access_token;
    parame.status = self.textView.text;
    
    [WKStatuesTool sendMessageStatuesWithUrl:url parameters:parame success:^(WKSendMessageResult *responseObject) {
                 [SVProgressHUD showSuccessWithStatus:@"微博发送成功"];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"微博发送失败"];
        NSLog(@"%@",error);
    }];
    
}
#pragma mark - <UITextViewDelegate>
/**
开始拖拽的时候结束编辑
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];

}


/**
 文字改变的时候机会调用

 @param textView 输入的文本框文字
 */
- (void)textViewDidChange:(UITextView *)textView {

    self.navigationItem.rightBarButtonItem.enabled = textView.text.length != 0;

}

@end
