//
//  UIBarButtonItem+Extention.m
//  weibo
//
//  Created by 王 on 16/2/19.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "UIBarButtonItem+Extention.h"

@implementation UIBarButtonItem (Extention)

+(instancetype)itemWithImageNameAndItsHighlight:(NSString *)imageName target:(nullable id)target action:(nullable SEL)action {
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    //添加点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    

}

@end
