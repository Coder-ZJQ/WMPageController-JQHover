//
//  WMPageController+JQPage.h
//  JQHoverPage
//
//  Created by Joker on 2018/7/23.
//

#import "WMPageController.h"

@protocol JQSubpageControllerDelegate <NSObject>

@property (nonatomic, readonly) UIScrollView *scrollView;

@end

@interface WMPageController (JQPage)

- (UIViewController <JQSubpageControllerDelegate> *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index;

@end
