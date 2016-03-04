//
//  WLCEmotionListView.h
//  weibo
//
//  Created by 王 on 16/3/2.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLCEmotionListView : UIView

@property (strong, nonatomic) NSArray *emotions;

@property (assign, nonatomic) NSInteger toolBarButtonType;

@property (copy, nonatomic) NSString *resourcePath;

@end
