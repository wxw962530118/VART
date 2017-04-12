//
//  VTCityNavMenuView.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/12.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTCityNavMenuView.h"
#import "VTCityNavMenuContentModel.h"
#import "VTCityNavMenuContentCell.h"
@interface  VTCityNavMenuView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView * imageView;

@property (nonatomic, strong) NSArray <VTCityNavMenuContentModel *>* titleArray;

@property (nonatomic, copy) cityTopMenuCallBack callBack;

@property (nonatomic, strong) UITableView * myTableView;


@property (nonatomic, strong) UIButton * bgButton;

@property (nonatomic, strong)UIWindow * bgWindow;

@end

@implementation VTCityNavMenuView

+(instancetype )initWithTitleArray:(NSArray *)titleArray callBack:(cityTopMenuCallBack)callBack{
    VTCityNavMenuView * view = [[VTCityNavMenuView alloc]initWithTitleArray:titleArray callBack:callBack];
    return view;
}

-(instancetype )initWithTitleArray:(NSArray *)titleArray callBack:(cityTopMenuCallBack)callBack{
    self = [super init];
    if (self){
        self.callBack = callBack;
        self.titleArray = titleArray;
        [self addSubViews];
    }
    return self;
}

-(void)addSubViews{
    [self.myTableView reloadData];
    [self.bgWindow addSubview:self.bgButton];
    [self.bgWindow addSubview:self.imageView];
}

-(UIWindow *)bgWindow{
    if (_bgWindow == nil) {
        _bgWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _bgWindow.backgroundColor = [UIColor clearColor];
        _bgWindow.alpha  = 0;
        _bgWindow.hidden = NO;
    }
    return _bgWindow;
}

-(UIButton *)bgButton{
    if (_bgButton == nil) {
        _bgButton = [[UIButton alloc]init];
        [_bgButton addTarget:self action:@selector(hideTopMenuView) forControlEvents:UIControlEventTouchUpInside];
        _bgButton.backgroundColor = [UIColor clearColor];
        _bgButton.frame = self.bgWindow.bounds;
    }
    return _bgButton;
}


-(UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.layer.cornerRadius = 8;
        _myTableView.clipsToBounds = YES;
        _myTableView.showsVerticalScrollIndicator = false;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [self.imageView addSubview:_myTableView];
        [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.imageView).width.insets(UIEdgeInsetsMake(20,0,0, 0));
        }];
    }
    return _myTableView;
}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,56,120,0)];
        UIImage * image = [UIImage imageNamed:@"top_dialog_bg"];
        // 左端盖宽度
        NSInteger leftCapWidth = image.size.width * 0.5f;
        // 顶端盖高度
        NSInteger topCapHeight = image.size.height * 0.5f;
        // 重新赋值
        image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
        _imageView.image = image;
        _imageView.userInteractionEnabled = YES;
        _imageView.centerX = ScreenWidth/2;
        _imageView.layer.anchorPoint = CGPointMake(0.5,0);
    }
    return _imageView;
}

-(void)showTopMenuView{
    self.imageView.height = 200;
    self.bgWindow.alpha = 1;
    self.imageView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    [UIView animateWithDuration:.5f animations:^{
        self.imageView.transform = CGAffineTransformMakeScale(1,1);
    }];
}

-(void)hideTopMenuView{
    [UIView animateWithDuration:.5f animations:^{
        self.bgWindow.alpha = 0;
        self.imageView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    } completion:^(BOOL finished) {
        self.imageView.transform = CGAffineTransformIdentity;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VTCityNavMenuContentCell * cell = [VTCityNavMenuContentCell cellWithTableView:tableView];
    [cell setDataWithModel:self.titleArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self hideTopMenuView];
    self.callBack(indexPath.row);
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [VTCityNavMenuContentCell getCellHeightWithModel:self.titleArray[indexPath.row]];
}

@end
