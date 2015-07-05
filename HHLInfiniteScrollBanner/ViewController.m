//
//  ViewController.m
//  HHLInfiniteScrollBanner
//
//  Created by HailongHan on 15/7/5.
//  Copyright (c) 2015年 HHL. All rights reserved.
//

#import "ViewController.h"
#import "InfiniteScrollViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) InfiniteScrollViewController *mBannerVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpInfiniteScrollView];
    
}

- (void)setUpInfiniteScrollView{
    self.mBannerVC.view.frame = CGRectMake(0, 0, ScreenWidth, BannerHeight);
    self.mBannerVC.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.mBannerVC.view];
}

//懒加载
-(InfiniteScrollViewController *)mBannerVC{
    if (!_mBannerVC) {
        _mBannerVC = [InfiniteScrollViewController new];
        [self addChildViewController:_mBannerVC];
    }
    return _mBannerVC;
}

#pragma mark - UITableView Delegate


@end
