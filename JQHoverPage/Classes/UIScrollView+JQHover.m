//
//  UIScrollView+JQHover.m
//  ScrollView
//
//  Created by Joker on 2018/5/22.
//  Copyright © 2018年 Joker. All rights reserved.
//

#import "UIScrollView+JQHover.h"
#import <objc/runtime.h>
#import "JQHoverFooterView.h"

static const char JQHoverFooterViewAssociatedKey = '\0';

@implementation UIScrollView (JQHover)

#pragma mark -
#pragma mark - UIGestureRecognizerDelegate

BOOL gestureRecognizerShouldRecognizeSimultaneouslyWithOtherGestureRecognizer(id self, SEL _cmd, UIGestureRecognizer *gestureRecognizer, UIGestureRecognizer *otherGestureRecognizer) {
    UIScrollView *scrollView = (UIScrollView *)self;
    if (scrollView.jq_hoverFooter) {
        return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
    } else {
        return NO;
    }
}

/// 在load方法内替换方法实现
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod(self, NSSelectorFromString(@"dealloc")), class_getInstanceMethod(self, @selector(jq_dealloc)));
        // 如果已实现则替换实现
        if ([self instancesRespondToSelector:@selector(gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)]) {
            method_exchangeImplementations(class_getInstanceMethod(self, @selector(gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)),class_getInstanceMethod(self, @selector(jq_gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)));
        }
        // 如果未实现则利用运行时添加实现
        else {
            class_addMethod(self, @selector(gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:), (IMP)gestureRecognizerShouldRecognizeSimultaneouslyWithOtherGestureRecognizer, "v@:");
        }
    });
}

/// 在替换的方法内判断是否处理多个手势
- (BOOL)jq_gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.jq_hoverFooter) {
        return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
    } else {
        return [self jq_gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    }
}

#pragma mark -
#pragma mark - getter & setter

- (void)setJq_hoverFooter:(JQHoverFooterView *)jq_hoverFooter {
    if (jq_hoverFooter != self.jq_hoverFooter) {
        [self.jq_hoverFooter removeFromSuperview];
        [self insertSubview:jq_hoverFooter atIndex:0];
        [self willChangeValueForKey:@"jq_hoverFooter"];
        objc_setAssociatedObject(self, &JQHoverFooterViewAssociatedKey,
                                 jq_hoverFooter, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"jq_hoverFooter"];
    }
}

- (JQHoverFooterView *)jq_hoverFooter {
    return objc_getAssociatedObject(self, &JQHoverFooterViewAssociatedKey);
}

- (void)jq_dealloc {
    if (self.jq_hoverFooter) {
        [self removeObserver:self.jq_hoverFooter forKeyPath:@"contentSize"];
        [self removeObserver:self.jq_hoverFooter forKeyPath:@"contentOffset"];
    }
    [self jq_dealloc];
}


@end


