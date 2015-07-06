//
//  InfiniteScrollViewController.m
//  HHLInfiniteScrollBanner
//
//  Created by HailongHan on 15/7/5.
//  Copyright (c) 2015年 HHL. All rights reserved.
//

#define Cell_Id @"Cell_Id"
#define InfiniteScrollSectionCount 11
#define InfiniteScrollCenterSectionPosition (int)(InfiniteScrollSectionCount*0.5)

#import "InfiniteScrollViewController.h"
#import "InfiniteScrollCell.h"

@interface InfiniteScrollViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *mCollectionView;
@property (nonatomic,strong) UIPageControl *mPageControl;
@property (nonatomic,strong) NSTimer *mAutoScrollTimer;

@end

@implementation InfiniteScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addCollecitonView];
    
    [self addPageControl];
    
    //显示中间那一组
    if (self.dataList.count) {
        //中间那一组的第0个位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:InfiniteScrollCenterSectionPosition];
        [self.mCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    
    //添加NSTimer，让UICollectionView自己滚动
    [self addAutoScrollTimer];
}

//懒加载
-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
        [_dataList addObject:@"http://b.hiphotos.baidu.com/image/pic/item/622762d0f703918f292cabd4533d269759eec42b.jpg"];
        [_dataList addObject:@"http://d.hiphotos.baidu.com/image/pic/item/7acb0a46f21fbe096830b61569600c338744ad40.jpg"];
        [_dataList addObject:@"http://e.hiphotos.baidu.com/image/pic/item/94cad1c8a786c9174b58e25ecb3d70cf3bc75779.jpg"];
        [_dataList addObject:@"http://a.hiphotos.baidu.com/image/pic/item/42a98226cffc1e174a4d86304890f603728de9c5.jpg"];
        [_dataList addObject:@"http://c.hiphotos.baidu.com/image/pic/item/faedab64034f78f085ad2d947b310a55b3191c36.jpg"];
        [_dataList addObject:@"http://e.hiphotos.baidu.com/image/pic/item/29381f30e924b899e5d9823a6c061d950b7bf6cf.jpg"];
        [_dataList addObject:@"http://e.hiphotos.baidu.com/image/pic/item/0b55b319ebc4b7456f6d4d14cdfc1e178a821532.jpg"];
    }
    return _dataList;
}

#pragma mark - 添加UICollectionView

- (void)addCollecitonView {
    //先创建flowLayout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //item大小
    flowLayout.itemSize = CGSizeMake(ScreenWidth, BannerHeight);
    //滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //间距
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BannerHeight) collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    self.mCollectionView = collectionView;
    self.mCollectionView.delegate = self;
    self.mCollectionView.dataSource = self;
    
    //能够触发手指滚动
    self.mCollectionView.pagingEnabled = YES;
    self.mCollectionView.scrollEnabled = YES;
    
    //隐藏水平和竖向的滚动条
    self.mCollectionView.showsHorizontalScrollIndicator = NO;
    self.mCollectionView.showsVerticalScrollIndicator = NO;
    
    //设置contentSize
    self.mCollectionView.contentSize = CGSizeMake(self.dataList.count*ScreenWidth*InfiniteScrollSectionCount, 0);
    
    //注册
    [self.mCollectionView registerClass:[InfiniteScrollCell class] forCellWithReuseIdentifier:Cell_Id];
    
}

#pragma mark - 添加UIPageControl
- (void)addPageControl{
#warning 添加UIPageControl
    
}

/**
 *添加自动滚动计时器
 */
- (void)addAutoScrollTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.mAutoScrollTimer = timer;
}

//下一页
- (void)nextPage{
    if (self.dataList.count) {
        //获取当前的indexpath
        NSIndexPath *currentIndexPath = [[self.mCollectionView indexPathsForVisibleItems] lastObject];
        
        //重置当前的indexpath.section.item不变
        NSIndexPath *resetIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:InfiniteScrollCenterSectionPosition];
        
        //设置cell的显示位置
        [self.mCollectionView scrollToItemAtIndexPath:resetIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        
        //计算下一个要显示的位置
        NSInteger totalItemCount = self.dataList.count;
        NSInteger nextItem = currentIndexPath.item + 1;
        NSInteger nextSection = InfiniteScrollCenterSectionPosition;
        
        if (nextItem == totalItemCount) {
            //从头开始
            nextItem = 0;
            nextSection++;
        }
        
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
        //带动画滑动到下一页
        [self.mCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}

#pragma mark- UICollectionView DataSource Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return InfiniteScrollSectionCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    InfiniteScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_Id forIndexPath:indexPath];
    
    cell.url = [self.dataList objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}

#pragma mark - UIScrollView Delegate
//将要开始触摸拖拽，让定时器失效
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.mAutoScrollTimer invalidate];
    self.mAutoScrollTimer = nil;
}

//结束拖拽
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addAutoScrollTimer];
}

@end
