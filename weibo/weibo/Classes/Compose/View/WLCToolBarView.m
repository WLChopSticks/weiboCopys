//
//  WLCToolBarView.m
//  weibo
//
//  Created by 王 on 16/3/1.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCToolBarView.h"

@implementation WLCToolBarView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //布局
        [self decorateUI];
    }
    
    return self;
}

#pragma -mark 布局
- (void)decorateUI {
 
     self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
    
    [self addToolBarButtonWithImage:@"compose_camerabutton_background" andType:WLCComposeToolBarCamera];
    [self addToolBarButtonWithImage:@"compose_toolbar_picture" andType:WLCComposeToolBarPicture];
    [self addToolBarButtonWithImage:@"compose_mentionbutton_background" andType:WLCComposeToolBarMention];
    [self addToolBarButtonWithImage:@"compose_trendbutton_background" andType:WLCComposeToolBarTrend];
    [self addToolBarButtonWithImage:@"compose_emoticonbutton_background" andType:WLCComposeToolBarEmotion];
    
    
}

//添加每个button
- (void)addToolBarButtonWithImage: (NSString *)imageName andType: (WLCToolBarButtonType)type {

    UIButton *button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]] forState:UIControlStateHighlighted];
    button.tag = type;
    [button addTarget:self action:@selector(toolBarButtonClicking:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];


}

//计算位置布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnW = ScreenWidth / self.subviews.count;
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = self.height;
    }
}

//button点击事件
- (void)toolBarButtonClicking: (UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(toolBarView:didClickToolBarButton:)]) {
        [self.delegate toolBarView:self didClickToolBarButton:sender];
    }
//    NSLog(@"%ld",sender.tag);
}

@end
