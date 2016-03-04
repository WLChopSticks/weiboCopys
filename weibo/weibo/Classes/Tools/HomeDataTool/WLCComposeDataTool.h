//
//  WLCComposeDataTool.h
//  weibo
//
//  Created by 王 on 16/3/4.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLCStatusesResult.h"

@interface WLCComposeDataTool : NSObject

//发布文字微博
+ (void)SendTextStatusWithText: (NSString *)contents success:(void (^)(WLCStatusesResult *result))success failure:(void (^)(NSError *error))failure;
//发布图片微博
+ (void)SendTextStatusWithText: (NSString *)contents andImage: (UIImage *)image success:(void (^)(WLCStatusesResult *result))success failure:(void (^)(NSError *error))failure;


@end
