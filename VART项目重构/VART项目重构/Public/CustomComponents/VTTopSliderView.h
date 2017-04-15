//
//  VTTopSliderView.h
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/15.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VTTopSliderViewDelegate <NSObject>
//


@end

@interface VTTopSliderView : UIView

@property (nonatomic, weak) id <VTTopSliderViewDelegate> delegate;

+(instancetype )createHeaderViewWithTitleArray:(NSArray *)titleArray;

@end
