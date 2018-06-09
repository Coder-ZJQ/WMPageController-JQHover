//
//  UIScrollView+JQExtension.m
//  ScrollView
//
//  参考自 MJ Lee MJRefresh
//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//
//  Created by Joker on 2018/5/22.
//  Copyright © 2018年 fanwe. All rights reserved.
//

#import "UIScrollView+JQExtension.h"

#import <objc/runtime.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

@implementation UIScrollView (JQExtension)

static BOOL gt_ios_11_;
+ (void)load
{
    // 缓存判断值
    gt_ios_11_ = [[[UIDevice currentDevice] systemVersion] compare:@"11.0" options:NSNumericSearch] != NSOrderedAscending;
}

- (UIEdgeInsets)jq_inset
{
#ifdef __IPHONE_11_0
    if (gt_ios_11_) {
        return self.adjustedContentInset;
    }
#endif
    return self.contentInset;
}

- (void)setJq_insetT:(CGFloat)jq_insetT
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = jq_insetT;
#ifdef __IPHONE_11_0
    if (gt_ios_11_) {
        inset.top -= (self.adjustedContentInset.top - self.contentInset.top);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)jq_insetT
{
    return self.jq_inset.top;
}

- (void)setJq_insetB:(CGFloat)jq_insetB
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = jq_insetB;
#ifdef __IPHONE_11_0
    if (gt_ios_11_) {
        inset.bottom -= (self.adjustedContentInset.bottom - self.contentInset.bottom);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)jq_insetB
{
    return self.jq_inset.bottom;
}

- (void)setJq_insetL:(CGFloat)jq_insetL
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = jq_insetL;
#ifdef __IPHONE_11_0
    if (gt_ios_11_) {
        inset.left -= (self.adjustedContentInset.left - self.contentInset.left);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)jq_insetL
{
    return self.jq_inset.left;
}

- (void)setJq_insetR:(CGFloat)jq_insetR
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = jq_insetR;
#ifdef __IPHONE_11_0
    if (gt_ios_11_) {
        inset.right -= (self.adjustedContentInset.right - self.contentInset.right);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)jq_insetR
{
    return self.jq_inset.right;
}

- (void)setJq_offsetX:(CGFloat)jq_offsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = jq_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)jq_offsetX
{
    return self.contentOffset.x;
}

- (void)setJq_offsetY:(CGFloat)jq_offsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = jq_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)jq_offsetY
{
    return self.contentOffset.y;
}

- (void)setJq_contentW:(CGFloat)jq_contentW
{
    CGSize size = self.contentSize;
    size.width = jq_contentW;
    self.contentSize = size;
}

- (CGFloat)jq_contentW
{
    return self.contentSize.width;
}

- (void)setJq_contentH:(CGFloat)jq_contentH
{
    CGSize size = self.contentSize;
    size.height = jq_contentH;
    self.contentSize = size;
}

- (CGFloat)jq_contentH
{
    return self.contentSize.height;
}
@end
#pragma clang diagnostic pop

