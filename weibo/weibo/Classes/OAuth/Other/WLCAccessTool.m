//
//  WLCAccessTool.m
//  weibo
//
//  Created by 王 on 16/2/23.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCAccessTool.h"
#import "WLCAccessToken.h"

@implementation WLCAccessTool

+(void)saveAccessToLocal: (WLCAccessToken *)access {
    //存储获得到的信息
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [path stringByAppendingPathComponent:@"access"];
    NSLog(@"%@",path);
    [NSKeyedArchiver archiveRootObject:access toFile:filePath];
}

+(WLCAccessToken *)readAccessFromLocal {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [path stringByAppendingPathComponent:@"access"];
    WLCAccessToken *access = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    if (access == nil) {
        
        return nil ;
    }
    NSDate *date = [access.createDate dateByAddingTimeInterval:access.expires_in];
    NSDate *currentDate = [NSDate date];
    if ([date compare:currentDate] == NSOrderedAscending) {
        
        return nil;
    }
    
    return access;
    
}

@end
