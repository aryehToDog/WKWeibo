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
#import "WKStatuesRequest.h"
#import "WKStatuesTool.h"
#import "WKAccountRequest.h"



@interface WKHomeTableViewController ()<WKPopMenuDelegate>

@property (nonatomic,assign)BOOL isSelectImage;
@property (nonatomic,strong)WKTitleBtn *titleBtn;
@property (nonatomic,strong)NSMutableArray *statusesArray;
/** 字典请求参数,防止用户请求超时 */
@property (nonatomic,strong)WKStatuesRequest *parmae;
@end

@implementation WKHomeTableViewController

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
    
    WKStatuesRequest *parmae = [[WKStatuesRequest alloc]init];
    parmae.access_token = [WKAccountTool getAccount].access_token;
    WKStatus *lastStatu = [self.statusesArray lastObject];
    if (lastStatu) {
#warning 为啥这地方要-1;
        parmae.max_id = @([lastStatu.idstr longLongValue] - 1);
    }
//    self.parmae = parame;
    
    [WKStatuesTool statuesWithUrl:urlStr parameters:parmae success:^(WKStatuesResult *responseObject) {
//        if (self.parmae != parmae) return ;
        
        //字典数组转成模型数组
        NSArray *moreDictArray = responseObject.statuses;
        
        [self.statusesArray addObjectsFromArray:moreDictArray];
        
        [self.tableView reloadData];
        
        NSInteger totolCount = [responseObject.total_number integerValue];
        
        if (self.statusesArray.count == totolCount) {
            
            //数据完全加载完成
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
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
    
    WKStatuesRequest *parame = [[WKStatuesRequest alloc]init];
    parame.access_token = [WKAccountTool getAccount].access_token;
    WKStatus *firstStatus = [self.statusesArray firstObject];
        if (firstStatus) {
            parame.since_id = @([firstStatus.idstr longLongValue]);
        }
//    self.parmae = parame;
    [WKStatuesTool statuesWithUrl:urlStr parameters:parame success:^(WKStatuesResult *responseObject) {
//        if (self.parmae != parame) return ;
        //字典数组转成模型数组
        NSArray *newResult = responseObject.statuses;
        
        NSRange range = {0,newResult.count};
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        
        [self.statusesArray insertObjects:newResult atIndexes:indexSet];
        
        //提示刷新数据
        [self showRefreshMessageWith:newResult.count];
        
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    }];

}

- (void)refresh:(BOOL)isfromSelf {

    if (self.tabBarItem.badgeValue) {
        
            //下拉刷新数据
        [self.tableView.mj_header beginRefreshing];
        
    }else if (isfromSelf) {
    
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }

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

- (void)getAccountMessage {

    NSString *urlStr = @"https://api.weibo.com/2/users/show.json";
    
    WKAccountRequest *parame = [[WKAccountRequest alloc]init];
    parame.access_token = [WKAccountTool getAccount].access_token;
    parame.uid = [WKAccountTool getAccount].uid;
    
    [WKAccountTool accountGetNameWithUrl:urlStr parameters:parame success:^(WKAccountResult *responseObject) {
        //获取用户账号信息
        WKUser *user = responseObject;
        // 设置用户的昵称为标题
        [self.titleBtn setTitle:user.screen_name forState:UIControlStateNormal];
        //保存起来
        WKAccount *acount = [WKAccountTool getAccount];
        acount.name = user.screen_name;
        
        [WKAccountTool saveAccount:acount];
    } failure:^(NSError *error) {
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
    cell.detailTextLabel.text = uesr.screen_name;
    
    return cell;
}
@end
