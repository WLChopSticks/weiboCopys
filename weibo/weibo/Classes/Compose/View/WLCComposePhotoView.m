//
//  WLCComposePhotoView.m
//  weibo
//
//  Created by 王 on 16/3/1.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCComposePhotoView.h"
#import "WLCPhotoImageView.h"

#define PHOTO_MARGIN 5

@interface WLCComposePhotoView ()



@end

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
    
    
    
    WLCPhotoImageView *imageView = [[WLCPhotoImageView alloc]init];
    imageView.image = image;
    imageView.userInteractionEnabled = YES;
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
    } else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];

    }
    
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = self.subviews[i];
        
        CGFloat row = i / 3;
        CGFloat col = i % 3;
        
        imageView.width = photoW;
        imageView.height = photoW;
        
        //如果图片的x或者y为0时 不执行动画,以免添加图片时图片从0的位置移动到本身位置
        if (!(imageView.x == 0 && imageView.y == 0)) {
            //动画效果
            [UIView animateWithDuration:0.5 animations:^{
                
                imageView.x = (col + 1) * PHOTO_MARGIN + col * photoW;
                imageView.y = row * photoW + row * PHOTO_MARGIN;
                
//                [self layoutIfNeeded];
            }];
        } else {
            
            imageView.x = (col + 1) * PHOTO_MARGIN + col * photoW;
            imageView.y = row * photoW + row * PHOTO_MARGIN;
        }

        
        
    }
    
}


//返回还有多少图片
-(NSMutableArray *)imageArray {
    return [self.subviews valueForKey:@"image"];
}








@end
