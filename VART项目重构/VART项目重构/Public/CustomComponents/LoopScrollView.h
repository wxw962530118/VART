//
//  LoopScrollView.h
//  封装轮播图
//
//  Created by 王新伟 on 17/3/27.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger ,ScrollDirectionType){
    SCROLLDIRECTIONTYPE_HORIZONTAL, //横向
    SCROLLDIRECTIONTYPE_VERTICAL,  //纵向
};

typedef void (^LoopScrollViewCallBack) (NSInteger selectIndex);

@interface LoopScrollView : UIView

/**
 *  创建轮播图
 *  @param arr      图片数组<本地及网络图片>
 *  @param callBack 点击回调
 */

+(instancetype )createWithImageArr:(NSArray *)arr scrollDirection:(ScrollDirectionType )type callBack:(LoopScrollViewCallBack )callBack;

@end
