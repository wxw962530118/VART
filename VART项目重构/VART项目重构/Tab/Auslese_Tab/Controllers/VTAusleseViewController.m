//
//  VTAusleseViewController.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/8.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTAusleseViewController.h"
#import "VTAusleseHeaderView.h"
#import "VTAusleseCell.h"
#import "VTAusleseModel.h"
#import "VTAusleseImageModel.h"
#import "VTExhibitionDetailsController.h"
@interface VTAusleseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * ausleseTableView;

@property (nonatomic, strong) NSMutableArray <NSURL *> * originalImageUrls;

@property (nonatomic, strong) VTAusleseHeaderView * ausleseHeaderView;

@property (nonatomic, strong) NSMutableArray <VTAusleseModel *> * dataArray;

@property (nonatomic, strong) NSArray * dateArray;

@end

@implementation VTAusleseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareLoopData];
    [self prepareDataSource];
    [self createTableView];
}

-(void)prepareLoopData{
    //创建轮播图数据
    self.originalImageUrls  = [NSMutableArray array];
    [self.originalImageUrls addObject:[NSURL URLWithString:@"http://ww3.sinaimg.cn/large/006ka0Iygw1f6bqm7zukpj30g60kzdi2.jpg"]];
    [self.originalImageUrls addObject:[NSURL URLWithString:@"http://ww1.sinaimg.cn/large/61b69811gw1f6bqb1bfd2j20b4095dfy.jpg"]];
    [self.originalImageUrls addObject:[NSURL URLWithString:@"http://ww1.sinaimg.cn/large/54477ddfgw1f6bqkbanqoj20ku0rsn4d.jpg"]];
    [self.originalImageUrls addObject:[NSURL URLWithString:@"http://ww4.sinaimg.cn/large/006ka0Iygw1f6b8gpwr2tj30bc0bqmyz.jpg"]];
    [self.originalImageUrls addObject:[NSURL URLWithString:@"http://ww2.sinaimg.cn/large/9c2b5f31jw1f6bqtinmpyj20dw0ae76e.jpg"]];
}

-(void)prepareDataSource{
    /**假数据*/
    self.dateArray = @[@"今日推荐",@"2017.04.13 星期五",@"2017.04.12 星期四",@"2017.04.11 星期三",@"2017.04.10 星期二"];
    self.dataArray = [NSMutableArray array];
    NSArray * typeArr = @[@(0),@(0),@(1),@(0),@(1)];
    NSArray * tagsArr = @[@"阅读",@"展览",@"作品",@"展览",@"作品"];
    NSArray * titleArr = @[@"这是阅读啊",@"这是展览啊",@"这是作品啊",@"这是展览啊",@"这是作品啊"];
    NSArray * contentArr = @[@"阅读阅读阅读阅读啦阅读阅读阅读阅读啦阅读阅读阅读阅读啦阅读阅读阅读阅读啦阅读阅读阅读阅读啦阅读阅读阅读阅读啦",@"展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦",@"作品作品作品作品作品作品作品作品作品作品作品作品作品作品作品作品作品作品作品作品",@"展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦展览啦",@""]; 
    NSMutableDictionary * mulDict = [NSMutableDictionary dictionary];
    for (int i = 0; i< tagsArr.count; i++) {
        [mulDict setValue:tagsArr[i] forKey:@"tags"];
        [mulDict setValue:contentArr[i] forKey:@"content"];
        [mulDict setValue:titleArr[i] forKey:@"title"];
        [mulDict setValue:self.originalImageUrls forKey:@"imagesArray"];
        [mulDict setValue:self.originalImageUrls[i] forKey:@"urlStr"];
        [mulDict setObject:typeArr[i] forKey:@"type"];
        [self.dataArray addObject:[VTAusleseModel objectWithKeyValues:mulDict]];
    }
    [self.ausleseTableView reloadData];

}

-(VTAusleseHeaderView *)ausleseHeaderView{
    if (_ausleseHeaderView == nil) {
        _ausleseHeaderView = [VTAusleseHeaderView createHeaderViewWithImageUrlArray:self.originalImageUrls];
        _ausleseHeaderView.frame = CGRectMake(0,0, ScreenWidth,200);
    }
    return _ausleseHeaderView;
}

-(void)createTableView{
    self.ausleseTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.ausleseTableView.showsVerticalScrollIndicator = NO;
    self.ausleseTableView.delegate = self;
    self.ausleseTableView.dataSource = self;
    self.ausleseTableView.backgroundColor = [UIColor whiteColor];
    self.ausleseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.ausleseTableView];
    self.ausleseTableView.tableHeaderView = self.ausleseHeaderView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VTAusleseCell * cell = [VTAusleseCell cellWithTableView:tableView];
    cell.backgroundColor = [UIColor orangeColor];
    [cell setDataWithModel:self.dataArray[indexPath.section]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VTExhibitionDetailsController * detailVC = [[VTExhibitionDetailsController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(CGFloat )tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

-(CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor redColor];
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = self.dateArray[section];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    [headerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView.mas_centerX);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(headerView.mas_centerY);
    }];
    return headerView;
}

@end
