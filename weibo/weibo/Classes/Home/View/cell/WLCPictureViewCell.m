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

@property (weak, nonatomic) UIImageView *imageView;

@end

@implementation WLCPictureViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc]init];
        self.imageView = imageView;
        [self addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
    }
    
    return self;
}

-(void)setImageURL:(NSURL *)imageURL {
    _imageURL = imageURL;

    [self.imageView sd_setImageWithURL:imageURL];

}



@end
