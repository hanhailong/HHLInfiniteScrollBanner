//
//  InfiniteScroll-Prefix.h
//  HHLInfiniteScrollBanner
//
//  Created by HailongHan on 15/7/5.
//  Copyright (c) 2015年 HHL. All rights reserved.
//
#import <Availability.h>

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define BannerHeight ScreenHeight*0.4

#endif