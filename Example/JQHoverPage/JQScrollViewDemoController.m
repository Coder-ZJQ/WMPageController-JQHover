//
//  JQScrollViewDemoController.m
//  JQHoverPage_Example
//
//  Created by Joker on 2018/7/21.
//  Copyright © 2018年 coder-zjq. All rights reserved.
//

#import "JQScrollViewDemoController.h"
#import "JQHoverPage.h"
#import "JQDemoPageController.h"
#import "MJRefresh.h"

@interface JQScrollViewDemoController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation JQScrollViewDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.scrollView.mj_header endRefreshing];
        });
    }];
    
    // 1. init the hover footer view page
    CGFloat height = [UIScreen mainScreen].bounds.size.height - CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) - CGRectGetHeight(self.navigationController.navigationBar.frame);
    JQHoverFooterView *footerView = [[JQHoverFooterView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  height)];
    
    // 2. init the page and add the page to current controller's child view controller
    JQDemoPageController *page = [[JQDemoPageController alloc] init];
    [self addChildViewController:page];
    
    // 3. set the page to hover footer view, set the jq_hoverFooter to collectionView
    footerView.page = page;
    self.scrollView.jq_hoverFooter = footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
