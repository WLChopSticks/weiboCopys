//
//  WLCUser.m
//  weibo
//
//  Created by 王 on 16/2/23.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCUser.h"

@implementation WLCUser

-(UIImage *)mbrankImage {
    if (self.mbrank > 0 && self.mbrank < 7) {
        
        NSString *imageStr = [NSString stringWithFormat:@"common_icon_membership_level%d",self.mbrank];
        UIImage *image = [UIImage imageNamed:imageStr];
        return image;
    }
    return nil;
}

-(UIImage *)verifiedImage {
    switch (self.verified_type) {
        case -1:
            return nil;
            break;
        case 0:
            return [UIImage imageNamed:@"avatar_vip"];
        case 2:
        case 3:
        case 5:
            return [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case 220:
            return [UIImage imageNamed:@"avatar_grassroot"];
            
        default:
            return nil;
            break;
    }
}

@end
