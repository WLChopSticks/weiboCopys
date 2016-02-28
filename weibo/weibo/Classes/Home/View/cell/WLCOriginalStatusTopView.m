//
//  WLCOriginalStatusTopView.m
//  weibo
//
//  Created by 王 on 16/2/25.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCOriginalStatusTopView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "WLCPictureView.h"

#define SMALL_MARGIN 5
#define NAME_FONT 15
#define TIME_FONT 10
#define TEXT_FONT 15

@interface WLCOriginalStatusTopView ()

@property (weak, nonatomic) UIImageView *avatar;
@property (weak, nonatomic) UILabel *name;
@property (weak, nonatomic) UIImageView *verifiedImage;
@property (weak, nonatomic) UILabel *createTime;
@property (weak, nonatomic) UILabel *source;
@property (weak, nonatomic) UILabel *textLabel;
@property (weak, nonatomic) UIImageView *mbrankImage;
@property (weak, nonatomic) WLCPictureView *pictureView;


@end

@implementation WLCOriginalStatusTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //布局
        [self decorateUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)decorateUI {
    //添加控件
    UIImageView *avatar = [[UIImageView alloc]init];
//    avatar.backgroundColor = randomColor;
    self.avatar = avatar;
    [self addSubview:avatar];
    
    UILabel *name = [[UILabel alloc]init];
    self.name = name;
    name.font = [UIFont systemFontOfSize:15];
    name.textColor = [UIColor orangeColor];
    [self addSubview:name];
    
    UIImageView *verifiedImage = [[UIImageView alloc]init];
    self.verifiedImage = verifiedImage;
    [self addSubview:verifiedImage];
    
    UIImageView *mbrankImage = [[UIImageView alloc]init];
    self.mbrankImage = mbrankImage;
    [self addSubview:mbrankImage];
    
    
    UILabel *createTime = [[UILabel alloc]init];
    self.createTime = createTime;
    createTime.font = [UIFont systemFontOfSize:TIME_FONT];
    createTime.textColor = [UIColor grayColor];
    [self addSubview:createTime];
    
    UILabel *source = [[UILabel alloc]init];
    self.source =source;
    source.font = [UIFont systemFontOfSize:TIME_FONT];
    source.textColor = [UIColor grayColor];
    [self addSubview:source];
    
    UILabel *textLabel = [[UILabel alloc]init];
    self.textLabel = textLabel;
    textLabel.numberOfLines = 0;
    [self addSubview:textLabel];
    
    WLCPictureView *pictureView = [[WLCPictureView alloc]init];
    self.pictureView = pictureView;
    [self addSubview:pictureView];
    
    //约束
    //头像的约束
    [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SMALL_MARGIN);
        make.left.equalTo(self.mas_left).offset(SMALL_MARGIN);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    //名字的约束
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SMALL_MARGIN);
        make.left.equalTo(avatar.mas_right).offset(SMALL_MARGIN);
        
    }];
    
    //会员等级的约束
    [mbrankImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SMALL_MARGIN);
        make.left.equalTo(name.mas_right).offset(SMALL_MARGIN);
    }];
    
    //认证约束
    [verifiedImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(avatar.mas_right).offset(-SMALL_MARGIN);
        make.centerY.equalTo(avatar.mas_bottom).offset(-SMALL_MARGIN);
    }];
    
    //发布时间的约束
    [createTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(avatar.mas_bottom);
        make.left.equalTo(avatar.mas_right).offset(SMALL_MARGIN);
    }];
    
    //来源的约束
    [source mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(createTime.mas_top);
        make.left.equalTo(createTime.mas_right).offset(SMALL_MARGIN);
    }];
    
    //正文的约束
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(avatar.mas_bottom).offset(SMALL_MARGIN);
        make.left.equalTo(self.mas_left).offset(SMALL_MARGIN);
        make.right.equalTo(self.mas_right).offset(-SMALL_MARGIN);
//        make.height.mas_equalTo(60);
    }];
    
    //配图的约束
    [pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textLabel.mas_bottom).offset(SMALL_MARGIN);
        make.left.equalTo(self.mas_left).offset(SMALL_MARGIN);
//        make.right.equalTo(self.mas_right);
//        make.width.mas_equalTo(ScreenWidth);
//        make.height.mas_equalTo(50);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(pictureView.mas_bottom).offset(SMALL_MARGIN);
    }];
    
    
//    self.backgroundColor = randomColor;
}



-(void)setStatuses:(WLCStatuses *)statuses {
    _statuses = statuses;
    
    self.textLabel.text = statuses.text;
    //用户头像
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:self.user.profile_image_url]];
    self.avatar.layer.cornerRadius = 15;
    [self.avatar clipsToBounds];
    //用户名字
    self.name.text = self.user.screen_name;
    //发布时间
    self.createTime.text = statuses.created_at;
    //来源
    self.source.text = [NSString stringWithFormat:@"来自%@",statuses.source];
    //会员等级
    self.mbrankImage.image = statuses.user.mbrankImage;
    //认证
    self.verifiedImage.image = statuses.user.verifiedImage;
    //微博配图
    self.pictureView.imageURLs = statuses.picturesURLs;
    
}



@end
