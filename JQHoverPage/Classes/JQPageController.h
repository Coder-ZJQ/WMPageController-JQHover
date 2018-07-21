//
//  JQPageController.h
//  ScrollView
//
//  Created by Joker on 2018/5/22.
//  Copyright © 2018年 fanwe. All rights reserved.
//

#import "WMPageController.h"

@protocol JQSubpageControllerDelegate <NSObject>

@property (nonatomic, readonly) UIScrollView *scrollView;

@end

@interface JQPageController : WMPageController

- (UIViewController <JQSubpageControllerDelegate> *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index;

@end
