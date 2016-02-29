//
//  WLCHomeDataTool.h
//  weibo
//
//  Created by 王 on 16/2/29.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLCStatusesResult.h"
#import "WLCUser.h"

@interface WLCHomeDataTool : NSObject

//获取最新微博,下拉刷新
+ (void)getStatusesWithSinceId: (long long)sinceId maxId: (long long)maxId success:(void (^)(WLCStatusesResult *result))success failure:(void (^)(NSError *error))failure;

//获取更多微博,上拉刷新
+ (void)getMoreStatusesWithSinceId: (long long)sinceId maxId: (long long )maxId success:(void (^)(WLCStatusesResult *result))success failure:(void (^)(NSError *error))failure;

//读取用户信息
+ (void)getUserInfoWithUid: (NSString *)uid success:(void (^)(WLCUser *result))success failure:(void (^)(NSError *error))failure;

//获取未读消息数
+ (void)getUnreadMessageNumberWithUid: (NSString *)uid success:(void (^)(WLCStatusesResult *result))success failure:(void (^)(NSError *error))failure;

//下载单张图片,以此计算单张图片大小
+ (void)downloadSingleImageWithModelArray: (NSArray *)statusModel finished: (void (^)())finish;

@end
