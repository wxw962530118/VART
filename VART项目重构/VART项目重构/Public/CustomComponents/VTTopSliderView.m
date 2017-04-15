//
//  VTTopSliderView.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/15.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTTopSliderView.h"
#define  BaseTag  1000

@interface VTTopSliderView ()

/*外界传的标题数组*/
@property (nonatomic, strong) NSArray * titleArray;
/**当前选中的位置*/
@property (nonatomic, assign) NSInteger nowClickIndex;
/**标签栏底部的指示器view*/
@property (nonatomic,strong) UIView   * indicatorView;
/**当前选中的按钮*/
@property (nonatomic,strong) UIButton * selectButton;

@property (nonatomic, strong) UIButton * titleButton;

@end

@implementation VTTopSliderView

+(instancetype )createHeaderViewWithTitleArray:(NSArray *)titleArray{
    VTTopSliderView * view = [[VTTopSliderView alloc]initWithTitleArray:titleArray];
    [view loadAllComponents];
    return view;
}

-(void)loadAllComponents{
    //文字下面的指示器view
    UIView * indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = 44 - indicatorView.height;
    self.indicatorView = indicatorView;
    [self addSubview:indicatorView];
    NSInteger count = self.titleArray.count;
    CGFloat btnW = ScreenWidth / count;
    CGFloat btnH = 44;
    for (int i = 0; i < count ; i++) {
        self.titleButton = [[UIButton alloc]initWithFrame:CGRectMake(btnW * i, 0, btnW, btnH)];
        [self.titleButton setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [self.titleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.titleButton.tag = BaseTag + i;
        [self.titleButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.titleButton];
        //默认点击第一个按钮
        if (i == 0) {
            [self layoutIfNeeded];
            [self btnClick:self.titleButton];
        }
    }
}

-(void)btnClick:(UIButton *)sender{
    self.selectButton.enabled = YES;
    [self.selectButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    sender.enabled = NO;
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.selectButton = sender;
    [self.selectButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.1 animations:^{
        self.indicatorView.width = sender.width;
        self.indicatorView.centerX = sender.centerX;
    }];
}

-(instancetype )initWithTitleArray:(NSArray *)array{
    self = [super init];
    if (self) {
        //初始化子控件
        self.titleArray = array;
        self.nowClickIndex = 0;
    }
    return self;
}


@end
