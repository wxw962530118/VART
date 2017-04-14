//
//  VTSearchBar.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/14.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTSearchBar.h"

@interface VTSearchBar ()<UITextFieldDelegate>

@property (nonatomic, assign) VTSearchBarSelectionStyle style;

@property (nonatomic, copy) void(^clickAction)();


@end

@implementation VTSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _style = VTSearchBarSelectionStyleInput;
        self.font = [UIFont systemFontOfSize:14];
        self.placeholder = @"搜索你想要的";
        [self setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        // 通过init来创建初始化绝大部分控件，控件都是没有尺寸
        UIView *backSearchIconView = [[UIView alloc] init];
        backSearchIconView.width = (42);
        backSearchIconView.height = (28);
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"search"];
        [backSearchIconView addSubview:searchIcon];
        [searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backSearchIconView.mas_left).offset(12);
            make.centerY.equalTo(backSearchIconView.mas_centerY);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(22);
        }];
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = backSearchIconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.textColor = [UIColor lightGrayColor];
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 4.f;   // 设置圆角和边框
        self.layer.masksToBounds = YES;
        self.layer.borderColor= [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = .6f;
        self.delegate = self;
        
    }
    return self;
}

- (void)setSelectionStyle:(VTSearchBarSelectionStyle)style{
    _style = style;
}

- (void)setClickAction:(void (^)())clickAction{
    _clickAction = clickAction;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (_style == VTSearchBarSelectionStyleClick && _clickAction) _clickAction();
    return _style == VTSearchBarSelectionStyleInput;
}

+ (instancetype)searchBar{
    NSLog(@"++++++++%@",[[self alloc] init]);
    return [[self alloc] init];
}


@end
