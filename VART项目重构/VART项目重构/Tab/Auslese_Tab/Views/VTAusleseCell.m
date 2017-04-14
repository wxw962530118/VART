//
//  VTAusleseCell.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/13.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTAusleseCell.h"
#import "VTAusleseModel.h"
#import "VTAusleseCollectionView.h"
@interface VTAusleseCell ()
/**大图*/
@property (nonatomic, strong) UIImageView * bigImageView;
/**标签*/
@property (nonatomic, strong) UIButton * tagsButton;
/**标题*/
@property (nonatomic, strong) UILabel * titleLabel;
/**内容*/
@property (nonatomic, strong) UILabel * contentLabel;
/**用户头像*/
@property (nonatomic, strong) UIImageView * userImageView;
/**用户名称*/
@property (nonatomic, strong) UILabel * userNameLabel;
/**展示作品的滚动视图*/
@property (nonatomic, strong) VTAusleseCollectionView * collectionView;
/**cell上面区分的内容*/
@property (nonatomic, strong) UIView * cellContentView;

@end

@implementation VTAusleseCell

-(void)loadWithComponents{
    [self addCellContentView];
    [self addBigImageView];
    [self addCollectionView];
    [self addTagsButton];
    [self addTitleLabel];
    [self addContentLabel];
    [self addUserImageView];
    [self addUserNameLabel];
}

-(void)addCellContentView{
    if (!_cellContentView) {
        _cellContentView = [[UIView alloc]init];
        _cellContentView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_cellContentView];
        [_cellContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.width.mas_equalTo(ScreenWidth);
            make.height.mas_equalTo(100);
        }];
    }
}

-(void)addUserNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc]init];
        _userNameLabel.text = @"李大拿";
        _userNameLabel.font = [UIFont systemFontOfSize:12];
        _userNameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_userNameLabel];
        [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userImageView.mas_right).offset(10);
            make.centerY.equalTo(self.userImageView.mas_centerY);
        }];
    }
}

-(void)addUserImageView{
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc]init];
        _userImageView.clipsToBounds = YES;
        _userImageView.layer.cornerRadius = 22;
        [self.contentView addSubview:_userImageView];
        [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.width.height.mas_equalTo(44);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
    }
}

-(void)addTitleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tagsButton.mas_right).offset(10);
            make.centerY.equalTo(self.tagsButton.mas_centerY);
        }];
    }

}

-(void)addTagsButton{
    if (!_tagsButton) {
        _tagsButton = [[UIButton alloc]init];
        [_tagsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _tagsButton.layer.cornerRadius = 3;
        _tagsButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_tagsButton setBackgroundColor:[UIColor blueColor]];
        [self.contentView addSubview:_tagsButton];
        [_tagsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.top.equalTo(self.cellContentView.mas_bottom).offset(10);
            make.width.mas_equalTo(44);
            make.height.mas_equalTo(15);
        }];
    }
}

-(void)addContentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.top.equalTo(self.tagsButton.mas_bottom).offset(10);
        }];
    }
}

-(void)addBigImageView{
    if (!_bigImageView) {
        _bigImageView = [[UIImageView alloc]init];
        [self.cellContentView addSubview:_bigImageView];
        [_bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.cellContentView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
}

-(void)addCollectionView{
    if (!_collectionView) {
        _collectionView = [VTAusleseCollectionView initWithImagesArray:nil];
        [self.contentView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.cellContentView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
}

-(void)setDataWithModel:(VTAusleseModel *)model{
    if (model.type == AusleseContentType_Works) {
        self.collectionView.hidden = NO;
        self.collectionView.backgroundColor = [UIColor blueColor];
        self.collectionView.imagesUrlArray = model.imagesArray;
        self.bigImageView.hidden  = YES;
        [self.cellContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(130);
        }];
    }else{
        self.collectionView.hidden = YES;
        self.bigImageView.hidden  = NO;
        [self.bigImageView sd_setImageWithURL:model.urlStr placeholderImage:[ToolBaseClass imageWithColor:SCColor(114, 114, 114)]];
        CGFloat w = self.bigImageView.image.size.width;
        CGFloat h = self.bigImageView.image.size.height;
        CGFloat hw = h/w;
        CGFloat height = ScreenWidth * hw;
        [self.cellContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
    }
    [self.tagsButton setTitle:model.tags forState:UIControlStateNormal];
    [self.tagsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
    [self.userImageView sd_setImageWithURL:model.urlStr placeholderImage:[ToolBaseClass imageWithColor:SCColor(114, 114, 114)]];

}

@end
