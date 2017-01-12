//
//  WKSearchBar.m
//  王昆微博
//
//  Created by 阿拉斯加的狗 on 2017/1/12.
//  Copyright © 2017年 阿拉斯加的🐶. All rights reserved.
//

#import "WKSearchBar.h"

@implementation WKSearchBar

+ (instancetype)searchBar {

    WKSearchBar *searchBar = [[WKSearchBar alloc]init];
    searchBar.background = [UIImage resizableImage:@"searchbar_textfield_background"];
    searchBar.width = [UIScreen mainScreen].bounds.size.width;
    searchBar.height = 30;
    
    
    UIImageView *leftView = [[UIImageView alloc]init];
    leftView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    searchBar.leftView =leftView;
    searchBar.leftViewMode = UITextFieldViewModeAlways;
    leftView.width = 30;
    leftView.height = 30;
    leftView.contentMode = UIViewContentModeCenter;
    
    searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    return searchBar;
}

@end
