//
//  WLCTabBarController.m
//  weibo
//
//  Created by 王 on 16/2/18.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCTabBarController.h"
#import "WLCTabBar.h"
#import "WLCNavigationController.h"
#import "WLCHomeController.h"
#import "UITabBarItem+BadgeValueImage.h"
#import "WLCComposeView.h"

@interface WLCTabBarController ()<WLCtabBarDelegate>

@end

@implementation WLCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WLCTabBar *tabBar = [[WLCTabBar alloc]init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    //添加子控制器
    [self addChildViewControllers];
    


    
}

//添加子控制器
- (void)addChildViewControllers {
    
    WLCHomeController *homeVC = [[WLCHomeController alloc]init];
    [self addChildViewController:homeVC andImageName:@"tabbar_home" title:@"首页"];
    UITableViewController *messageVC = [[UITableViewController alloc]init];
    [self addChildViewController:messageVC andImageName:@"tabbar_message_center" title:@"消息"];
    UITableViewController *discoveryVC = [[UITableViewController alloc]init];
    [self addChildViewController:discoveryVC andImageName:@"tabbar_discover" title:@"发现"];
    UITableViewController *profileVC = [[UITableViewController alloc]init];
    [self addChildViewController:profileVC andImageName:@"tabbar_profile" title:@"我"];
    
}
- (void)addChildViewController:(UIViewController *)childController andImageName: (NSString *)imageName title:(NSString *)title {
    WLCNavigationController *nav = [[WLCNavigationController alloc]initWithRootViewController:childController];
    childController.tabBarItem.image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.title = title;
    [self addChildViewController:nav];
    
    //将tabbar文字变为橙色
//    [self.tabBar setTintColor:[UIColor orangeColor]];
    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor orangeColor]};
    [childController.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    //设置badgeValueImage
    childController.tabBarItem.badgeImageName = @"main_badge";
}

//实现点击创作按钮的代理方法
- (void)tabBar:(WLCTabBar *)tabBar didSelectComposeBtn:(UIButton *)composeBtn {
    
    WLCComposeView *composeView = [[WLCComposeView alloc]init];
    composeView.tabBarVC = self;

    [[UIApplication sharedApplication].keyWindow addSubview:composeView];
    
    [composeView showAnimation];
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
