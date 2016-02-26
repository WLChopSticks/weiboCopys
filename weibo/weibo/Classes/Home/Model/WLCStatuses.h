//
//  WLCStatuses.h
//  weibo
//
//  Created by 王 on 16/2/23.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLCUser.h"

@interface WLCStatuses : NSObject


//当前微博的内容
@property (nonatomic, copy) NSString *text;
@property (assign, nonatomic) long long id;

//User信息
@property (strong, nonatomic) WLCUser *user;
//创建时间
@property (nonatomic, copy) NSString *created_at;
//来源
@property (nonatomic, copy) NSString *source;
//微博配图
@property (strong, nonatomic) NSArray *pic_urls;
@property (strong, nonatomic) NSMutableArray *picturesURLs;

@end
