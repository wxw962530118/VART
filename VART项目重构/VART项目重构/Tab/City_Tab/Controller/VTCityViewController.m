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
#import "VTCityTopMenuController.h"
#import "VTCityNavMenuView.h"
#import "VTCityNavMenuContentModel.h"
@interface VTCityViewController ()<UITableViewDelegate,UITableViewDataSource>
/**导航栏的菜单文字模型数组*/
@property (nonatomic, strong) NSMutableArray<VTCityNavMenuContentModel *> * titleArray;
/**展览*/
@property (nonatomic, strong) UITableView * leftTableView;
/**同城*/
@property (nonatomic, strong) UITableView * rightTableView;
/**筛选头*/
@property (nonatomic, strong) VTFilterView * filterView;
/**导航栏的菜单*/
@property (nonatomic, strong) VTCityNavMenuView * navMenuView;
/**导航栏的按钮*/
@property (nonatomic, strong) UIButton * titleBtn;
/**筛选的文字数组*/
@property (nonatomic, strong) NSArray * filterArray;

@end

@implementation VTCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTitleView];
    [self createFilterView];
    
    [self createNavMenuView];
    [self createTableView];
}

- (void)createTitleView {
    self.titleArray = [NSMutableArray array];
    NSArray * textArr = @[@"热门",@"附近",@"语音导览",@"睡前听展",@"即将开始",@"即将结束",@"已结束"];
    NSMutableDictionary * mulDic = [NSMutableDictionary dictionary];
    for (int i = 0; i < textArr.count; i++) {
        [mulDic setValue:textArr[i] forKey:@"title"];
        [self.titleArray addObject:[VTCityNavMenuContentModel objectWithKeyValues:mulDic]];
    }
    self.titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,80, 30)];
    [self.titleBtn setTitle:@"热门" forState:(UIControlStateNormal)];
    [self.titleBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.titleBtn addTarget:self action:@selector(titleBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.titleView = self.titleBtn;
}

-(void)createNavMenuView{
    self.navMenuView = [VTCityNavMenuView initWithTitleArray:self.titleArray callBack:^(NSInteger selectIndex) {
        [self.titleBtn setTitle:self.titleArray[selectIndex].title forState:UIControlStateNormal];
    }];
}

#pragma mark --- 导航栏按钮点击事件
- (void)titleBtnClick{
    [self.navMenuView showTopMenuView];
    
    
    
    
    
}

#pragma mark --- 懒加载控件
-(UITableView *)leftTableView{
    if (_leftTableView == nil) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.backgroundColor = [UIColor redColor];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
    }
    return _leftTableView;
}

-(UITableView *)rightTableView{
    if (_rightTableView == nil) {
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
         _rightTableView.backgroundColor = [UIColor greenColor];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
    }
    return _rightTableView;
}

#pragma mark --- 添加TableView
-(void)createTableView{
    [self.view addSubview:self.leftTableView];
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(114);
        make.height.mas_equalTo(ScreenHeight - 114);
    }];
    
    [self.view addSubview:self.rightTableView];
    [self.rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(114);
        make.height.mas_equalTo(ScreenHeight - 114);
    }];
}

#pragma mark --- 创建筛选头
- (void)createFilterView {
    self.filterArray = @[@"展览",@"同城"];
    self.filterView = [VTFilterView createHeaderViewWithTitleArray:self.filterArray callBack:^(NSInteger didSelectIndex) {
        if (!didSelectIndex) {
            self.rightTableView.hidden = YES;
            self.leftTableView.hidden = NO;
        }else {
            self.rightTableView.hidden = NO;
            self.leftTableView.hidden = YES;
        }
    }];
    self.filterView.frame = CGRectMake(0, 64, ScreenWidth, 50);
    [self.view addSubview:self.filterView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        return 200;
    }
    else {
        return 76;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        VTFairTableViewCell * cell = [VTFairTableViewCell cellWithTableViewFromXIB:tableView];
        return cell;
    }else {
        VTSpaceTableViewCell * cell = [VTSpaceTableViewCell cellWithTableViewFromXIB:tableView];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
