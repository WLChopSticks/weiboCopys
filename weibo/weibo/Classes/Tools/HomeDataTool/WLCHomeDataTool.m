//
//  WLCHomeDataTool.m
//  weibo
//
//  Created by 王 on 16/2/29.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCHomeDataTool.h"
#import "WLCAccessTool.h"
#import "WLCAccessToken.h"
#import "WLCBaseDataTool.h"

@implementation WLCHomeDataTool

+(void)getStatusesWithSinceId:(long long)sinceId maxId:(long long)maxId success:(void (^)(WLCStatusesResult *))success failure:(void (^)(NSError *))failure {
    
    NSString *urlStr = @"https://api.weibo.com/2/statuses/home_timeline.json";
    WLCAccessToken *access = [WLCAccessTool readAccessFromLocal];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"access_token"] = access.access_token;
    parameter[@"since_id"] = @(sinceId);
    
    [WLCBaseDataTool HTTPRequestWithMethod:@"GET" andURL:urlStr parameters:parameter classs:[WLCStatusesResult class] success:success failure:failure];

}

+ (void)getMoreStatusesWithSinceId:(long long)sinceId maxId:(long long)maxId success:(void (^)(WLCStatusesResult *))success failure:(void (^)(NSError *))failure {
    
    NSString *urlStr = @"https://api.weibo.com/2/statuses/home_timeline.json";
    WLCAccessToken *access = [WLCAccessTool readAccessFromLocal];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"access_token"] = access.access_token;
    //不获取相同内容的微博
    parameter[@"max_id"] = @(maxId);
    
    [WLCBaseDataTool HTTPRequestWithMethod:@"GET" andURL:urlStr parameters:parameter classs:[WLCStatusesResult class] success:success failure:failure];
}

+ (void)getUserInfoWithUid:(NSString *)uid success:(void (^)(WLCUser *))success failure:(void (^)(NSError *))failure {
    
    NSString *urlStr = @"https://api.weibo.com/2/users/show.json";
    WLCAccessToken *access = [WLCAccessTool readAccessFromLocal];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"access_token"] = access.access_token;
    parameter[@"uid"] = uid;
    
    [WLCBaseDataTool HTTPRequestWithMethod:@"GET" andURL:urlStr parameters:parameter classs:[WLCUser class] success:success failure:failure];
}

+(void)getUnreadMessageNumberWithUid:(NSString *)uid success:(void (^)(WLCStatusesResult *))success failure:(void (^)(NSError *))failure {
    NSString *urlStr = @"https://rm.api.weibo.com/2/remind/unread_count.json";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    WLCAccessToken *access = [WLCAccessTool readAccessFromLocal];
    parameters[@"access_token"] = access.access_token;
    parameters[@"uid"] = uid;
    
    [WLCBaseDataTool HTTPRequestWithMethod:@"GET" andURL:urlStr parameters:parameters classs:[WLCStatusesResult class] success:success failure:failure];
}

@end
