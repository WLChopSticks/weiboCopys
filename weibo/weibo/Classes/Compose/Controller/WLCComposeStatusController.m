//
//  WLCComposeStatusController.m
//  weibo
//
//  Created by 王 on 16/2/29.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCComposeStatusController.h"

@interface WLCComposeStatusController ()

@end

@implementation WLCComposeStatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = randomColor;
    
    [self decorateUI];
    // Do any additional setup after loading the view.
}


#pragma -mark 布局
- (void)decorateUI {

    UIBarButtonItem *returnBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(returnBtnClicking)];
    returnBtn.tintColor = [UIColor orangeColor];
    self.navigationItem.leftBarButtonItem = returnBtn;
    
    UIBarButtonItem *sendBtn = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendBtnClicking)];
    sendBtn.tintColor = [UIColor orangeColor];
    sendBtn.enabled = NO;
    self.navigationItem.rightBarButtonItem = sendBtn;
    
}


//返回按钮点击
- (void)returnBtnClicking {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendBtnClicking {
    NSLog(@"发送点击了");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
