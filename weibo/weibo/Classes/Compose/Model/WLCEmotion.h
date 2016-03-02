//
//  WLCEmotion.h
//  weibo
//
//  Created by 王 on 16/3/2.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCEmotion : NSObject

//表情对应中文(简体)
@property (copy, nonatomic) NSString *chs;
//表情对应中文
@property (copy, nonatomic) NSString *cht;
//表情图片
@property (copy, nonatomic) NSString *png;
//表情类型
@property (copy, nonatomic) NSString *type;

@end
