//
//  LoopScrollView.m
//  封装轮播图
//
//  Created by 王新伟 on 17/3/27.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "LoopScrollView.h"
#import "UIImageView+WebCache.h"
//最大图片个数
static int const ImageViewCount = 3;

@interface  LoopScrollView () <UIScrollViewDelegate>

@property (nonatomic,copy) LoopScrollViewCallBack callBackIndex;

@property (nonatomic,strong) NSMutableArray * imagesArray;

@property (nonatomic,strong) UIScrollView * scrollView;

@property (nonatomic,strong) UIPageControl * loopPageControl;

@property (nonatomic, weak) NSTimer * timer;

@property (assign, nonatomic, getter=isScrollDirectionPortrait) BOOL scrollDirectionPortrait;

@property (nonatomic,strong)UILabel  * titleLabel;

@end

@implementation LoopScrollView

+(instancetype )createWithImageArr:(NSArray *)arr scrollDirection:(ScrollDirectionType )type callBack:(LoopScrollViewCallBack )callBack {
    LoopScrollView * view = [[LoopScrollView alloc]initWithImageArr:arr scrollDirection:type callBack:callBack];
    return view;
}

-(instancetype )initWithImageArr:(NSArray *) arr scrollDirection:(ScrollDirectionType )type callBack:(LoopScrollViewCallBack )callBack {
    self = [self init];
    if (self) {
        self.imagesArray = [NSMutableArray arrayWithArray:arr];
        self.loopPageControl.numberOfPages = self.imagesArray.count;
        self.callBackIndex = callBack;
        self.scrollDirectionPortrait = type;
        // 设置内容
        [self updateContent];
        // 开始定时器
        [self startTimer];
    }
    return self;
}


-(instancetype )init{
    self = [super init];
    if (self) {
        // 滚动视图
        [self addScrollView];
        // 图片控件
        [self addLoopImageView];
        // 添加页码视图
        [self addLoopPageControl];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    if (self.isScrollDirectionPortrait) {
        self.scrollView.contentSize = CGSizeMake(0, ImageViewCount * self.bounds.size.height);
    } else {
        self.scrollView.contentSize = CGSizeMake(ImageViewCount * self.bounds.size.width, 0);
    }
    for (int i = 0; i< ImageViewCount; i++) {
        UIImageView * imageView = self.scrollView.subviews[i];
        if (self.isScrollDirectionPortrait) {
            imageView.frame = CGRectMake(0, i * self.scrollView.frame.size.height, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        } else {
            imageView.frame = CGRectMake(i * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        }
    }
    CGFloat pageW = 80;
    CGFloat pageH = 20;
    CGFloat pageX = self.scrollView.frame.size.width - pageW;
    CGFloat pageY = self.scrollView.frame.size.height - pageH;
    self.loopPageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
}


#pragma mark - 内容更新
- (void)updateContent{
    // 设置图片
    for (int i = 0; i < self.scrollView.subviews.count; i++) {
        UIImageView * imageView = self.scrollView.subviews[i];
        imageView.userInteractionEnabled = YES;
        NSInteger index = self.loopPageControl.currentPage;
        if (i == 0) {
            index--;
        } else if (i == 2) {
            index++;
        }
        if (index < 0) {
            index = self.loopPageControl.numberOfPages - 1;
        } else if (index >= self.loopPageControl.numberOfPages) {
            index = 0;
        }
        imageView.tag = index;
        //NSLog(@"index--%ld",index);
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageDidClick:)]];
        NSString * imageStr = self.imagesArray[index];
        if([imageStr rangeOfString:@"http://"].location !=NSNotFound){
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
        }else{
            imageView.image = [UIImage imageNamed:imageStr];
        }
    }
    if (self.isScrollDirectionPortrait) {
        [self.scrollView setContentOffset:CGPointMake(0,self.scrollView.frame.size.height) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:YES];
    }
}

#pragma mark --- 定时器处理
- (void)startTimer{
    NSTimer * timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)next{
    if (self.isScrollDirectionPortrait) {
        [self.scrollView setContentOffset:CGPointMake(0, 2 * self.scrollView.frame.size.height) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(2 * self.scrollView.frame.size.width, 0) animated:YES];
    }
}

#pragma mark ---  <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 找出最中间的那个图片控件
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    for (int i = 0; i < self.scrollView.subviews.count; i++) {
        UIImageView * imageView = self.scrollView.subviews[i];
        CGFloat distance = 0;
        if (self.isScrollDirectionPortrait) {
            distance = ABS(imageView.frame.origin.y - scrollView.contentOffset.y);
        } else {
            distance = ABS(imageView.frame.origin.x - scrollView.contentOffset.x);
        }
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;
        }
    }
   // NSLog(@"wxwPage---%ld",page);
    self.loopPageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self updateContent];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self updateContent];
}

#pragma mark --- 图片的点击事件
-(void)imageDidClick:(UITapGestureRecognizer *)tap{
    self.callBackIndex([tap view].tag);
}

-(void)addLoopImageView{
    for (int i = 0; i < ImageViewCount; i++) {
        UIImageView * imageView= [[UIImageView alloc] init];
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollView addSubview:imageView];
    }
}

-(void)addScrollView{
    if (self.scrollView == nil) {
        UIScrollView * scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
    }
}

-(void)addLoopPageControl{
    if (self.loopPageControl == nil){
        UIPageControl * pageControl = [[UIPageControl alloc] init];
        pageControl.currentPage = 0;
        [self addSubview:pageControl];
        self.loopPageControl = pageControl;
    }
}

@end
