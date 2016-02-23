//
//  WLCHomeController.m
//  weibo
//
//  Created by 王 on 16/2/19.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCHomeController.h"
#import "UIBarButtonItem+Extention.h"
#import "WLCTitleButton.h"
#import "WLCFriendsearchController.h"
#import "UIView+Frame.h"
#import "WLCTitlePopMenuView.h"
#import "AFNetworking.h"


@interface WLCHomeController ()

@property (strong, nonatomic) WLCTitleButton *titleBtn;
@property (strong, nonatomic) WLCTitlePopMenuView *titlePopMenuView;
@property (strong, nonatomic) UIImageView *backImage;


@end

@implementation WLCHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //添加控件
    [self decorateUI];
    
    //获取数据
    
    
}

- (void)decorateUI {

    //添加导航栏左右两端的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageNameAndItsHighlight:@"navigationbar_friendsearch" target:self action:@selector(friendsearchBtnClicking)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageNameAndItsHighlight:@"navigationbar_pop" target:self action:@selector(popBtnClicking)];
    
    //修改titleView为可点击
    WLCTitleButton *titleBtn = [WLCTitleButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitle:@"我的首页" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(titleBtnClicking) forControlEvents:UIControlEventTouchUpInside];
    [titleBtn sizeToFit];
    self.titleBtn = titleBtn;

    self.navigationItem.titleView = titleBtn;

}

- (void)friendsearchBtnClicking {
    NSLog(@"friendsearch点击了");
    WLCFriendsearchController *friendsearchVC = [[WLCFriendsearchController alloc]init];
    friendsearchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:friendsearchVC animated:YES];
}
- (void)popBtnClicking {
    NSLog(@"pop点击了");
}
- (void)titleBtnClicking {
    //增加一个View实现点击取消弹出界面
    WLCTitlePopMenuView *titlePopMenuView = [[WLCTitlePopMenuView alloc]initWithFrame:ScreenBounds];
    self.titlePopMenuView = titlePopMenuView;
    [self.view.window addSubview:titlePopMenuView];

}

//获取微博数据
- (void)getStatuese {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/2/statuses/home_timeline.json"];
    
//    NSString *parameter =
    
//    manager GET:<#(nonnull NSString *)#> parameters:<#(nullable id)#> progress:<#^(NSProgress * _Nonnull downloadProgress)downloadProgress#> success:<#^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)success#> failure:<#^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)failure#>
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
