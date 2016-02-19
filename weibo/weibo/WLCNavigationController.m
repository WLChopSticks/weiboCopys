//
//  WLCNavigationController.m
//  weibo
//
//  Created by 王 on 16/2/19.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCNavigationController.h"
#import "UIBarButtonItem+Extention.h"

@interface WLCNavigationController ()

@end

@implementation WLCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    


}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //设置navigation上的东西,需要通过自己本身的控制器设置
    viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageNameAndItsHighlight:@"navigationbar_back" target:self action:@selector(returnBtnClicking)];
    
    
    [super pushViewController:viewController animated:animated];
    

    
}

- (void)returnBtnClicking {
    [self popViewControllerAnimated:YES];
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
