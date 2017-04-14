//
//  VTAusleseCollectionView.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/13.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTAusleseCollectionView.h"
#import "VTAusleseCollectionViewCell.h"
@interface VTAusleseCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray * imagesArray;
@end

@implementation VTAusleseCollectionView

+(instancetype )initWithImagesArray:(NSArray *)imagesArr{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //水平滑动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 5;
    VTAusleseCollectionView * collectionView = [[VTAusleseCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    return collectionView;
}


-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.imagesArray = [NSMutableArray array];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self registerClass:[VTAusleseCollectionViewCell class] forCellWithReuseIdentifier:@
         "VTAusleseCollectionViewCell"];
    }
    return self;
}

-(void)setImagesUrlArray:(NSArray *)imagesUrlArray{
    _imagesUrlArray = imagesUrlArray;
    self.imagesArray = [imagesUrlArray copy];
    [self reloadData];
}

#pragma mark -- UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(130, 150);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0.001, 5, 0.001,5);
}

#pragma mark- UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imagesArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VTAusleseCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VTAusleseCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    cell.urlStr = self.imagesArray[indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDidSelect
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"当前点击的图片Index--%ld",indexPath.item);
}


@end
