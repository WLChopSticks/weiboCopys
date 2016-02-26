//
//  WLCStatusesCell.m
//  weibo
//
//  Created by 王 on 16/2/25.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCStatusesCell.h"
#import "WLCOriginalStatusTopView.h"
#import "Masonry.h"
#import "WLCOriginalStatusBottomView.h"
#import "WLCRetweetedStatusView.h"

#define VIEW_MARGIN 10
@interface WLCStatusesCell ()

@property (weak, nonatomic) WLCOriginalStatusTopView *topView;
@property (weak, nonatomic) WLCOriginalStatusBottomView *bottomView;
@property (weak, nonatomic) WLCRetweetedStatusView *retweetedView;
@property (strong, nonatomic) MASConstraint *bottomViewTopConstraint;

@end

@implementation WLCStatusesCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = RGB(240, 240, 240);
        
        //布局
        [self decorateUI];
        
    }
    
    return self;
}

#pragma -mark 布局
- (void)decorateUI {
    
    WLCOriginalStatusTopView *topView = [[WLCOriginalStatusTopView alloc]init];
    self.topView = topView;
    [self.contentView addSubview:topView];
    
    //创建转发视图
    WLCRetweetedStatusView *retweetedView = [[WLCRetweetedStatusView alloc]init];
    self.retweetedView = retweetedView;
//    retweetedView.hidden = YES;
    [self.contentView addSubview:retweetedView];
    
    
    WLCOriginalStatusBottomView *bottomView = [[WLCOriginalStatusBottomView alloc]init];
    self.bottomView = bottomView;
    [self.contentView addSubview:bottomView];
    
    //约束
    //顶部视图约束
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(VIEW_MARGIN);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
//        make.height.mas_equalTo(100);
    }];
    
    //转发视图约束
    [retweetedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        //            make.height.mas_equalTo(10);
    }];
    
    //底部视图约束
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.bottomViewTopConstraint = make.top.equalTo(topView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(30);
    }];

    
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
//            make.height.mas_equalTo(150);
            make.bottom.equalTo(bottomView.mas_bottom);
        }];

    
}

-(void)setStatuses:(WLCStatuses *)statuses {
    _statuses = statuses;
    
    
    self.topView.user = statuses.user;
    self.topView.statuses = statuses;
    
    self.bottomView.statuses = statuses;
    
    //根据是否是转发微博 加载retweetview
    if (self.statuses.retweeted_status != nil) {
    
        self.retweetedView.hidden = NO;
    
        self.retweetedView.retweeted_status = statuses.retweeted_status;
        [self.bottomViewTopConstraint uninstall];
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            self.bottomViewTopConstraint = make.top.equalTo(self.retweetedView.mas_bottom);
        }];
    } else {
        self.retweetedView.hidden = YES;
        [self.bottomViewTopConstraint uninstall];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            self.bottomViewTopConstraint = make.top.equalTo(self.topView.mas_bottom);
        }];
    }
    
    

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
