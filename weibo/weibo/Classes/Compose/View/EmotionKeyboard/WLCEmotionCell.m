//
//  WLCEmotionCell.m
//  weibo
//
//  Created by 王 on 16/3/2.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCEmotionCell.h"

@interface WLCEmotionCell ()

@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UIImageView *emotionImageView;

@end

@implementation WLCEmotionCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        [self decorateUI];
    }
    return self;
}

#pragma -mark 布局
- (void)decorateUI {
    
    UIImageView *emotionImageView = [[UIImageView alloc]init];
    self.emotionImageView = emotionImageView;
    [self addSubview:emotionImageView];
//    emotionImageView.backgroundColor = randomColor;
    
    UILabel *numberlabel = [[UILabel alloc]init];
    self.label = numberlabel;
    numberlabel.text = self.imageName;
    [self addSubview:numberlabel];
    
    //约束
    [emotionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [numberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);

    }];
}

-(void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    
    self.label.text = imageName;
//    self.emotionImageView.image = [UIImage imageWithContentsOfFile:imageName];
}

@end
