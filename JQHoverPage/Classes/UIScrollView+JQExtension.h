//
//  UIScrollView+JQExtension.h
//  ScrollView
//
//  Created by Joker on 2018/5/22.
//  Copyright © 2018年 fanwe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (JQExtension)

@property (readonly, nonatomic) UIEdgeInsets jq_inset;

@property (assign, nonatomic) CGFloat jq_insetT;
@property (assign, nonatomic) CGFloat jq_insetB;
@property (assign, nonatomic) CGFloat jq_insetL;
@property (assign, nonatomic) CGFloat jq_insetR;

@property (assign, nonatomic) CGFloat jq_offsetX;
@property (assign, nonatomic) CGFloat jq_offsetY;

@property (assign, nonatomic) CGFloat jq_contentW;
@property (assign, nonatomic) CGFloat jq_contentH;
@end
