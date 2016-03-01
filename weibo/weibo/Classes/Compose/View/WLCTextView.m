//
//  WLCTextView.m
//  weibo
//
//  Created by 王 on 16/3/1.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCTextView.h"
#import "Masonry.h"

@implementation WLCTextView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //布局
        [self decorateUI];
    }
    
    return self;
}


#pragma -mark 布局
- (void)decorateUI {

    self.backgroundColor = randomColor;
    //提示label
    UILabel *tipLabel = [[UILabel alloc]init];
    self.tipLabel = tipLabel;
    tipLabel.text = @"分享新鲜事...";
    tipLabel.textColor = [UIColor grayColor];
    tipLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:tipLabel];
    
    
    //布局
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(5);
    }];
}


@end
