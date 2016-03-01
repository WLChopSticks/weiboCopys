//
//  WLCTitleView.m
//  weibo
//
//  Created by 王 on 16/3/1.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCTitleView.h"
#import "WLCUser.h"
#import "WLCAccessTool.h"

@implementation WLCTitleView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //布局
        [self decorateUI];
    }
    
    return self;
}

#pragma -mark 布局
- (void)decorateUI {
    
    UILabel *title = [[UILabel alloc]init];
    title.text = @"发微博";
    title.font = [UIFont systemFontOfSize:18];
    title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:title];
    UILabel *name = [[UILabel alloc]init];
    //发微博名字对应微博名字
    NSString *screenName = [[NSUserDefaults standardUserDefaults]valueForKey:@"screen_name"];
    name.text = screenName;
    name.textColor = [UIColor grayColor];
    name.font = [UIFont systemFontOfSize:15];
    name.textAlignment = NSTextAlignmentCenter;
    [self addSubview:name];
    
    //设置toolbar
    
    
    
    //布局
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(self.height * 0.5);
    }];
    
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(self.height * 0.5);
    }];
}

@end
