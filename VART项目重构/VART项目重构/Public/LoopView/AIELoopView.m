//
//  AIELoopView.m
//  图片轮播器
//
//  Created by BrianLee on 16/4/7.
//  Copyright © 2016年 BrianLee. All rights reserved.
//

#import "AIELoopView.h"
#import "AIELoopViewLayout.h"
#import "AIELoopViewCell.h"
#define LoopCellKey @"loopcell"

@interface AIELoopView() <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic) NSArray <NSURL *> *urls;
@property (nonatomic, copy) void (^didSelectedCallBack)(NSInteger);

///  当前显示索引
@property (nonatomic, assign) NSUInteger currentIndex;
///  定时器
@property (nonatomic, strong) NSTimer *timer;
///  页控件
@property (nonatomic, strong) UIPageControl * pageControl;

@end

@implementation AIELoopView

- (instancetype)initWithURLs:(NSArray <NSURL *> *)urls didSelected:(void (^)(NSInteger))didSelected {
    
    self = [super initWithFrame:CGRectZero collectionViewLayout:[[AIELoopViewLayout alloc] init]];
    
    if (self) {
        self.urls = urls;
        self.didSelectedCallBack = didSelected;
        
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[AIELoopViewCell class] forCellWithReuseIdentifier:LoopCellKey];
        
        // 判断图片数量，如果 > 1，将图片设置到数组的1倍的位置
        // exp：如果有3张图(0,1,2)，初始显示第 `3` 张图
        
        // 主队列异步，会在数据源方法执行之后，在执行 block 中的任务
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.urls.count > 1) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.urls.count inSection:0];
                
                [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            }
        });
    }
    
    return self;
}

-(void)didMoveToWindow{
    [super didMoveToWindow];
    self.backgroundColor = [UIColor whiteColor];
    if (self.urls.count > 1) {
        self.pageControl.numberOfPages = self.urls.count;
    }
    [self startTimer];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.superview addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(ScreenWidth);
    }];
}

#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 如果是1张图片，不需要滚动
    return self.urls.count * (self.urls.count == 1 ? 1 : 1000);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AIELoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LoopCellKey forIndexPath:indexPath];
    
    cell.url = self.urls[indexPath.row % self.urls.count];
    
    return cell;
}

#pragma mark - 代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger offset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    // 判断是否是第一页或者最后一页
    if (offset == 0 || offset == ([self numberOfItemsInSection:0] - 1)) {
        NSLog(@"%zd", offset);
        // 0 -> 3 url.count ||| 5 -> 2 url.count - 1
        offset = self.urls.count - (offset == 0 ? 0 : 1);
        
        // 设置 contentOffset
        scrollView.contentOffset = CGPointMake(offset * scrollView.bounds.size.width, 0);
    }
    
}


-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    self.pageControl.currentPage = [collectionView indexPathForCell:collectionView.visibleCells.lastObject].row%self.urls.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%zd", indexPath.item % self.urls.count);
    if (self.didSelectedCallBack != nil) {
        self.didSelectedCallBack(indexPath.item % self.urls.count);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

#pragma mark - 定时器控制
///  启动定时器
- (void)startTimer {
    if (self.urls.count <= 1 || self.timer != nil) {
        return;
    }
    
    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)updateTimer {
    // 取出当前显示的 indexPath
    NSIndexPath *indexPath = [self indexPathsForVisibleItems].lastObject;
    indexPath = [NSIndexPath indexPathForItem:(indexPath.item + 1)%1001 inSection:indexPath.section];
    
    // 滚动到下一个页面
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    // 动画结束后调用滚动停止方法
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self scrollViewDidEndDecelerating:self];
    });
}

-(UIPageControl *)pageControl{
    if (_pageControl == nil) {
        UIPageControl *pageCtrl = [[UIPageControl alloc]init];
        pageCtrl.currentPageIndicatorTintColor = [UIColor blackColor];
        pageCtrl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl = pageCtrl;
    }
    return _pageControl;
}

@end
