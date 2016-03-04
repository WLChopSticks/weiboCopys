//
//  WLCHTTPRequestTool.m
//  weibo
//
//  Created by 王 on 16/2/29.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCHTTPRequestTool.h"
#import "AFNetworking.h"

@implementation WLCHTTPRequestTool

+(void)HTTPRequestWithMethod:(NSString *)method andURL:(NSString *)urlString parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    //get请求
    if ([method isEqualToString:@"GET"]) {
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //如果成功,执行success回调
            if (success) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //如果失败,执行failure回调
            if (failure) {
                failure(error);
            }
        }];
    }
    
    //POST请求
    if ([method isEqualToString:@"POST"]) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //如果成功,执行success回调
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //如果失败,执行failure回调
            if (failure) {
                failure(error);
            }
        }];
    }

}


+(void)HTTPRequestWithMethodWithPostMethodAndURL:(NSString *)urlString parameters:(NSDictionary *)parameters dataParams:(NSDictionary *)dataParams success:(void (^)(id))success failure:(void (^)(NSError *))failure {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [dataParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [formData appendPartWithFileData:obj name:key fileName:@"hehe" mimeType:@"image/jpeg"];
        }];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
    



}

@end
