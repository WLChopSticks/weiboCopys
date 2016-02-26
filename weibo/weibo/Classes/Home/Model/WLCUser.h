//
//  WLCUser.h
//  weibo
//
//  Created by 王 on 16/2/23.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCUser : NSObject


//昵称
@property (nonatomic, copy) NSString *screen_name;
//头像图片地址
@property (copy, nonatomic) NSString *profile_image_url;

//会员等级
//会员等级 0-6
@property (assign, nonatomic) int mbrank;
@property (strong, nonatomic) UIImage *mbrankImage;

//认证用户
//认证类型，-1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
@property (assign, nonatomic) int verified_type;
@property (strong, nonatomic) UIImage *verifiedImage;

@end
