//
//  WLCTitlePopMenuView.m
//  weibo
//
//  Created by 王 on 16/2/19.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCTitlePopMenuView.h"
#import "UIView+Frame.h"

@interface WLCTitlePopMenuView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation WLCTitlePopMenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //添加关闭的遮罩
        UIView *backview = [[UIView alloc]initWithFrame:ScreenBounds];
        backview.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backViewClicking)];
        [backview addGestureRecognizer:gesture];
        [self addSubview:backview];
        
        //添加弹出的背景图片
        UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 200)];
        backImage.centerX = ScreenWidth * 0.5;
        backImage.y = 64;
        backImage.image = [UIImage imageNamed:@"popover_background"];
        [self addSubview:backImage];
        
        //添加tableview
        UITableView *items = [[UITableView alloc]initWithFrame:CGRectMake(backImage.x, backImage.y + 10, backImage.width, backImage.height - 15)];
        items.backgroundColor = [UIColor clearColor];
        items.delegate = self;
        items.dataSource = self;
        [self addSubview:items];
        
        
        
    }
    
    return self;
}



- (void)backViewClicking {
    [self removeFromSuperview];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]init];
    }
    cell.textLabel.text = @"123";
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}



@end
