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

@end
