//
//  WLCHTTPRequestTool.h
//  weibo
//
//  Created by 王 on 16/2/29.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCHTTPRequestTool : NSObject

+ (void)HTTPRequestWithMethod: (NSString *)method andURL: (NSString *)urlString parameters: (NSDictionary *)parameters success:(void (^)(id responseObject))success failure: (void (^)(NSError *error))failure;

//需要拼接图片的post请求
+ (void)HTTPRequestWithMethodWithPostMethodAndURL:(NSString *)urlString parameters:(NSDictionary *)parameters dataParams:(NSDictionary *)dataParams success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


@end
