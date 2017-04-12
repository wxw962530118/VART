//
//  VTCityNavMenuContentCell.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/12.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTCityNavMenuContentCell.h"
@interface VTCityNavMenuContentCell ()

@property (nonatomic, strong) UILabel * titleLbel;

@property (nonatomic, strong) UIView * lineView;

@end

@implementation VTCityNavMenuContentCell

-(void)loadWithComponents{
    self.backgroundColor = [UIColor clearColor];
    [self addLineView];
    [self addTitleLbel];
}

-(void)addTitleLbel{
    if (!_titleLbel) {
        _titleLbel = [[UILabel alloc]init];
        _titleLbel.font = [UIFont systemFontOfSize:15];
        _titleLbel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLbel];
        [_titleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
    }
}

-(void)addLineView{
    if (!_lineView) {
        _lineView = [[UILabel alloc]init];
        _lineView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.height.mas_equalTo(.5f);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
}

-(void)setDataWithModel:(VTCityNavMenuContentModel *)model{
    _titleLbel.text =  model.title;
}

+(CGFloat )getCellHeightWithModel:(VTBaseModel *)model{
    return 40;
}


@end
