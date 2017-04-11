//
//  VTMacroColors.h
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/8.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#ifndef VTMacroColors_h
#define VTMacroColors_h

/** App 主色调         [蓝色] */
#define SCColorMain         SCColor(20, 146,225)

/** App 次色调         [绿色] */
#define SCColorSubMain      SCColor(75, 174, 79)

/** App 辅助色/警告色   [红色] */
#define SCColorAssist       SCColor(243, 66, 53)

/** App 状态文字/警示色  [橙色] */
#define SCColorWarning      SCColor(254,151,0)

/** App 重点文字色      [黑色] */
#define SCColorEmphasis     SCColor(51, 51, 51)

/** App 正文色         [大灰] */
#define SCColorMainBody     SCColor(114, 114, 114)

/** App 二级文字色      [中灰] */
#define SCColorSubBody      SCColor(181, 181, 181)

/** App 分割线颜色      [描边灰] */
#define SCColorSeparator    SCColor(223, 223, 223)

/** App 页面背景色      [淡灰] */
#define SCColorBackGround   SCColor(238, 238, 238)

/** App 页面白色背景     [白色] */
#define SCColorWhiteGround  SCColor(255, 255, 255)

/** App 图层边框色      [浅灰] */
#define SCColorLayerBorder  SCColor(190, 190, 190)

/** App 控件描边灰色     [淡灰] */
#define SCColorComponentBorder  SCColor(216, 216, 216)

/** App Cell选中色      [淡灰] */
#define SCColorSelector     SCColor(250, 250, 250)

/** App 白色块的点击效果      [轻灰] */
#define SCWhriteClickColor     SCColor(240, 240, 240)

/** App 灰色333333      [灰] */
#define SCColorGaryColor     SCColor(33, 33, 33)

/** App 透明色 */
#define SCColorClear        [UIColor clearColor]


// 获取验证码的背景 RGB颜色
#define SCColorButton  [UIColor colorWithRed:255/255.0 green:157/255.0 blue:0/255.0 alpha:1.0]

// 获取验证码的背景点击后的RGB颜色
#define SCColorButtonClick  [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]

// RGB颜色
#define SCColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define SCColorAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 随机色
#define SCRandomColor HWColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//cell的标识符
#define kCellIdentifier  NSStringFromClass(self)

#endif /* VTMacroColors_h */
