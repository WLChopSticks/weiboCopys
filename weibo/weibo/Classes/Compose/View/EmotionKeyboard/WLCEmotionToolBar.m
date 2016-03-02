//
//  WLCEmotionToolBar.m
//  weibo
//
//  Created by 王 on 16/3/2.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCEmotionToolBar.h"
#import "UIButton+RemoveHighlight.h"

@interface WLCEmotionToolBar ()

@property (weak, nonatomic) UIButton *lastSelectedBtn;

@end

@implementation WLCEmotionToolBar

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self decorateUI];
    }
    
    return self;
}

#pragma -mark 布局
- (void)decorateUI {
    
    [self addToolBarButtonWithTitle:@"最近" andBackgroundImage:@"left" andButtonType:WLCEmotionToolBarButtonTypeRecent];
    [self addToolBarButtonWithTitle:@"默认" andBackgroundImage:@"mid" andButtonType:WLCEmotionToolBarButtonTypeDefault];
    [self addToolBarButtonWithTitle:@"Emoji" andBackgroundImage:@"mid" andButtonType:WLCEmotionToolBarButtonTypeEmoji];
    [self addToolBarButtonWithTitle:@"浪小花" andBackgroundImage:@"right" andButtonType:WLCEmotionToolBarButtonTypeLxh];
    
}

//添加底部按钮 compose_emotion_table_left_normal
- (void)addToolBarButtonWithTitle: (NSString *)title andBackgroundImage: (NSString *)imageName andButtonType: (WLCEmotionToolBarButtonType)type {
    
    UIButton *toolBarBtn = [[UIButton alloc]init];
    
    //移除高亮状态
    toolBarBtn.removeHighlight = NO;
    
    [toolBarBtn setTitle:title forState:UIControlStateNormal];
    [toolBarBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [toolBarBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"compose_emotion_table_%@_normal",imageName]] forState:UIControlStateNormal];
    [toolBarBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"compose_emotion_table_%@_selected",imageName]] forState:UIControlStateDisabled];
    
    toolBarBtn.tag = type;
    
    [toolBarBtn addTarget:self action:@selector(toolBarButtonClicking:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:toolBarBtn];
    
    //默认第一个按钮为选中状态
    if (type == WLCEmotionToolBarButtonTypeRecent) {
        [self toolBarButtonClicking:toolBarBtn];
    }
    
}

//底部button的位置
- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        
        CGFloat btnW = ScreenWidth / 4;
        UIButton *btn = self.subviews[i];
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = self.height;
        
    }
}

#pragma -mark 底部button点击事件
- (void)toolBarButtonClicking: (UIButton *)sender {
    
    self.lastSelectedBtn.enabled = YES;
    sender.enabled = NO;
    self.lastSelectedBtn = sender;
  
    
    if ([self.delegate respondsToSelector:@selector(emotionToolBar:buttonClickWithType:)]) {
        [self.delegate emotionToolBar:self buttonClickWithType:sender.tag];
    }
}

@end
