//
//  VTSearchBar.h
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/14.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, VTSearchBarSelectionStyle) {
    VTSearchBarSelectionStyleNone,      // 无响应事件    (不可输入&不可点击)
    VTSearchBarSelectionStyleInput,     // 可输入状态    ( Default )
    VTSearchBarSelectionStyleClick,     // 可点击状态    (只可点击&不可输入)
};

@interface VTSearchBar : UITextField
/** 快速构建searchBar <针对于导航栏头部的搜索框> */
+ (instancetype)searchBar;


/** 设置搜索栏的可点击效果 */
- (void)setSelectionStyle:(VTSearchBarSelectionStyle)style;

/** 设置输入框点击状态时的点击事件 */
- (void)setClickAction:(void(^)()) clickAction;

@end
