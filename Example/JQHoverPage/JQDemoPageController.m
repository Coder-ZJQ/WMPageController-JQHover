//
//  JQDemoPageController.m
//  JQHoverPage_Example
//
//  Created by Joker on 2018/7/9.
//  Copyright © 2018年 coder-zjq. All rights reserved.
//

#import "JQDemoPageController.h"
#import "JQDemoSubpageController.h"

#define kScreenW                [[UIScreen mainScreen] bounds].size.width
#define kScreenH                [[UIScreen mainScreen] bounds].size.height
#define kStatusBarHeight        ([UIApplication sharedApplication].statusBarFrame.size.height)
@interface JQDemoPageController ()

@end

@implementation JQDemoPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 5;
}

- (NSString *)menuView:(WMMenuView *)menu titleAtIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"page %ld", index];
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, 0, kScreenW, 36);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(nonnull WMScrollView *)contentView {
    return CGRectMake(0, 36, kScreenW, kScreenH - 64 -36);
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    JQDemoSubpageController *vc = [[JQDemoSubpageController alloc] init];
    return vc;
}


@end
