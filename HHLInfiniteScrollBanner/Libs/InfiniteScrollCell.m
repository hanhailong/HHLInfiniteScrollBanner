//
//  InfiniteScrollCell.m
//  HHLInfiniteScrollBanner
//
//  Created by HailongHan on 15/7/5.
//  Copyright (c) 2015年 HHL. All rights reserved.
//

#import "InfiniteScrollCell.h"
#import <UIImageView+WebCache.h>

@interface InfiniteScrollCell ()

@property (nonatomic,strong) UIImageView *mBgView;

@end

@implementation InfiniteScrollCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        //TODO 初始化
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        self.mBgView = imageView;
    }
    return self;
}

-(void)setUrl:(NSString *)url{
    _url = url;
    [self.mBgView bringSubviewToFront:self.contentView];
    [self.mBgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.mBgView.frame = self.bounds;
}

@end
