//
//  UIView+Frame.h
//  weibo
//
//  Created by 王 on 15/2/18.
//  Copyright © 2015年 WLChopSticks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

//宽高位置大小
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

//中心点的x与y
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;



@end
