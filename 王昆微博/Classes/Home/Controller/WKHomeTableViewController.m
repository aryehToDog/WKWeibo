//
//  WKHomeTableViewController.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/12.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKHomeTableViewController.h"
#import "WKTitleBtn.h"
#import "WKPopMenu.h"
#import "WKAccountTool.h"
#import "WKAccount.h"
#import "WKStatus.h"
#import "WKUser.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
@interface WKHomeTableViewController ()<WKPopMenuDelegate>

@property (nonatomic,assign)BOOL isSelectImage;
@property (nonatomic,strong)WKTitleBtn *titleBtn;

@property (nonatomic,strong)NSMutableArray *statusesArray;
@end

@implementation WKHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self loadMoreNews];
}

- (void)loadMoreNews {

    WKHTTPSessionManager *manager = [WKHTTPSessionManager shareManager];

    NSString *urlStr = @"https://api.weibo.com/2/statuses/home_timeline.json";
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    
    WKAccount *account = [WKAccountTool getAccount];
    
    parame[@"access_token"] = account.access_token;
    
    [manager GET:urlStr parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        //字典数组转成模型数组
        self.statusesArray = [WKStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    

}

- (void)setUpUI {

    //设置menuView
    WKTitleBtn *titleBtn = [[WKTitleBtn alloc]init];
    [titleBtn setTitle:@"阿拉斯加的狗" forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleBtn setBackgroundImage:[UIImage resizableImage:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    titleBtn.size = CGSizeMake(120, 30);
    self.navigationItem.titleView = titleBtn;
    [titleBtn addTarget:self action:@selector(clickTitle) forControlEvents:UIControlEventTouchUpInside];
    self.titleBtn = titleBtn;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" HightImage:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendsearch)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop" HightImage:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
}


- (void)clickTitle {
    
    UIImage *image = [UIImage imageNamed:@"navigationbar_arrow_down"];
    
    if (self.titleBtn.currentImage) {
        
        [self.titleBtn setImage:image forState:UIControlStateNormal];
        
        //弹出菜单
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        
        WKPopMenu *popMenu = [WKPopMenu popMenuWith:btn];
        popMenu.delegate = self;
        CGFloat popMenuW = 100;
        CGFloat popMenuH = 200;
        CGFloat popMenuY = 55;
        CGFloat popMenuX = ([UIScreen mainScreen].bounds.size.width - popMenuW) * 0.5;
        
        [popMenu showInrect:CGRectMake(popMenuX, popMenuY, popMenuW, popMenuH)];
    }
    
}

- (void)popMenuDidChangeImageRocation:(WKPopMenu *)popMenu {

     [self.titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];

}

- (void)friendsearch {

    NSLog(@"%s",__func__);
}

- (void)pop {
    
    NSLog(@"%s",__func__);
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statusesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *statuesId = @"statuesId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:statuesId];

    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:statuesId];
    }
    
    WKStatus *statues = self.statusesArray[indexPath.row];
    WKUser *uesr = statues.user;
    NSURL *url = [NSURL URLWithString:uesr.profile_image_url];
    [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    cell.textLabel.text = statues.text;
    
    
    return cell;
}
@end
