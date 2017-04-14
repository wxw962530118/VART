//
//  VTRootTabItemModel.h
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/8.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTBaseModel.h"
#import <UIKit/UIKit.h>
@interface VTRootTabItemModel : VTBaseModel

@property (nonatomic, copy) NSString * class_name;

@property (nonatomic, copy) NSString * icon_normal;

@property (nonatomic, copy) NSString * icon_selected;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, strong) UIImage * rIcon_normal;

@property (nonatomic, strong) UIImage * rIcon_selected;

@end
