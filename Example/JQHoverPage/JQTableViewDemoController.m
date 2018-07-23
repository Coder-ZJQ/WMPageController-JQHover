//
//  JQTableViewDemoController.m
//  JQHoverPage_Example
//
//  Created by Joker on 2018/7/9.
//  Copyright © 2018年 coder-zjq. All rights reserved.
//

#import "JQTableViewDemoController.h"
#import "JQHoverPage.h"
#import "JQDemoPageController.h"
#import "MJRefresh.h"

@interface JQTableViewDemoController ()

@end

@implementation JQTableViewDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set up the tableView
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
        });
    }];
    
    // setup the table header view
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    label.backgroundColor = [UIColor redColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"This is tableView tableHeaderView.\nYou can replace it with your custom tableHeaderView.";
    self.tableView.tableHeaderView = label;
    
    // 1. init the hover footer view page
    CGFloat height = [UIScreen mainScreen].bounds.size.height - CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) - CGRectGetHeight(self.navigationController.navigationBar.frame);
    JQHoverFooterView *footerView = [[JQHoverFooterView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  height)];
    
    // 2. init the page and add the page to current controller's child view controller
    JQDemoPageController *page = [[JQDemoPageController alloc] init];
    [self addChildViewController:page];
    
    // 3. set the page to hover footer view, set the jq_hoverFooter to tableView
    footerView.page = page;
    self.tableView.jq_hoverFooter = footerView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
