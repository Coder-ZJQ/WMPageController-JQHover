# JQHoverPage

[![CI Status](https://img.shields.io/travis/coder-zjq/JQHoverPage.svg?style=flat)](https://travis-ci.org/coder-zjq/JQHoverPage)
[![Version](https://img.shields.io/cocoapods/v/JQHoverPage.svg?style=flat)](https://cocoapods.org/pods/JQHoverPage)
[![License](https://img.shields.io/cocoapods/l/JQHoverPage.svg?style=flat)](https://cocoapods.org/pods/JQHoverPage)
[![Platform](https://img.shields.io/cocoapods/p/JQHoverPage.svg?style=flat)](https://cocoapods.org/pods/JQHoverPage)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![Example](https://github.com/Coder-ZJQ/WMPageController-JQHover/blob/master/images/demo.gif?raw=true)

## Requirements

iOS 6.0 +

## Installation

JQHoverPage is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'JQHoverPage'
```
## Usage

#### Setup the page use WMPageController([click to see more detail](https://github.com/wangmchn/WMPageController))

Main Page

``` objc

#import "WMPageController+JQPage.h"

@interface JQDemoPageController : WMPageController

@end

@implementation JQDemoPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuView.backgroundColor = [UIColor colorWithWhite:.9f alpha:1.f];
}

// the view controller should confirm the JQSubpageControllerDelegate protocol
- (UIViewController<JQSubpageControllerDelegate> *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    JQDemoSubpageController *vc = [[JQDemoSubpageController alloc] init];
    return vc;
}
```

Sub Page

```objc
#import <UIKit/UIKit.h>
#import "WMPageController+JQPage.h"
// subpage view controller should confirm the JQSubpageControllerDelegate protocol
@interface JQDemoSubpageController : UITableViewController <JQSubpageControllerDelegate>

@end
    

@implementation JQDemoSubpageController

#pragma mark -
#pragma mark - JQSubpageControllerDelegate

// implementation JQSubpageControllerDelegate protocol, return the subpage scrollView.
- (UIScrollView *)scrollView {
    return self.tableView;
}
```



#### Append the page to UITableView / UICollectionView / UIScrollView

UITableView

``` objc
// 1. init the hover footer view page
CGFloat height = [UIScreen mainScreen].bounds.size.height - CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) - CGRectGetHeight(self.navigationController.navigationBar.frame);
JQHoverFooterView *footerView = [[JQHoverFooterView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  height)];

// 2. init the page and add the page to current controller's child view controller
JQDemoPageController *page = [[JQDemoPageController alloc] init];
[self addChildViewController:page];

// 3. set the page to hover footer view, set the jq_hoverFooter to tableView
footerView.page = page;
self.tableView.jq_hoverFooter = footerView;
```



UICollectionView

``` objc
// 1. init the hover footer view page
CGFloat height = [UIScreen mainScreen].bounds.size.height - CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) - CGRectGetHeight(self.navigationController.navigationBar.frame);
JQHoverFooterView *footerView = [[JQHoverFooterView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  height)];

// 2. init the page and add the page to current controller's child view controller
JQDemoPageController *page = [[JQDemoPageController alloc] init];
[self addChildViewController:page];

// 3. set the page to hover footer view, set the jq_hoverFooter to collectionView
footerView.page = page;
self.collectionView.jq_hoverFooter = footerView;
```



UIScrollView

```objc
// 1. init the hover footer view page
CGFloat height = [UIScreen mainScreen].bounds.size.height - CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) - CGRectGetHeight(self.navigationController.navigationBar.frame);
JQHoverFooterView *footerView = [[JQHoverFooterView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  height)];

// 2. init the page and add the page to current controller's child view controller
JQDemoPageController *page = [[JQDemoPageController alloc] init];
[self addChildViewController:page];

// 3. set the page to hover footer view, set the jq_hoverFooter to collectionView
footerView.page = page;
self.scrollView.jq_hoverFooter = footerView;
```

(See more detail in Example project)

## Thanks To

[WMPageController](https://github.com/wangmchn/WMPageController): provide the page implementation.

[MJRefresh](https://github.com/CoderMJLee/MJRefresh ): provide the idea of this project.


## Author

coder-zjq, zjq_joker@163.com

## License

JQHoverPage is available under the MIT license. See the LICENSE file for more info.
