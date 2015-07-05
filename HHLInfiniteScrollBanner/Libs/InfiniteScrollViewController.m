//
//  InfiniteScrollViewController.m
//  HHLInfiniteScrollBanner
//
//  Created by HailongHan on 15/7/5.
//  Copyright (c) 2015年 HHL. All rights reserved.
//

#define Cell_Id @"Cell_Id"

#import "InfiniteScrollViewController.h"
#import "InfiniteScrollCell.h"

@interface InfiniteScrollViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *mCollectionView;

@end

@implementation InfiniteScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addCollecitonView];
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
    self.mCollectionView.contentSize = CGSizeMake(self.dataList.count*ScreenWidth, 0);
    
    //注册
    [self.mCollectionView registerClass:[InfiniteScrollCell class] forCellWithReuseIdentifier:Cell_Id];
    
}

#pragma mark- UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    InfiniteScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_Id forIndexPath:indexPath];
    
    cell.url = [self.dataList objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}

@end
