//
//  WLCTabBar.m
//  weibo
//
//  Created by 王 on 16/2/18.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCTabBar.h"
#import "UIView+Frame.h"

@interface WLCTabBar ()

@property (strong, nonatomic) UIButton *composeBtn;

@end

@implementation WLCTabBar

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //添加中间创作按钮
        UIButton *composeBtn = [[UIButton alloc]init];
        [composeBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [composeBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [composeBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [composeBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [composeBtn sizeToFit];
        [self addSubview:composeBtn];
        
        [composeBtn addTarget:self action:@selector(composeBtnClicking) forControlEvents:UIControlEventTouchUpInside];
        self.composeBtn = composeBtn;
        
        
        
        
    }
    
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
//    self.composeBtn.frame = CGRectMake(10, 10, 40, 40);
    //将创作按钮添加到tabbar中间的位置
    CGFloat index = 0;
    CGFloat btnW = ScreenWidth / 5;
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIView *childView = self.subviews[i];
        if ([childView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (index == 2) {
                index++;
            }
            childView.x = index * btnW;
            childView.width = btnW;
            childView.y = 0;
            childView.height = self.height;
            index++;
        }
    }
    self.composeBtn.centerX = self.width * 0.5;
    self.composeBtn.centerY = self.height * 0.5;
    
    
}

- (void)composeBtnClicking {
    NSLog(@"123");
}




@end
