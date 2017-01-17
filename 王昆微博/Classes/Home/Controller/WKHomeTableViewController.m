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
#import <MJRefresh.h>
#import "WKStatus.h"

@interface WKHomeTableViewController ()<WKPopMenuDelegate>

@property (nonatomic,assign)BOOL isSelectImage;
@property (nonatomic,strong)WKTitleBtn *titleBtn;
@property (nonatomic,strong)WKHTTPSessionManager *manager;
@property (nonatomic,strong)NSMutableArray *statusesArray;
/** 字典请求参数,防止用户请求超时 */
@property (nonatomic,strong)NSMutableDictionary *parmae;
@end

@implementation WKHomeTableViewController

- (NSMutableDictionary *)parmae {
    
    if (_parmae == nil) {
        _parmae = [NSMutableDictionary dictionary];
    }
    return _parmae;
}

- (WKHTTPSessionManager *)manager {

    if (_manager == nil) {
        _manager = [WKHTTPSessionManager shareManager];
    }

    return _manager;
}

- (NSMutableArray *)statusesArray {

    if (_statusesArray == nil) {
        _statusesArray = [NSMutableArray array];
    }

    return _statusesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    //添加刷新控件
    [self addRefreshView];
    
    //获取到用户账号信息
    [self getAccountMessage];
}


/**
 添加刷新控件
 */
- (void)addRefreshView {

    //添加下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewsMessage)];
    
    [self.tableView.mj_header beginRefreshing];
    
    //自动改变下拉的透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //添加上拉加载更多控件
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreMessage)];
    
}


/**
 上拉加载更多
 */
- (void)loadMoreMessage {

    //停止下拉刷新
    [self.tableView.mj_header endRefreshing];
    
    NSString *urlStr = @"https://api.weibo.com/2/statuses/home_timeline.json";
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    WKAccount *account = [WKAccountTool getAccount];
    WKStatus *lastStatu = [self.statusesArray lastObject];
    if (lastStatu) {
#warning 为啥这地方要-1;
        parame[@"max_id"] = @([lastStatu.idstr longLongValue] - 1);
    }
    
    parame[@"access_token"] = account.access_token;
    self.parmae = parame;
    [self.manager GET:urlStr parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        if (self.parmae != parame) return ;
        
        //字典数组转成模型数组
        NSMutableArray *moreDictArray = [WKStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
 
        [self.statusesArray addObjectsFromArray:moreDictArray];
        
        [self.tableView reloadData];
        
        if (moreDictArray.count == self.statusesArray.count) {
            
            //数据完全加载完成
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}



/**
 下拉刷新
 */
- (void)loadNewsMessage {

    //停止上拉加载更多
    [self.tableView.mj_footer endRefreshing];
    
    NSString *urlStr = @"https://api.weibo.com/2/statuses/home_timeline.json";
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    WKAccount *account = [WKAccountTool getAccount];
    WKStatus *firstStatus = [self.statusesArray firstObject];
    if (firstStatus) {
        parame[@"since_id"] = firstStatus.idstr;
    }
    
    parame[@"access_token"] = account.access_token;
    self.parmae = parame;
    [self.manager GET:urlStr parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
      
        if (self.parmae != parame) return ;
        //字典数组转成模型数组
        NSMutableArray *newDictArray = [WKStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        NSRange range = {0,newDictArray.count};
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        
        [self.statusesArray insertObjects:newDictArray atIndexes:indexSet];
        
        //提示刷新数据
        [self showRefreshMessageWith:newDictArray.count];
        
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}


/**
 提示数据的更新
 */
- (void)showRefreshMessageWith: (NSInteger)count {

    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    label.width = self.view.width;
    label.height = 35;
    label.x = 0;
    label.y = 64 - label.height;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage resizableImage:@"timeline_new_status_background"]];
    if (count) {
        label.text = [NSString stringWithFormat:@"更新了%zd条新的微博..",count];
    }else {
        label.text = @"没有新的微博刷新..";
    }
    
    //动画展示
    [UIView animateWithDuration:1.0 animations:^{
       
        //lable下滑
        label.transform = CGAffineTransformMakeTranslation(0, 64 - label.y);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
           
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

- (void)dealloc {

    //控制器销毁移除请求
    [self.manager.operationQueue cancelAllOperations];
}


- (void)getAccountMessage {

    NSString *urlStr = @"https://api.weibo.com/2/users/show.json";
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"access_token"] = [WKAccountTool getAccount].access_token;
    parame[@"uid"] = [WKAccountTool getAccount].uid;
    
    [self.manager GET:urlStr parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //获取用户账号信息
        WKAccount *account = [WKAccount mj_objectWithKeyValues:responseObject];
        
        //保存起来
        [WKAccountTool saveAccount:account];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)setUpUI {

    //设置menuView
    WKTitleBtn *titleBtn = [[WKTitleBtn alloc]init];
    titleBtn.height = 35;
    WKAccount *account = [WKAccountTool getAccount];
    NSString *name = account.name;
    [titleBtn setTitle:name ? name : @"首页" forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleBtn setBackgroundImage:[UIImage resizableImage:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    
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

    self.tableView.mj_footer.hidden = self.statusesArray.count == 0;
    
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
