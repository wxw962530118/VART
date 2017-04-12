//
//  VTPopPresentationController.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/11.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTPopPresentationController.h"


@interface VTPopPresentationController ()
/**遮罩*/
@property (nonatomic, strong) UIView *share;

@end


@implementation VTPopPresentationController
   
    
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {

   return  [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    
}
    
- (void)containerViewWillLayoutSubviews {

    self.presentedView.frame = CGRectMake(100, 64, ScreenWidth - 200, 300);
    
    [self.containerView insertSubview:self.share atIndex:0];
}

- (UIView *)share {
    if (!_share) {
        _share = [[UIView alloc] init];
        _share.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        _share.frame = [UIScreen mainScreen].bounds;
        UITapGestureRecognizer *shadeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shadeTapClick)];
        //轻拍次数
        shadeTap.numberOfTapsRequired =1;
        //轻拍手指个数
        shadeTap.numberOfTouchesRequired =1;
        [_share addGestureRecognizer:shadeTap];
    }

    return _share;

}
    
- (void)shadeTapClick {
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
        
}
   
    
    
@end
