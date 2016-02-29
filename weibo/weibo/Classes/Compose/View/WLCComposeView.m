//
//  WLCComposeView.m
//  weibo
//
//  Created by 王 on 16/2/29.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCComposeView.h"
#import "UIImage+ImageEffects.h"

@implementation WLCComposeView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //截图获取图片磨砂效果
        UIImage *image = [self currentScreenImage];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:imageView];
    }
    
    return self;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self removeFromSuperview];
}


//截图获取图片磨砂效果
- (UIImage *)currentScreenImage {
    UIGraphicsBeginImageContext(ScreenBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIApplication sharedApplication].keyWindow.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image applyLightEffect];
}

@end
