//
//  WLCOriginalStatusBottomView.m
//  weibo
//
//  Created by 王 on 16/2/26.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCOriginalStatusBottomView.h"
#import "Masonry.h"

#define BORDER_COLOR RGB(216, 216, 216).CGColor

@implementation WLCOriginalStatusBottomView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self decorateUI];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = BORDER_COLOR;
    }
    
    return self;
}

//布局
- (void)decorateUI {
    
    UIButton *reposetBtn = [[UIButton alloc]init];
    [reposetBtn setTitle:@"转发" forState:UIControlStateNormal];
    [reposetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self addSubview:reposetBtn];
    
    UIButton *commentsBtn = [[UIButton alloc]init];
    [commentsBtn setTitle:@"评论" forState:UIControlStateNormal];
    [commentsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self addSubview:commentsBtn];
    
    UIButton *attitudesBtn = [[UIButton alloc]init];
    [attitudesBtn setTitle:@"赞" forState:UIControlStateNormal];
    [attitudesBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self addSubview:attitudesBtn];
    
    
    //约束
    CGFloat btnWidth = ScreenWidth / 3.0;
    //转发按钮约束
    [reposetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(btnWidth);
    }];
    
    //评论按钮约束
    [commentsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(reposetBtn.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(btnWidth);
    }];
    
    //点赞按钮约束
    [attitudesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(commentsBtn.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(btnWidth);
    }];
    
}

@end
