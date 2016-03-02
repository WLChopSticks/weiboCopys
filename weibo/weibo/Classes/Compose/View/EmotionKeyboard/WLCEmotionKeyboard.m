//
//  WLCEmotionKeyboard.m
//  weibo
//
//  Created by 王 on 16/3/1.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCEmotionKeyboard.h"
#import "WLCEmotionToolBar.h"
#import "WLCEmotionListView.h"


@interface WLCEmotionKeyboard ()<emotionToolBarDelegate>

@property (weak, nonatomic) WLCEmotionListView *currentListView;
@property (strong, nonatomic) WLCEmotionListView *recentListView;
@property (strong, nonatomic) WLCEmotionListView *defaultListView;
@property (strong, nonatomic) WLCEmotionListView *emojiListView;
@property (strong, nonatomic) WLCEmotionListView *lxhListView;

@property (weak, nonatomic) WLCEmotionToolBar *toolBar;

@end

@implementation WLCEmotionKeyboard

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self decorateUI];
    }
    
    return self;
}

#pragma -mark 布局
- (void)decorateUI {
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
    
    WLCEmotionToolBar *toolBar = [[WLCEmotionToolBar alloc]init];
    self.toolBar = toolBar;
    toolBar.delegate = self;
    [self addSubview:toolBar];
    
    WLCEmotionListView *currentListView = [[WLCEmotionListView alloc]init];
    self.currentListView = currentListView;
    [self addSubview:self.currentListView];
    
    
    //约束
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(self.height * 0.15);
    }];
    
    [self.currentListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(toolBar.mas_top);
        
    }];
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self.currentListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.toolBar.mas_top);
        
    }];
}


#pragma -mark toolbar的代理方法
-(void)emotionToolBar:(WLCEmotionToolBar *)emotionToolBar buttonClickWithType:(WLCEmotionToolBarButtonType)type {

    [self.currentListView removeFromSuperview];
    
    switch (type) {
        case WLCEmotionToolBarButtonTypeRecent: 
            self.currentListView = self.recentListView;
            break;
        case WLCEmotionToolBarButtonTypeDefault:
            self.currentListView = self.defaultListView;
            break;
        case WLCEmotionToolBarButtonTypeEmoji:
            self.currentListView = self.emojiListView;
            break;
        case WLCEmotionToolBarButtonTypeLxh:
            self.currentListView = self.lxhListView;
            break;
            
        default:
            break;
    }
    
    [self addSubview:self.currentListView];
}


//懒加载
-(WLCEmotionListView *)recentListView {
    if (_recentListView == nil) {
        _recentListView = [[WLCEmotionListView alloc]init];
        _recentListView.backgroundColor = randomColor;
    }
    return _recentListView;
}
-(WLCEmotionListView *)defaultListView {
    if (_defaultListView == nil) {
        _defaultListView = [[WLCEmotionListView alloc]init];
        _defaultListView.backgroundColor = randomColor;
    }
    return _defaultListView;
}
-(WLCEmotionListView *)emojiListView {
    if (_emojiListView == nil) {
        _emojiListView = [[WLCEmotionListView alloc]init];
        _emojiListView.backgroundColor = randomColor;
    }
    return _emojiListView;
}
-(WLCEmotionListView *)lxhListView {
    if (_lxhListView == nil) {
        _lxhListView = [[WLCEmotionListView alloc]init];
        _lxhListView.backgroundColor = randomColor;
    }
    return _lxhListView;
}

@end
