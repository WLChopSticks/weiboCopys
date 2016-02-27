//
//  WLCPictureViewCell.m
//  weibo
//
//  Created by 王 on 16/2/26.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCPictureViewCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

@interface WLCPictureViewCell ()

@property (weak, nonatomic) UILabel *gifOrNotLabel;

@end

@implementation WLCPictureViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
       
        [self decorateUI];
    }
    
    return self;
}

#pragma -mark 布局
- (void)decorateUI {
    
    UIImageView *imageView = [[UIImageView alloc]init];
    self.imageView = imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
    
    UILabel *gifOrNotLabel = [[UILabel alloc]init];
    gifOrNotLabel.text = @"GIF";
    gifOrNotLabel.textColor = [UIColor whiteColor];
    gifOrNotLabel.font = [UIFont systemFontOfSize:30];
    gifOrNotLabel.alpha = 0.8;
    self.gifOrNotLabel = gifOrNotLabel;
    [self addSubview:gifOrNotLabel];
    
    //约束
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [gifOrNotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

#pragma -mark 数据
-(void)setImageURL:(NSURL *)imageURL {
    _imageURL = imageURL;
//    NSLog(@"是不是gif%@",imageURL);

    
    if ([imageURL.absoluteString hasSuffix:@"gif"]) {
        self.gifOrNotLabel.hidden = NO;
        [self.imageView sd_setImageWithURL:imageURL];
    } else {
        self.gifOrNotLabel.hidden = YES;
        NSString *urlStr = [[imageURL absoluteString] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        NSURL *url = [NSURL URLWithString:urlStr];
        [self.imageView sd_setImageWithURL:url];
    }

}



@end
