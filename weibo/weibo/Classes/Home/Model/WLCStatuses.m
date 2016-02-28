//
//  WLCStatuses.m
//  weibo
//
//  Created by 王 on 16/2/23.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCStatuses.h"

@implementation WLCStatuses

//取出图片url
- (void)setPic_urls:(NSArray *)pic_urls {
    _pic_urls = pic_urls;
    
    if (pic_urls == nil) {
        return;
    }
    NSMutableArray *urlTem = [NSMutableArray array];
    for (NSDictionary *dict in pic_urls) {
        NSString *urlStr = dict[@"thumbnail_pic"];
        NSURL *url = [NSURL URLWithString:urlStr];
        [urlTem addObject:url];
    }

    self.picturesURLs = urlTem;
}


//显示来源
- (void)setSource:(NSString *)source {
    _source = source;
    
    if (source.length != 0) {
        //截取来源的字符串
        NSRange front = [source rangeOfString:@"nofollow\">"];
        NSRange last = [source rangeOfString:@"</a>"];
        
        NSInteger location = front.location + front.length;
        NSInteger length = last.location - location;
        
        NSString *realSource = [source substringWithRange:NSMakeRange(location, length)];
        _source = realSource;
        return;
    }
   
//    NSLog(@"%@",realSource);
    _source = @"未知";
}

//更改时间格式
-(NSString *)created_at {
//    _created_at = @"Tue Feb 27 15:12:48 +0800 2016";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss z yyyy";

    NSDate *createdDate = [formatter dateFromString:_created_at];

    //如果不是当年发送的微博,显示全部时间
    if (![self isWeiboCreatedAtThisYear:createdDate]) {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        return [formatter stringFromDate:createdDate];
    }
    //如果不是当天的,从月开始显示信息
    if (![self isWeiboCreatedOnToday:createdDate]) {
        if ([self isWeiboCreatedOnYesterday:createdDate]) {
            formatter.dateFormat = @"HH:mm";
            return [NSString stringWithFormat:@"昨天%@",[formatter stringFromDate:createdDate]];
        }
        formatter.dateFormat = @"MM-dd HH:mm";
        return [formatter stringFromDate:createdDate];
    }
    
    NSDate *result = [createdDate dateByAddingTimeInterval:60];
    //判断是否是1分钟之内的微博
    if ([result compare:[NSDate date]] == NSOrderedDescending) {
        return @"刚刚";
    } else {
        result = [createdDate dateByAddingTimeInterval:3600];
        NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:createdDate];
        if ([result compare:[NSDate date]] == NSOrderedDescending) {
            NSInteger calculateResult = timeInterval / 60;
            return [NSString stringWithFormat:@"%ld分钟前",calculateResult];
        } else {
            NSInteger calculateResult = timeInterval / 3600;
            return [NSString stringWithFormat:@"%ld小时前",calculateResult];

        }
    }

}

//判断发微博的时间是不是今年
- (BOOL)isWeiboCreatedAtThisYear:(NSDate *)createdDate {
    
    return [self judgeTimeWithDateFormatter:@"yyyy" andDate:createdDate];

}

//判断发微博的时间是不是当天
- (BOOL)isWeiboCreatedOnToday:(NSDate *)createdDate {
    
    return [self judgeTimeWithDateFormatter:@"MM dd" andDate:createdDate];

}
//判断发微博的时间是不是前一天
- (BOOL)isWeiboCreatedOnYesterday:(NSDate *)createdDate {

    //获取当前时间的日期day已经微博发布的时间day,相减
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger result = [calendar component:NSCalendarUnitDay fromDate:createdDate];
    NSInteger currentResult = [calendar component:NSCalendarUnitDay fromDate:[NSDate date]];
//    NSLog(@"判断是不是昨天%ld",result);
    return currentResult - result ==1;
    
}

//根据指定的格式,判断时间是否相等
- (BOOL)judgeTimeWithDateFormatter: (NSString *)dateFormatter andDate: (NSDate *)useDate {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = dateFormatter;
    NSString *currentDateStr = [formatter stringFromDate:currentDate];
    NSString *useDateStr = [formatter stringFromDate:useDate];
    
    
    return [currentDateStr isEqualToString:useDateStr];
}



@end
