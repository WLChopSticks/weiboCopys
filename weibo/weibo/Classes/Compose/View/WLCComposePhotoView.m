//
//  WLCComposePhotoView.m
//  weibo
//
//  Created by 王 on 16/3/1.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCComposePhotoView.h"

#define PHOTO_MARGIN 5

@implementation WLCComposePhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self decorateUI];
        
    }
    return self;
}

#pragma -mark 布局
- (void)decorateUI {
    
    self.backgroundColor = randomColor;
    
    
    
}


-(void)addImageToPhotoView:(UIImage *)image {
    
    
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = image;
    [self addSubview:imageView];
    
}


-(void)layoutSubviews {
    [super layoutSubviews];
    
    
    CGFloat photoW = (ScreenWidth - 4 * PHOTO_MARGIN) / 3.0;
    int count = (int)self.subviews.count;
    
    //如果选择图片再更新高度
    if (count != 0) {
        
        CGFloat maxHeight = (photoW + PHOTO_MARGIN) * (((count - 1) / 3) + 1);
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(maxHeight);
        }];
    }
    
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = self.subviews[i];
        
        CGFloat row = i / 3;
        CGFloat col = i % 3;
        
        imageView.x = (col + 1) * PHOTO_MARGIN + col * photoW;
        imageView.y = row * photoW + row * PHOTO_MARGIN;
        imageView.width = photoW;
        imageView.height = photoW;
        
    }
    
}






@end
