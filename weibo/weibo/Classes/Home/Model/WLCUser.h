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

@end
