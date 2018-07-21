//
//  JQPageController.m
//  ScrollView
//
//  Created by Joker on 2018/5/22.
//  Copyright © 2018年 fanwe. All rights reserved.
//

#import "JQPageController.h"

@interface JQPageController ()

@end

@implementation JQPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 供子类重写
- (UIViewController <JQSubpageControllerDelegate> *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    return nil;
}

@end
