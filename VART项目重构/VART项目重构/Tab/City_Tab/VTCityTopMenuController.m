//
//  VTCityTopMenuController.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/9.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTCityTopMenuController.h"

@interface VTCityTopMenuController ()<UITableViewDelegate,UITableViewDataSource>

/**imageView*/
@property (nonatomic, strong) UIImageView *imageView;
/**<#注释#>*/
@property (nonatomic, strong) NSArray *textArray;
/**<#注释#>*/
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation VTCityTopMenuController

- (void)containerViewWillLayoutSubviews {
    
  
    
}

////重置本控制器的大小
//-(CGSize)preferredContentSize{
//    
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(200, 200);
    _textArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"1",@"2",@"3",@"4",@"5",@"6"];
    self.view.backgroundColor = [UIColor redColor];
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.image = [UIImage imageNamed:@"WXWImage"];
    [self.view addSubview:self.imageView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 20, self.imageView.frame.size.width - 20, self.imageView.frame.size.height - 30) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.imageView addSubview:self.tableView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _textArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:nil];
    cell.textLabel.text = _textArray[indexPath.row];
    return cell;
}
@end
