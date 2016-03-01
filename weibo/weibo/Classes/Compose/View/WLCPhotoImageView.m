//
//  WLCPhotoImageView.m
//  weibo
//
//  Created by 王 on 16/3/1.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCPhotoImageView.h"

@implementation WLCPhotoImageView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
     
        [self decorateUI];
    }
    
    return self;
}

//布局
- (void)decorateUI {
    
    //每个imageview添加一个关闭按钮
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"compose_photo_close"] forState:UIControlStateNormal];
    [closeBtn sizeToFit];
    
    [closeBtn addTarget:self action:@selector(closeBtnClicking) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    //约束
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
    }];

}

//关闭按钮点击事件
- (void)closeBtnClicking {
 
    [self removeFromSuperview];
}

@end
