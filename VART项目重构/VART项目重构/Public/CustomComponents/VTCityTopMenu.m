//
//  VTCityTopMenu.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/9.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTCityTopMenu.h"

@interface VTCityTopMenu ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView * imageView;

@property (nonatomic, strong) NSArray * titleArray;

@property (nonatomic, copy) cityTopMenuCallBack callBack;

@property (nonatomic, strong) UITableView * myTableView;

@end

@implementation VTCityTopMenu

+(instancetype )initWithTitleArray:(NSArray *)titleArray callBack:(cityTopMenuCallBack)callBack{
    VTCityTopMenu * view = [[VTCityTopMenu alloc]initWithTitleArray:titleArray callBack:callBack];
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
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0;
   // [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideTopMenuView)]];
    [self.myTableView reloadData];
    [self addSubview:self.imageView];
}

-(UITableView *)myTableView{
    if (_myTableView == nil) {
       _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,10, self.imageView.width, self.imageView.height) style:(UITableViewStylePlain)];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [self.imageView addSubview:_myTableView];
    }
    return _myTableView;
}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,150,200)];
        _imageView.image = [UIImage imageNamed:@"WXWImage"];
        _imageView.userInteractionEnabled = YES;
        _imageView.layer.cornerRadius = 10;
        _imageView.clipsToBounds = YES;
        _imageView.centerX = ScreenWidth/2;
       //_imageView.transform = CGAffineTransformMakeScale(.1, .1);
       _imageView.layer.anchorPoint = CGPointMake(self.centerX,0);
    }
    return _imageView;
}

-(void)showTopMenuView{
    self.alpha = .6f;
   // self.imageView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //self.imageView.height = 200;
        self.imageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            self.imageView.transform = CGAffineTransformIdentity;
//        } completion:nil];
    }];
}

-(void)hideTopMenuView{
    [UIView animateWithDuration:.5f animations:^{
        self.alpha = 0;
        self.imageView.transform = CGAffineTransformIdentity;
        //self.imageView.height = 0;
        //self.imageView.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
    
    }];
}

//- (void)topMenuRowText:(NSArray *)rowText topView:(UIView *)topView {
// 
//    
//    
//    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, topView.frame.size.width, topView.frame.size.height)];
//    self.imageView.image = [UIImage imageNamed:@"WXWImage"];
//    [self addSubview:self.imageView];
//    
//
//    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 20, self.imageView.frame.size.width - 20, self.imageView.frame.size.height - 30) style:(UITableViewStylePlain)];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    _textArray = rowText;
//    [self.imageView addSubview:tableView];
//    
//    
//
//}
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:nil];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self hideTopMenuView];
    self.callBack(indexPath.row);
}









@end
