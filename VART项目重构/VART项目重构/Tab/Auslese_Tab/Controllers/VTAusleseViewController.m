//
//  VTAusleseViewController.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/8.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTAusleseViewController.h"
#import "VTAusleseHeaderView.h"
@interface VTAusleseViewController ()

@property (nonatomic, strong) NSMutableArray <NSURL *> * originalImageUrls;

@end

@implementation VTAusleseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建轮播图数据
    self.originalImageUrls  = [NSMutableArray array];
    [self.originalImageUrls addObject:[NSURL URLWithString:@"http://ww3.sinaimg.cn/large/006ka0Iygw1f6bqm7zukpj30g60kzdi2.jpg"]];
    [self.originalImageUrls addObject:[NSURL URLWithString:@"http://ww1.sinaimg.cn/large/61b69811gw1f6bqb1bfd2j20b4095dfy.jpg"]];
    [self.originalImageUrls addObject:[NSURL URLWithString:@"http://ww1.sinaimg.cn/large/54477ddfgw1f6bqkbanqoj20ku0rsn4d.jpg"]];
    [self.originalImageUrls addObject:[NSURL URLWithString:@"http://ww4.sinaimg.cn/large/006ka0Iygw1f6b8gpwr2tj30bc0bqmyz.jpg"]];
    [self.originalImageUrls addObject:[NSURL URLWithString:@"http://ww2.sinaimg.cn/large/9c2b5f31jw1f6bqtinmpyj20dw0ae76e.jpg"]];

    VTAusleseHeaderView * headerView  = [VTAusleseHeaderView createHeaderViewWithImageUrlArray:self.originalImageUrls];
    headerView.frame = CGRectMake(0,64, ScreenWidth,175);
    [self.view addSubview:headerView];
    
    NSString * requestURL = [NSString stringWithFormat:@"%@%@", VTInterFaceNet, @"/api/activities/recommend_services.json"];
    [[VTAusleseNetWork manager]getAusleseDataWith:requestURL parameters:nil success:^(id response) {
        NSLog(@"respons--%@",response);
    } faile:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


@end
