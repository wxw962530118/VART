//
//  VTSearchViewController.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/15.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTSearchViewController.h"
#import "VTTopSliderView.h"
@interface VTSearchViewController ()

@property (nonatomic, strong) NSArray * topTitleArray;

@property (nonatomic, strong) VTTopSliderView * topSliderView;

@end

@implementation VTSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor whiteColor];
    [self createTopSliderView];
}

-(void)createTopSliderView{
    self.topTitleArray =  @[@"热门",@"精选",@"历史",@"人文",@"社会",@"财经"];
    self.topSliderView = [VTTopSliderView createHeaderViewWithTitleArray:self.topTitleArray];
    self.topSliderView.frame = CGRectMake(0, 64, ScreenWidth, 50);
    [self.view addSubview:self.topSliderView];
}

@end
