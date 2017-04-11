//
//  VTCityViewController.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/8.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTCityViewController.h"
#import "VTFilterView.h"
#import "VTFairTableViewCell.h"
#import "VTSpaceTableViewCell.h"
#import "VTCityTopMenu.h"
#import "VTCityTopMenuController.h"

@interface VTCityViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate>
/**<#注释#>*/
@property (nonatomic, strong) NSArray *titleArray;
/**同城 展览*/
@property (nonatomic, strong) UITableView *fairTableView;
/**同城 空间*/
@property (nonatomic, strong) UITableView *spaceTableView;
/**<#注释#>*/
@property (nonatomic, strong) VTFilterView *filterView;
/**<#注释#>*/
@property (nonatomic, strong) VTCityTopMenu *menuV;
/**<#注释#>*/
@property (nonatomic, strong) UIView *vc;
/**<#注释#>*/
@property (nonatomic, assign) NSInteger btnClickCount;

@end

@implementation VTCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self createTitleView];
    [self createFilterView];

}

- (void)createTitleView {

    UIButton *titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, 8, 50, 30)];
    [titleBtn setTitle:@"热门" forState:(UIControlStateNormal)];
    [titleBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    
    [titleBtn addTarget:self action:@selector(titleBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.titleView = titleBtn;

}


- (void)titleBtnClick {
    [self shade];
    _menuV = [[VTCityTopMenu alloc] initWithFrame:CGRectMake(100, 64, ScreenWidth - 200, 300)];
    
    _menuV.backgroundColor = [UIColor redColor];
    
    [_menuV topMenuRowText:self.titleArray topView:_menuV];
    [_vc addSubview:_menuV];
  
    
    
    
}

//遮罩
- (void)shade {

    UITapGestureRecognizer *shadeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shadeTapClick)];
    //轻拍次数
    shadeTap.numberOfTapsRequired =1;
    //轻拍手指个数
    shadeTap.numberOfTouchesRequired =1;
    
    _vc = [[UIView alloc] initWithFrame:self.view.bounds];
    _vc.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    //    _vc.alpha = 0.3;
    [_vc addGestureRecognizer:shadeTap];
    [self.view addSubview:_vc];
    

}
- (void)shadeTapClick {

//    [_vc removeFromSuperview];

}











#pragma mark --- <展览 空间>
- (void)createFilterView {
    self.titleArray = @[@"展览",@"场馆",@"展览",@"场馆"];
    self.filterView = [VTFilterView createHeaderViewWithTitleArray:self.titleArray callBack:^(NSInteger didSelectIndex) {
        
        NSLog(@"当前点击的是----%@",self.titleArray[didSelectIndex]);
        if (didSelectIndex == 0) {
            if (self.spaceTableView) {
                [self.spaceTableView removeFromSuperview];
            }
            [self createFairTableView];
        }else {
            [self.fairTableView removeFromSuperview];
            [self createSpaceTableView];
        }
    }];
    self.filterView.frame = CGRectMake(0, 64, ScreenWidth, 50);
    [self.view addSubview:self.filterView];
}


#pragma mark ============= 同城 展览的tableView ===========
- (void)createFairTableView {
    self.fairTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 114, ScreenWidth, ScreenHeight - 114) style:(UITableViewStylePlain)];
    self.fairTableView.delegate = self;
    self.fairTableView.dataSource = self;
    [self.view addSubview:self.fairTableView];
 
    [self.fairTableView registerNib:[UINib nibWithNibName:@"VTFairTableViewCell" bundle:nil] forCellReuseIdentifier:@"FairCell"];
}
#pragma mark ============= 同城 空间的tableView ===========
- (void)createSpaceTableView {
    self.spaceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 114, ScreenWidth, ScreenHeight - 114) style:(UITableViewStylePlain)];
    self.spaceTableView.delegate = self;
    self.spaceTableView.dataSource = self;
    [self.view addSubview:self.spaceTableView];
    
    [self.spaceTableView registerNib:[UINib nibWithNibName:@"VTSpaceTableViewCell" bundle:nil] forCellReuseIdentifier:@"SpaceCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 100;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.fairTableView) {
        return 200;
    }
    else {
        return 76;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.fairTableView) {
        VTFairTableViewCell *fairCell = [tableView dequeueReusableCellWithIdentifier:@"FairCell" forIndexPath:indexPath];
        return fairCell;
    }
    else {
    VTSpaceTableViewCell *spaceCell = [tableView dequeueReusableCellWithIdentifier:@"SpaceCell" forIndexPath:indexPath];
   
        return spaceCell;
    }
}
@end
