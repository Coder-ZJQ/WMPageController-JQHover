//
//  JQHoverFooterView.h
//  ScrollView
//
//  Created by Joker on 2018/5/22.
//  Copyright © 2018年 fanwe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JQPageController;

/** 利用 WMPageController 封装底部菜单悬浮页面控件 */
@interface JQHoverFooterView : UIView

/**
 初始化一个悬浮底部

 @param frame 悬浮底部的 frame
 @param page 悬浮底部需显示的相关页面
 @return 实例化的悬浮控件
 */
- (instancetype)initWithFrame:(CGRect)frame hoverPage:(JQPageController *)page;

@end
