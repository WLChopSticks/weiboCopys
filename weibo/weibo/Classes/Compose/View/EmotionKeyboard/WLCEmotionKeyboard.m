//
//  WLCEmotionKeyboard.m
//  weibo
//
//  Created by 王 on 16/3/1.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCEmotionKeyboard.h"

@implementation WLCEmotionKeyboard

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self decorateUI];
    }
    
    return self;
}

#pragma -mark 布局
- (void)decorateUI {
    self.backgroundColor = randomColor;
    
    self.size = CGSizeMake(ScreenWidth, 200);
    
    
}

@end
