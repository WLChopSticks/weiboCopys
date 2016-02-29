//
//  WLCComposeBtnModel.m
//  weibo
//
//  Created by 王 on 16/2/29.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCComposeBtnModel.h"

@implementation WLCComposeBtnModel

+(instancetype)composeBtnModelWithDict:(NSDictionary *)dict {

    WLCComposeBtnModel *model = [[WLCComposeBtnModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

@end
