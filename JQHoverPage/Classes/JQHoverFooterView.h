//
//  JQHoverFooterView.h
//  ScrollView
//
//  Created by Joker on 2018/5/22.
//  Copyright © 2018年 Joker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WMPageController;

typedef NS_ENUM(NSInteger, JQHoverTopBounceType) {
    JQHoverTopBounceTypeMain = 1,   /**< 滑动到顶部时主页面顶部有弹簧效果 */
    JQHoverTopBounceTypeSub = 2     /**< 滑动到顶部时子页面顶部有弹簧效果 */
};

/** 利用 WMPageController 封装底部菜单悬浮页面控件 */
@interface JQHoverFooterView : UIView

/** 显示页面控制器 */
@property (weak, nonatomic) WMPageController *page;

/** 顶部弹簧类型（主页面/子页面，可用于控制主页面/子页面头部刷新） */
@property (nonatomic) JQHoverTopBounceType topBounceType;

@end
