//
//  VTAusleseCollectionViewCell.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/13.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTAusleseCollectionViewCell.h"
@interface VTAusleseCollectionViewCell ()

@property (nonatomic, strong) UIImageView * contentImageView;

@end

@implementation VTAusleseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 根据布局的cell大小初始化imageview大小
        self.contentImageView = [[UIImageView alloc] init];
        self.contentImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.contentImageView.clipsToBounds = YES;
        self.contentView.clipsToBounds = YES;
        [self.contentView addSubview:self.contentImageView];
        [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return self;
}

-(void)setUrlStr:(NSURL *)urlStr{
    _urlStr  = urlStr;
    [self.contentImageView sd_setImageWithURL:urlStr placeholderImage:[ToolBaseClass imageWithColor:SCColor(114, 114,114)]];
    CGFloat w = self.contentImageView.image.size.width;
    CGFloat h = self.contentImageView.image.size.height;
    CGFloat wh = w/h;
    CGFloat width = 150 * wh;
    // w/? = h/150
    [self.contentImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(width);
    }];
}

@end
