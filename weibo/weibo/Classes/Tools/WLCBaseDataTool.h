//
//  WLCBaseDataTool.h
//  weibo
//
//  Created by 王 on 16/2/29.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCBaseDataTool : NSObject

//请求网络数据,成功后将数据转成指定的模型
+ (void)HTTPRequestWithMethod: (NSString *)method andURL: (NSString *)urlString parameters: (NSDictionary *)parameters classs: (Class)classs success: (void (^)(id responseModel))success failure: (void (^)(NSError *error))failure;

@end
