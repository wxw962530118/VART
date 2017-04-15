//
//  VTFilterView.h
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/8.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TitleBtnCallBack)(NSInteger didSelectIndex);

@interface VTFilterView : UIView

+(instancetype )createHeaderViewWithTitleArray:(NSArray *)titleArray callBack:(TitleBtnCallBack )callBack;

@end
