//
//  WLCEmotionListView.m
//  weibo
//
//  Created by 王 on 16/3/2.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCEmotionListView.h"

@implementation WLCEmotionListView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        [self decorateUI];
    }
    
    return self;
}

#pragma -mark 布局
- (void)decorateUI {
    self.backgroundColor = randomColor;
}

@end
