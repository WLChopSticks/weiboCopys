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
#import "WLCEmotion.h"
#import "MJExtension.h"


@interface WLCEmotionKeyboard ()<emotionToolBarDelegate>

@property (weak, nonatomic) WLCEmotionListView *emotionListView;
@property (strong, nonatomic) WLCEmotionListView *recentListView;
@property (strong, nonatomic) WLCEmotionListView *defaultListView;
@property (strong, nonatomic) WLCEmotionListView *emojiListView;
@property (strong, nonatomic) WLCEmotionListView *lxhListView;

@property (weak, nonatomic) WLCEmotionToolBar *toolBar;

@property (strong, nonatomic) WLCEmotion *emotion;

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
    
    WLCEmotionListView *emotionListView = [[WLCEmotionListView alloc]init];
    self.emotionListView = emotionListView;
    [self addSubview:self.emotionListView];
    
    
    //约束
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(self.height * 0.15);
    }];
    
    [self.emotionListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(toolBar.mas_top);
        
    }];
    
}


#pragma -mark toolbar的代理方法
-(void)emotionToolBar:(WLCEmotionToolBar *)emotionToolBar buttonClickWithType:(WLCEmotionToolBarButtonType)type {

//    [self.currentListView removeFromSuperview];
    
    switch (type) {
        case WLCEmotionToolBarButtonTypeRecent:
            self.emotionListView.emotions = self.recentListView.emotions;
            break;
        case WLCEmotionToolBarButtonTypeDefault:
            self.emotionListView.emotions = self.defaultListView.emotions;
            break;
        case WLCEmotionToolBarButtonTypeEmoji:
            self.emotionListView.emotions = self.emojiListView.emotions;
            break;
        case WLCEmotionToolBarButtonTypeLxh:
            self.emotionListView.emotions = self.lxhListView.emotions;
            break;
            
        default:
            break;
    }
    
    //将按钮tag值传过去,使其能自动滚到相应表情的第一页
    self.emojiListView.toolBarButtonType = type;

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
        
        //读取默认表情
        NSString *path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons.bundle/default/info.plist" ofType:nil];
        NSArray *emotions = [WLCEmotion mj_objectArrayWithFile:path];
        _defaultListView.emotions = emotions;
    }
    return _defaultListView;
}
-(WLCEmotionListView *)emojiListView {
    if (_emojiListView == nil) {
        _emojiListView = [[WLCEmotionListView alloc]init];
        //读取emoji表情
        NSString *path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons.bundle/emoji/info.plist" ofType:nil];
        NSArray *emotions = [WLCEmotion mj_objectArrayWithFile:path];
        _emojiListView.emotions = emotions;
    }
    return _emojiListView;
}
-(WLCEmotionListView *)lxhListView {
    if (_lxhListView == nil) {
        _lxhListView = [[WLCEmotionListView alloc]init];
        //读取浪小花表情
        NSString *path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons.bundle/lxh/info.plist" ofType:nil];
        NSArray *emotions = [WLCEmotion mj_objectArrayWithFile:path];
        _lxhListView.emotions = emotions;
    }
    return _lxhListView;
}


@end
