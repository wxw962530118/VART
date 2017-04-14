//
//  VTAusleseHeaderView.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/8.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTAusleseHeaderView.h"
#import "LoopScrollView.h"
#import "AIELoopView.h"
@interface VTAusleseHeaderView ()
/**轮播图*/
@property (nonatomic, strong) LoopScrollView * loopView;
/**图片URL数组*/
@property (nonatomic, strong) NSArray <NSURL *> * imageUrlArray;
//广告轮播view
@property (nonatomic, strong)  AIELoopView   * adView;

@end

@implementation VTAusleseHeaderView
+(instancetype )createHeaderViewWithImageUrlArray:(NSArray *)imageUrlArray{
    VTAusleseHeaderView * view = [[VTAusleseHeaderView alloc]initWithImageUrlArray:imageUrlArray];
    view.imageUrlArray = imageUrlArray;
    [view loadAllComponents];
    return view;
}

-(void)loadAllComponents{
    [self addSubview:self.adView];
    [self.adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

-(instancetype )initWithImageUrlArray:(NSArray *)array{
    self = [super init];
    if (self) {
        //初始化子控件
        self.imageUrlArray = array;
    }
    return self;
}

-(AIELoopView *)adView{
    if (_adView == nil) {
        _adView = [[AIELoopView alloc]initWithURLs:self.imageUrlArray didSelected:^(NSInteger index) {
            NSLog(@"当前点击的图片---%ld",index);
        }];
    }
    return _adView;
}


@end
