//
//  AIELoopViewLayout.m
//  图片轮播器
//
//  Created by BrianLee on 16/4/7.
//  Copyright © 2016年 BrianLee. All rights reserved.
//

#import "AIELoopViewLayout.h"

@implementation AIELoopViewLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    // 此方法被调用的时候 collectionView 的大小已经被设置完成
    self.itemSize = self.collectionView.bounds.size;
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

@end
