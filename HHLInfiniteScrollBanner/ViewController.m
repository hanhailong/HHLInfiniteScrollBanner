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
@property (nonatomic,strong) UITableView *mTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"无限自动滚动Banner";
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupTableView];
    
    [self setUpInfiniteScrollView];
    
}

- (void)setupTableView{
    self.mTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        //
//        tableView.
        
        [self.view addSubview:tableView];
        tableView;
    });
    
    //添加下拉刷新
    self.mTableView.header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    [self.mTableView.header beginRefreshing];
}

- (void)refreshData{
    //延迟3秒
    [self performSelector:@selector(finishRefresh) withObject:self afterDelay:3.0];
}

- (void)finishRefresh{
    [self.mTableView.header endRefreshing];
}

- (void)setUpInfiniteScrollView{
    self.mBannerVC.view.bounds = CGRectMake(0, 0, ScreenWidth, BannerHeight);
    self.mBannerVC.view.backgroundColor = [UIColor redColor];
    self.mTableView.tableHeaderView = self.mBannerVC.view;
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"TableView_Cell_Id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = @"你好啊";
    
    return cell;
}

@end
