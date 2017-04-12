//
//  VTCityNavMenuView.h
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/12.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VTCityNavMenuContentModel;
typedef void (^cityTopMenuCallBack)(NSInteger selectIndex);

@interface VTCityNavMenuView : UIView

+(instancetype )initWithTitleArray:(NSArray <VTCityNavMenuContentModel *>*)titleArray callBack:(cityTopMenuCallBack)callBack;

-(void)showTopMenuView;

@end
