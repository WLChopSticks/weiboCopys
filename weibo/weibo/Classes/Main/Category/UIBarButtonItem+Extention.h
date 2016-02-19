//
//  UIBarButtonItem+Extention.h
//  weibo
//
//  Created by 王 on 16/2/19.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extention)

+ (instancetype)itemWithImageNameAndItsHighlight:(NSString *)imageName target:(id)target action:(SEL)action;

@end
