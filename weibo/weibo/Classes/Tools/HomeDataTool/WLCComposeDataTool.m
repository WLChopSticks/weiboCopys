//
//  WLCComposeDataTool.m
//  weibo
//
//  Created by 王 on 16/3/4.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCComposeDataTool.h"
#import "WLCAccessTool.h"
#import "WLCAccessToken.h"
#import "WLCBaseDataTool.h"
#import "WLCStatuses.h"
#import "WLCHTTPRequestTool.h"

@implementation WLCComposeDataTool

+(void)SendTextStatusWithText:(NSString *)contents success:(void (^)(WLCStatusesResult *))success failure:(void (^)(NSError *))failure {
 
    NSString *urlStr = @"https://api.weibo.com/2/statuses/update.json";
    
    WLCAccessToken *access = [WLCAccessTool readAccessFromLocal];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"access_token"] = access.access_token;
    parameter[@"status"] = contents;
    
    [WLCBaseDataTool HTTPRequestWithMethod:@"POST" andURL:urlStr parameters:parameter classs:[WLCStatuses class] success:success failure:failure];
    
    
}

+(void)SendTextStatusWithText:(NSString *)contents andImage:(UIImage *)image success:(void (^)(WLCStatusesResult *))success failure:(void (^)(NSError *))failure {
    NSString *urlStr = @"https://upload.api.weibo.com/2/statuses/upload.json";
    
    WLCAccessToken *access = [WLCAccessTool readAccessFromLocal];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"access_token"] = access.access_token;
    parameter[@"status"] = contents;
    
    NSMutableDictionary *dataParaDict = [NSMutableDictionary dictionary];
    NSData *picData = UIImageJPEGRepresentation(image, 0.6);
    dataParaDict[@"pic"] = picData;
    
    [WLCHTTPRequestTool HTTPRequestWithMethodWithPostMethodAndURL:urlStr parameters:parameter dataParams:dataParaDict success:^(id responseObject) {
        NSLog(@"发布成功");
    } failure:^(NSError *error) {
        NSLog(@"发布失败");
    }];
    

}

@end
