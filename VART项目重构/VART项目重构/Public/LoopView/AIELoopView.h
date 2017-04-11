//
//  AIELoopView.h
//  图片轮播器
//
//  Created by BrianLee on 16/4/7.
//  Copyright © 2016年 BrianLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AIELoopView : UICollectionView
- (instancetype)initWithURLs:(NSArray <NSURL *> *)urls didSelected:(void (^)(NSInteger index))didSelected;

@end
