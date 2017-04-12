//
//  VTPopAnimate.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/12.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTPopAnimate.h"
#import "VTPopPresentationController.h"
@interface VTPopAnimate ()<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

/**当前菜单是否展开状态*/
@property (nonatomic, assign) BOOL isPresent;

@end



@implementation VTPopAnimate

- (instancetype)init {
    if (self == [super init]) {
        
    }
    return self;
}


- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0) {
    
    VTPopPresentationController *pop = [[VTPopPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    
    return pop;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPresent = YES;
    return self;
    
}
//消失
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresent = NO;
    return self;
    
}

//动画时长
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5;
}

//告诉系统如何动画
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    if (self.isPresent) {
        //展开是的操作
        UIView *toView = [transitionContext viewForKey:(UITransitionContextToViewKey)];
        toView.transform = CGAffineTransformMakeScale(1.0, 0.0);
        [transitionContext.containerView addSubview:toView];
        //设置锚点
        toView.layer.anchorPoint = CGPointMake(0.5, 0);
        
        [UIView animateWithDuration:0.5 animations:^{
            
            toView.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }else {
        //关闭时的操作
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        [UIView animateWithDuration:0.5 animations:^{
            
            fromView.transform = CGAffineTransformMakeScale(1.0, 0.00001);
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
            
        }];
    }
}

@end
