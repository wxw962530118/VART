//
//  VTAusleseCollectionView.h
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/13.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VTAusleseCollectionView : UICollectionView
+(instancetype)initWithImagesArray:(NSArray *)imagesArr;
@property (nonatomic, strong) NSArray * imagesUrlArray;

@end
