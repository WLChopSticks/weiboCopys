//
//  WLCAccessToken.h
//  weibo
//
//  Created by 王 on 16/2/22.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCAccessToken : NSObject

@property (copy, nonatomic) NSString *access_token;
@property (assign, nonatomic) NSInteger expires_in;
@property (copy, nonatomic) NSString *remind_in;
@property (copy, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *str;


@end
