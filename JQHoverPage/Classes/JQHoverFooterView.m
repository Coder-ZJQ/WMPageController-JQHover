//
//  JQHoverFooterView.m
//  ScrollView
//
//  Created by Joker on 2018/5/22.
//  Copyright © 2018年 fanwe. All rights reserved.
//

#import "JQHoverFooterView.h"
#import "UIView+JQExtension.h"
#import "UIScrollView+JQExtension.h"
#import "JQPageController.h"

@interface JQHoverFooterView () <WMPageControllerDelegate>

/** 父滑动控件 */
@property (weak, nonatomic) UIScrollView *superScrollView;
/** 当前子滑动控件 */
@property (weak, nonatomic) UIScrollView *childScrollView;
/** 显示页面控制器 */
@property (weak, nonatomic) JQPageController *pageController;

@end

@implementation JQHoverFooterView

- (instancetype)initWithFrame:(CGRect)frame hoverPage:(JQPageController *)page
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.pageController = page;
        self.pageController.delegate = self;
        [self addSubview:page.view];
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"dealloc %@", NSStringFromClass(self.class));
    if (self.childScrollView) {
        [self.childScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    self.superScrollView = nil;
}

/**
 利用 childScrollView 的 setter 方法动态添加/移除监听

 @param childScrollView 当前页面的 UIScrollView
 */
- (void)setChildScrollView:(UIScrollView *)childScrollView
{
    // 移除旧的监听
    if (_childScrollView) {
        [_childScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    // 赋值
    _childScrollView = childScrollView;
    // 添加新的监听
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [_childScrollView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    // 当添加到父视图不为 UIScrollView 时不作任何处理
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    // 移除监听
    [self removeObservers];
    if (newSuperview)
    {
        self.superScrollView = (UIScrollView *) newSuperview;
        // 通过增加 inset 使其显示
        UIEdgeInsets inset = self.superScrollView.contentInset;
        self.superScrollView.contentInset = UIEdgeInsetsMake(inset.top, inset.left, inset.bottom + self.jq_h, inset.right);
        // 重新设置宽度及位置
        self.jq_w = self.superScrollView.jq_w;
        self.jq_x = -self.superScrollView.jq_insetL;
        self.jq_y = self.superScrollView.jq_contentH;
        // 添加监听
        [self addObservers];
    }
}

#pragma mark -
#pragma mark - WMPageControllerDelegate

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    // 当要移动到其他页面时，设置当前子 UIScrollView
    UIViewController<JQHoverControllerDelegate> *vc = viewController;
    if (self.childScrollView != vc.scrollView) {
        self.childScrollView.jq_offsetY = 0.f;
        self.childScrollView = vc.scrollView;
    }
}

#pragma mark -
#pragma mark - KVO

- (void)addObservers
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    // 监听偏移量，以控制滑动
    [self.superScrollView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    // 监听内容尺寸改变，以重新设置位置(y)
    [self.superScrollView addObserver:self forKeyPath:@"contentSize" options:options context:nil];
}

/// 移除监听
- (void)removeObservers
{
    if (self.superScrollView) {
        [self.superScrollView removeObserver:self forKeyPath:@"contentOffset"];
        [self.superScrollView removeObserver:self forKeyPath:@"contentSize"];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context
{
    if (object == self.superScrollView)
    {
        if (!self.userInteractionEnabled) return;
        if ([keyPath isEqualToString:@"contentSize"])
        {
            CGFloat new = [change[NSKeyValueChangeNewKey] CGSizeValue].height;
            self.jq_y = new;
        }
        if (self.hidden) return;
        if ([keyPath isEqualToString:@"contentOffset"])
        {
            // float 有精度问题，所以判断相等会有问题，故判断差的绝对值个位数是否为0来判读是否到达临界值
            NSInteger delta = (NSInteger)fabs(self.superScrollView.jq_offsetY - (self.superScrollView.jq_contentH - self.superScrollView.jq_h + self.jq_h));
            if (self.superScrollView.jq_offsetY > self.superScrollView.jq_contentH - self.superScrollView.jq_h + self.jq_h)
            {
                self.superScrollView.jq_offsetY = self.superScrollView.jq_contentH - self.superScrollView.jq_h + self.jq_h;
            }
            else if (self.childScrollView &&
                     self.childScrollView.jq_offsetY > 0 &&
                     delta != 0)
            {
                self.superScrollView.jq_offsetY = self.superScrollView.jq_contentH - self.superScrollView.jq_h + self.jq_h;
            }
        }
        self.jq_w = self.superview.jq_w;
    }
    else if (object == self.childScrollView)
    {
        // float 有精度问题，所以判断相等会有问题，故判断差的绝对值个位数是否为0来判读是否到达临界值
        NSInteger delta = (NSInteger)fabs(self.superScrollView.jq_offsetY - (self.superScrollView.jq_contentH - self.superScrollView.jq_h + self.jq_h));
        if (delta == 0)
        {
            self.superScrollView.jq_offsetY = self.superScrollView.jq_contentH - self.superScrollView.jq_h + self.jq_h;
            self.childScrollView.showsVerticalScrollIndicator = YES;
        }
        else if (self.childScrollView.jq_offsetY != 0)
        {
            self.childScrollView.jq_offsetY = 0;
            self.childScrollView.showsVerticalScrollIndicator = NO;
        }
    }
}


@end
