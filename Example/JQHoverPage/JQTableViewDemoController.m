//
//  JQTableViewDemoController.m
//  JQHoverPage_Example
//
//  Created by Joker on 2018/7/9.
//  Copyright © 2018年 coder-zjq. All rights reserved.
//

#import "JQTableViewDemoController.h"
#import "JQHoverFooterView.h"
#import "UIScrollView+JQHover.h"
#import "JQDemoPageController.h"

@interface JQTableViewDemoController ()

@end

@implementation JQTableViewDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set up the tableView
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    // setup the table header view
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
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
