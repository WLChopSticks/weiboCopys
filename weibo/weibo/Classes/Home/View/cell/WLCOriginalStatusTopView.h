//
//  WLCOriginalStatusTopView.h
//  weibo
//
//  Created by 王 on 16/2/25.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLCUser.h"
#import "WLCStatuses.h"

@interface WLCOriginalStatusTopView : UIView

@property (strong, nonatomic) WLCUser *user;

@property (strong, nonatomic) WLCStatuses *statuses;

@end
