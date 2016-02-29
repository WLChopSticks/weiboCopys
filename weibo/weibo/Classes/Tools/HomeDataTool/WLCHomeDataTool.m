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
#import "UIImageView+WebCache.h"
#import "WLCStatuses.h"

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

+ (void)downloadSingleImageWithModelArray:(NSArray *)statusModel finished:(void (^)())finish{
    for (WLCStatuses *status in statusModel) {
        if (status.pic_urls.count == 1 || status.retweeted_status.pic_urls.count == 1) {
            
//            NSLog(@"外面的%@",status.picturesURLs.lastObject);
            dispatch_group_t group = dispatch_group_create();
            dispatch_group_enter(group);
            NSURL *statusURL = [[NSURL alloc]init];
            if (status.pic_urls.count == 1 ) {
                statusURL = status.picturesURLs.lastObject;
            } else {
                statusURL = status.retweeted_status.picturesURLs.lastObject;
            }
            [[SDWebImageManager sharedManager]downloadImageWithURL:statusURL options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                //单张图片下载成功
                dispatch_group_leave(group);
                
                //                    [self.tableView reloadData];
                
            }];
            
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                //完成
                NSLog(@"所哟图片下载完毕");
//                [self.tableView reloadData];
                if (finish) {
                    finish();
                }
            });
        }
    }

}


@end
