//
//  WLCTabBar.h
//  weibo
//
//  Created by 王 on 16/2/18.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLCTabBar;
@protocol WLCtabBarDelegate <NSObject, UITabBarDelegate>

- (void)tabBar: (WLCTabBar *)tabBar didSelectComposeBtn: (UIButton *)composeBtn;

@end

@interface WLCTabBar : UITabBar

@property (weak, nonatomic) id<WLCtabBarDelegate> delegate;

@end
