//
//  WLCComposeBtnModel.h
//  weibo
//
//  Created by 王 on 16/2/29.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCComposeBtnModel : NSObject

@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *title;


+ (instancetype)composeBtnModelWithDict: (NSDictionary *)dict;

@end
