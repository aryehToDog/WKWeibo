//
//  WKOauthViewController.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/15.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKOauthViewController.h"
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "WKAccount.h"
#import "WKAccountTool.h"
#import "WKAccountControllerTool.h"
#import "WKAssessTokenRequest.h"

@interface WKOauthViewController ()<UIWebViewDelegate>

@end

@implementation WKOauthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取Oauth三部曲
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    webView.delegate = self;
    
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=124151187&redirect_uri=http://www.jianshu.com/u/a54931de4c9b"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    //拦截发送的请求获取code码
    NSString *urlStr= [request.URL absoluteString];
    NSString *urlCode = @"http://www.jianshu.com/u/a54931de4c9b?code=";
    NSRange range = [urlStr rangeOfString:urlCode];
    if (range.location != NSNotFound ) {
        
        NSInteger length = range.length;
        NSInteger location = range.location;
        
        NSString *code = [urlStr substringFromIndex:(length + location)];
        
        //发送请求获取accesstoken
        [self loadAccesstoken:code];
        
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {

    [SVProgressHUD showWithStatus:@"正在加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {

    [SVProgressHUD showWithStatus:@"加载失败..."];
}


- (void)loadAccesstoken: (NSString *)code {
    
    NSString *url = @"https://api.weibo.com/oauth2/access_token";
    
    WKAssessTokenRequest *parame = [[WKAssessTokenRequest alloc]init];
    parame.client_id = @"124151187";
    parame.client_secret = @"ad66039d666c948ee603b1e72fcda242";
    parame.grant_type = @"authorization_code";
    parame.code = code;
    parame.redirect_uri = @"http://www.jianshu.com/u/a54931de4c9b";
    
    [WKAccountTool accountPostAccesTokenWithUrl:url parameters:parame success:^(WKAccount *responseObject) {
        //取消加载提示
        [SVProgressHUD dismiss];
        
        //字典转模型
        WKAccount *account = responseObject;
        [WKAccountTool saveAccount:account];
        
        [WKAccountControllerTool getVersionController];
    } failure:^(NSError *error) {
        //请求失败
        NSLog(@"%@",error);
    }];
    
}

@end
