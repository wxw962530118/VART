//
//  VTCityTopMenu.h
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/9.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^cityTopMenuCallBack)(NSInteger selectIndex);

@interface VTCityTopMenu : UIView

//- (void)topMenuRowText:(NSArray *)rowText topView:(UIView *)topView;
+(instancetype )initWithTitleArray:(NSArray *)titleArray callBack:(cityTopMenuCallBack)callBack;
@end
