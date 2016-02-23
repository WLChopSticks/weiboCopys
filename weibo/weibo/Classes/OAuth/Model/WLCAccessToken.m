//
//  WLCAccessToken.m
//  weibo
//
//  Created by 王 on 16/2/22.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCAccessToken.h"


@implementation WLCAccessToken

//归解档代理方法
-(void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.remind_in forKey:@"remind_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeInteger:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.createDate forKey:@"createDate"];
    
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.remind_in = [aDecoder decodeObjectForKey:@"remind_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.expires_in = [aDecoder decodeIntegerForKey:@"expires_in"];
        self.createDate = [aDecoder decodeObjectForKey:@"createDate"];
        
    }
    
    return self;
}

//存储得到令牌的时间
- (void)setAccess_token:(NSString *)access_token {
    _access_token = access_token;

    self.createDate = [NSDate date];
}

@end
