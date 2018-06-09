//
//  UIScrollView+JQHover.h
//  ScrollView
//
//  Created by Joker on 2018/5/22.
//  Copyright © 2018年 fanwe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JQHoverFooterView;
@interface UIScrollView (JQHover)

/** 包裹悬浮底部控件 */
@property (strong, nonatomic) JQHoverFooterView *jq_hoverFooter;

@end
