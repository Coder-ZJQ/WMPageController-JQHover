//
//  JQHoverFooterView.m
//  ScrollView
//
//  Created by Joker on 2018/5/22.
//  Copyright © 2018年 Joker. All rights reserved.
//

#import "JQHoverFooterView.h"
#import "UIView+JQExtension.h"
#import "UIScrollView+JQExtension.h"
#import "WMPageController+JQPage.h"

@interface JQHoverFooterView () <WMPageControllerDelegate>

/** 父滑动控件 */
@property (weak, nonatomic) UIScrollView *superScrollView;
/** 当前子滑动控件 */
@property (weak, nonatomic) UIScrollView *childScrollView;

@end

@implementation JQHoverFooterView

#pragma mark -
#pragma mark - override

- (void)dealloc
{
    if (self.childScrollView) {
        [self.childScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    self.superScrollView = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置默认
        self.topBounceType = JQHoverTopBounceTypeMain;
    }
    return self;
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
#pragma mark - setter

- (void)setPage:(WMPageController *)page {
    _page = page;
    _page.delegate = self;
    [self addSubview:page.view];
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

#pragma mark -
#pragma mark - WMPageControllerDelegate

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    // 当要移动到其他页面时，设置当前子 UIScrollView
    if ([viewController conformsToProtocol:@protocol(JQSubpageControllerDelegate)] && [viewController respondsToSelector:@selector(scrollView)]) {
        UIViewController<JQSubpageControllerDelegate> *vc = viewController;
        if (self.childScrollView != vc.scrollView)
        {
            self.childScrollView.jq_offsetY = 0.f;
            self.childScrollView = vc.scrollView;
        }
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
    if ([keyPath isEqualToString:@"contentSize"])
    {
        CGFloat new = [change[NSKeyValueChangeNewKey] CGSizeValue].height;
        self.jq_y = new;
        self.jq_w = self.superview.jq_w;
    }
    // 以下判断待有时间整理优化
    else if ([keyPath isEqualToString:@"contentOffset"])
    {
        CGFloat new = [change[NSKeyValueChangeNewKey] CGPointValue].y;
        CGFloat old = [change[NSKeyValueChangeOldKey] CGPointValue].y;
        if (new == old) return;
        CGFloat delta = fabs(self.superScrollView.jq_offsetY - (self.superScrollView.jq_contentH - self.superScrollView.jq_h + self.jq_h));
        if (self.superScrollView.jq_offsetY > self.superScrollView.jq_contentH - self.superScrollView.jq_h + self.jq_h)
        {
            self.superScrollView.jq_offsetY = self.superScrollView.jq_contentH - self.superScrollView.jq_h + self.jq_h;
        }
        else if (self.superScrollView.jq_offsetY < 0)
        {
            if (self.topBounceType == JQHoverTopBounceTypeSub)
            {
                self.superScrollView.jq_offsetY = 0;
            }
        }
        else if (self.superScrollView.jq_offsetY != self.superScrollView.jq_contentH - self.superScrollView.jq_h + self.jq_h && self.superScrollView.jq_offsetY != 0)
        {
            if (self.childScrollView.jq_offsetY > fabs(new - old) + 1)
            {
                self.superScrollView.jq_offsetY = self.superScrollView.jq_contentH - self.superScrollView.jq_h + self.jq_h;
            }
            if (self.topBounceType == JQHoverTopBounceTypeSub && self.childScrollView.jq_offsetY < -fabs(new - old) - 1)
            {
                self.superScrollView.jq_offsetY = 0;
                return;
            }
            if (self.topBounceType == JQHoverTopBounceTypeSub && self.childScrollView.jq_offsetY < 0)
            {
                self.childScrollView.jq_offsetY = 0;
            }
        }
        if (self.childScrollView.jq_offsetY < 0)
        {
            if (self.topBounceType == JQHoverTopBounceTypeMain)
            {
                self.childScrollView.jq_offsetY = 0;
            }
        }
        else if (self.childScrollView.jq_offsetY > 0)
        {
            if (delta > fabs(new - old) + 1)
            {
                self.childScrollView.jq_offsetY = 0;
            }
        }
        self.childScrollView.showsVerticalScrollIndicator = self.childScrollView.jq_offsetY != 0;
        self.superScrollView.showsVerticalScrollIndicator = !self.childScrollView.showsVerticalScrollIndicator;
    }
}


@end
