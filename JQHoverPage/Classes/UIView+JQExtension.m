//
//  UIView+JQExtension.m
//  ScrollView
//
//  Created by Joker on 2018/5/22.
//  Copyright © 2018年 fanwe. All rights reserved.
//

#import "UIView+JQExtension.h"

@implementation UIView (JQExtension)
- (void)setJq_x:(CGFloat)jq_x
{
    CGRect frame = self.frame;
    frame.origin.x = jq_x;
    self.frame = frame;
}

- (CGFloat)jq_x
{
    return self.frame.origin.x;
}

- (void)setJq_y:(CGFloat)jq_y
{
    CGRect frame = self.frame;
    frame.origin.y = jq_y;
    self.frame = frame;
}

- (CGFloat)jq_y
{
    return self.frame.origin.y;
}

- (void)setJq_w:(CGFloat)jq_w
{
    CGRect frame = self.frame;
    frame.size.width = jq_w;
    self.frame = frame;
}

- (CGFloat)jq_w
{
    return self.frame.size.width;
}

- (void)setJq_h:(CGFloat)jq_h
{
    CGRect frame = self.frame;
    frame.size.height = jq_h;
    self.frame = frame;
}

- (CGFloat)jq_h
{
    return self.frame.size.height;
}

- (void)setJq_size:(CGSize)jq_size
{
    CGRect frame = self.frame;
    frame.size = jq_size;
    self.frame = frame;
}

- (CGSize)jq_size
{
    return self.frame.size;
}

- (void)setJq_centerX:(CGFloat)jq_centerX
{
    CGPoint center = self.center;
    center.x = jq_centerX;
    self.center = center;
}

- (CGFloat)jq_centerX
{
    return CGRectGetMidX(self.frame);
}

- (void)setJq_centerY:(CGFloat)jq_centerY
{
    CGPoint center = self.center;
    center.y = jq_centerY;
    self.center = center;
}

- (CGFloat)jq_centerY
{
    return CGRectGetMidY(self.frame);
}
- (void)setJq_origin:(CGPoint)jq_origin
{
    CGRect frame = self.frame;
    frame.origin = jq_origin;
    self.frame = frame;
}

- (CGPoint)jq_origin
{
    return self.frame.origin;
}
@end
