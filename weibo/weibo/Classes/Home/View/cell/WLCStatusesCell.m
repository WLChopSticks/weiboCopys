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

@interface WLCStatusesCell ()

@property (weak, nonatomic) WLCOriginalStatusTopView *topView;

@end

@implementation WLCStatusesCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = randomColor;
        
        //布局
        [self decorateUI];
        
    }
    
    return self;
}

- (void)decorateUI {
    
    WLCOriginalStatusTopView *topView = [[WLCOriginalStatusTopView alloc]init];
    self.topView = topView;
    [self.contentView addSubview:topView];
    
    //约束
    //顶部视图约束
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
//        make.height.mas_equalTo(100);
    }];

    
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
//            make.height.mas_equalTo(150);
            make.bottom.equalTo(topView.mas_bottom);
        }];

    
}

-(void)setStatuses:(WLCStatuses *)statuses {
    _statuses = statuses;
    
    
    self.topView.user = self.statuses.user;
    self.topView.statuses = self.statuses;

    
//    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top);
//        make.left.equalTo(self.mas_left);
//        make.right.equalTo(self.mas_right);
////        make.height.mas_equalTo(100);
//    }];
//    
//    //更新cell的约束
//    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(topView.mas_bottom).offset(10);
//    }];
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(topView.mas_top);
//        make.left.equalTo(topView.mas_left);
//        make.right.equalTo(topView.mas_right);
//        make.height.mas_equalTo(1500);
//        make.bottom.equalTo(topView.mas_bottom).offset(10);
//    }];

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end