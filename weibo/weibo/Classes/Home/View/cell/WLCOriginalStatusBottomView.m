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

@interface WLCOriginalStatusBottomView ()

@property (weak, nonatomic) UIButton *reposetBtn;
@property (weak, nonatomic) UIButton *commentsBtn;
@property (weak, nonatomic) UIButton *attitudesBtn;

@end

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
    self.reposetBtn = reposetBtn;
    [self setButtonTitle:@"转发" andImage:@"timeline_icon_retweet" toButton:reposetBtn];
    [self addSubview:reposetBtn];
    
    UIButton *commentsBtn = [[UIButton alloc]init];
    self.commentsBtn = commentsBtn;
    [self setButtonTitle:@"评论" andImage:@"timeline_icon_comment" toButton:commentsBtn];
    [self addSubview:commentsBtn];
    
    UIButton *attitudesBtn = [[UIButton alloc]init];
    self.attitudesBtn = attitudesBtn;
    [self setButtonTitle:@"赞" andImage:@"timeline_icon_unlike" toButton:attitudesBtn];
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

//统一设置button的大小颜色
- (void)setButtonTitle: (NSString *)title andImage: (NSString *)imageName toButton: (UIButton *)btn {
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setBackgroundColor:RGB(254, 254, 254)];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_retweet_background_highlighted"] forState:UIControlStateHighlighted];
}

#pragma -mark 转发评论栏数据设置
-(void)setStatuses:(WLCStatuses *)statuses {
    _statuses = statuses;
    
    //设置数据
    if (statuses.reposts_count != 0) {
        [self.reposetBtn setTitle:[NSString stringWithFormat:@"%d",self.statuses.reposts_count] forState:UIControlStateNormal];
    } else {
        [self.reposetBtn setTitle:@"转发" forState:UIControlStateNormal];
    }
    if (statuses.comments_count != 0) {
        [self.commentsBtn setTitle:[NSString stringWithFormat:@"%d",self.statuses.comments_count] forState:UIControlStateNormal];
    } else {
        [self.commentsBtn setTitle:@"评论" forState:UIControlStateNormal];
    }
    if (statuses.attitudes_count != 0) {
        [self.attitudesBtn setTitle:[NSString stringWithFormat:@"%d",self.statuses.attitudes_count] forState:UIControlStateNormal];
    } else {
        [self.attitudesBtn setTitle:@"赞" forState:UIControlStateNormal];
    }
}

@end
