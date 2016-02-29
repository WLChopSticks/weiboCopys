//
//  WLCComposeBtn.m
//  weibo
//
//  Created by 王 on 16/2/29.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCComposeBtn.h"

#define COMPOSEBUTTON_WIDTH 80
#define COMPOSEBUTTON_HEIGHT 110

@implementation WLCComposeBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.size = CGSizeMake(COMPOSEBUTTON_WIDTH, COMPOSEBUTTON_HEIGHT);
        
        //按钮图片文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeCenter;
        
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
  
    //调整图片和文字的位置
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = COMPOSEBUTTON_WIDTH;
    self.imageView.height = COMPOSEBUTTON_WIDTH;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = COMPOSEBUTTON_WIDTH;
    self.titleLabel.height = COMPOSEBUTTON_HEIGHT - COMPOSEBUTTON_WIDTH;
    
    
}

@end
