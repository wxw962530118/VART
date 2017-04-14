//
//  VTWaterfallLayout.h
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/14.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VTWaterfallLayout;
@protocol VTWaterfallLayoutDelegate <NSObject>

- (CGFloat)flowLayout:(VTWaterfallLayout *)flowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end

@interface VTWaterfallLayout : UICollectionViewLayout
// 每次布局之前的准备
- (void)prepareLayout;

// 返回所有的尺寸
- (CGSize)collectionViewContentSize;

// 返回indexPath这个位置Item的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;

// 返回rect范围内的布局属性
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect;

/** 列间距 */
@property(nonatomic,assign)CGFloat columnMargin;
/** 行间距 */
@property(nonatomic,assign)CGFloat rowMargin;
/** 列数 */
@property(nonatomic,assign)int columnsCount;
/** 外边距 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;

@property (nonatomic, weak) id<VTWaterfallLayoutDelegate> delegate;
@end
