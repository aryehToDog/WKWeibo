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
@interface WKHomeTableViewController ()<WKPopMenuDelegate>

@property (nonatomic,assign)BOOL isSelectImage;
@property (nonatomic,strong)WKTitleBtn *titleBtn;
@end

@implementation WKHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI {

    //设置menuView
    WKTitleBtn *titleBtn = [[WKTitleBtn alloc]init];
    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
