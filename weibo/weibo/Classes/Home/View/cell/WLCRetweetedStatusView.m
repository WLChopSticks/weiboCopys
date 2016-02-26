//
//  WLCRetweetedStatusView.m
//  weibo
//
//  Created by 王 on 16/2/26.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCRetweetedStatusView.h"
#import "Masonry.h"
#import "WLCPictureView.h"

#define TEXT_MARGIN 10

@interface WLCRetweetedStatusView ()

@property (weak, nonatomic) UILabel *contentLabel;
@property (weak, nonatomic) WLCPictureView *pictureView;

@end

@implementation WLCRetweetedStatusView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self decorateUI];
        self.backgroundColor = RGB(246, 246, 246);
    }
    
    return self;
}

#pragma -mark 布局
- (void)decorateUI {
    
    UILabel *contentLabel = [[UILabel alloc]init];
    self.contentLabel = contentLabel;
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = RGB(93, 93, 93);
    [self addSubview:contentLabel];
    
    WLCPictureView *pictureView = [[WLCPictureView alloc]init];
    self.pictureView = pictureView;
    [self addSubview:pictureView];
    
    //约束
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(TEXT_MARGIN);
        make.left.equalTo(self.mas_left).offset(TEXT_MARGIN);
        make.right.equalTo(self.mas_right).offset(-TEXT_MARGIN);
    }];
    
//    pictureView
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(contentLabel.mas_bottom).offset(TEXT_MARGIN);
    }];
    
}

#pragma -mark 转发微博页面数据显示
-(void)setRetweeted_status:(WLCStatuses *)retweeted_status {
    _retweeted_status = retweeted_status;
    
//    if (retweeted_status == nil) {
//        [self mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(0);
//        }];
//        return;
//    }
    
    NSString *content = [NSString stringWithFormat:@"@%@: %@",retweeted_status.user.screen_name,retweeted_status.text];
    self.contentLabel.text = content;
    NSLog(@"转发微博---%@",self.retweeted_status.text);
}

@end
