//
//  WLCBaseDataTool.m
//  weibo
//
//  Created by 王 on 16/2/29.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCBaseDataTool.h"
#import "WLCHTTPRequestTool.h"
#import "MJExtension.h"

@implementation WLCBaseDataTool

+(void)HTTPRequestWithMethod:(NSString *)method andURL:(NSString *)urlString parameters:(NSDictionary *)parameters classs:(Class)classs success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    //get请求
    if ([method isEqualToString:@"GET"]) {
        
        [WLCHTTPRequestTool HTTPRequestWithMethod:@"GET" andURL:urlString parameters:parameters success:^(id responseObject) {
            //如果成功,执行success回调
            if (success) {
                //字典转模型
                id result = [[classs alloc]init];
                [result mj_setKeyValues:responseObject];
                success(result);
            }
        } failure:^(NSError *error) {
            //如果失败,执行failure回调
            if (failure) {
                failure(error);
            }
        }];
    }
    
        
    //POST请求
    if ([method isEqualToString:@"POST"]) {
        [WLCHTTPRequestTool HTTPRequestWithMethod:@"POST" andURL:urlString parameters:parameters success:^(id responseObject) {
            //如果成功,执行success回调
            if (success) {
                //字典转模型
                id result = [[classs alloc]init];
                [result mj_setKeyValues:responseObject];
                success(result);
            }
        } failure:^(NSError *error) {
            //如果失败,执行failure回调
            if (failure) {
                failure(error);
            }
        }];
    }

}

@end
