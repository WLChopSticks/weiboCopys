//
//  WLCOriginalStatusBottomView.m
//  weibo
//
//  Created by 王 on 16/2/26.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCOriginalStatusBottomView.h"
#import "Masonry.h"

#define BORDER_COLOR RGB(216, 216, 216)

@implementation WLCOriginalStatusBottomView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self decorateUI];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = BORDER_COLOR.CGColor;
    }
    
    return self;
}

//布局
- (void)decorateUI {
    
    UIButton *reposetBtn = [[UIButton alloc]init];
    [reposetBtn setTitle:@"转发" forState:UIControlStateNormal];
    reposetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [reposetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [reposetBtn setImage:[UIImage imageNamed:@"timeline_icon_retweet"] forState:UIControlStateNormal];
    [reposetBtn setBackgroundColor:RGB(254, 254, 254)];
    [reposetBtn setBackgroundImage:[UIImage imageNamed:@"timeline_retweet_background_highlighted"] forState:UIControlStateHighlighted];
    [self addSubview:reposetBtn];
    
    UIButton *commentsBtn = [[UIButton alloc]init];
    [commentsBtn setTitle:@"评论" forState:UIControlStateNormal];
    commentsBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [commentsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [commentsBtn setImage:[UIImage imageNamed:@"timeline_icon_comment"] forState:UIControlStateNormal];
    [commentsBtn setBackgroundColor:RGB(254, 254, 254)];
    [commentsBtn setBackgroundImage:[UIImage imageNamed:@"timeline_retweet_background_highlighted"] forState:UIControlStateHighlighted];
    [self addSubview:commentsBtn];
    
    UIButton *attitudesBtn = [[UIButton alloc]init];
    [attitudesBtn setTitle:@"赞" forState:UIControlStateNormal];
    attitudesBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [attitudesBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [attitudesBtn setImage:[UIImage imageNamed:@"timeline_icon_unlike"] forState:UIControlStateNormal];
    [attitudesBtn setBackgroundColor:RGB(254, 254, 254)];
    [attitudesBtn setBackgroundImage:[UIImage imageNamed:@"timeline_retweet_background_highlighted"] forState:UIControlStateHighlighted];
    [self addSubview:attitudesBtn];
    
    UIImageView *seperateViewL = [[UIImageView alloc]init];
    seperateViewL.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:seperateViewL];
    
    UIImageView *seperateViewR = [[UIImageView alloc]init];
    seperateViewR.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:seperateViewR];
    
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
    
    //分割线约束
    [seperateViewL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(reposetBtn.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(1);
    }];
    [seperateViewR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(commentsBtn.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(1);
    }];
    
}

@end
