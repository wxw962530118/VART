//
//  VTAusleseCollectionViewCell.h
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/13.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VTAusleseCollectionModel.h"
@interface VTAusleseCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) VTAusleseCollectionModel * model;


@property (nonatomic, strong) NSURL * urlStr;

@end
