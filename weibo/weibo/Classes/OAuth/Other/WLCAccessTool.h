//
//  WLCAccessTool.h
//  weibo
//
//  Created by 王 on 16/2/23.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WLCAccessToken;
@interface WLCAccessTool : NSObject

//归档
+(void)saveAccessToLocal: (WLCAccessToken *)access;

//解档
+(WLCAccessToken *)readAccessFromLocal;


@end
