//
//  VTCityTopMenu.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/9.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTCityTopMenu.h"

@interface VTCityTopMenu ()<UITableViewDelegate,UITableViewDataSource>

/**imageView*/
@property (nonatomic, strong) UIImageView *imageView;
/**<#注释#>*/
@property (nonatomic, strong) NSArray *textArray;
@end

@implementation VTCityTopMenu


- (void)topMenuRowText:(NSArray *)rowText topView:(UIView *)topView {
 
    
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, topView.frame.size.width, topView.frame.size.height)];
    self.imageView.image = [UIImage imageNamed:@"WXWImage"];
    [self addSubview:self.imageView];
    

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 20, self.imageView.frame.size.width - 20, self.imageView.frame.size.height - 30) style:(UITableViewStylePlain)];
    tableView.delegate = self;
    tableView.dataSource = self;
    _textArray = rowText;
    [self.imageView addSubview:tableView];
    
    

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
