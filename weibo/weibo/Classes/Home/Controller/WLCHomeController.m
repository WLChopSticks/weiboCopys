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
#import "WLCAccessTool.h"
#import "WLCAccessToken.h"
#import "MJExtension.h"
#import "WLCUser.h"
#import "WLCStatuses.h"
#import "MJRefresh.h"
#import "WLCUnreadMessage.h"


#define ID @"statusCell"

@interface WLCHomeController ()<titlePopMenuViewDelegate>

@property (strong, nonatomic) WLCTitleButton *titleBtn;
@property (strong, nonatomic) WLCTitlePopMenuView *titlePopMenuView;
@property (strong, nonatomic) UIImageView *backImage;
@property (strong, nonatomic) NSMutableArray *statusArray;

@end

@implementation WLCHomeController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    //添加控件
    [self decorateUI];
    
    //获取个人信息
    [self getUserInfomation];
    
    //获取数据
    [self getLatestStatuses];
    
    //设置上拉下拉刷新
    [self refreshHeaderAndFooter];
    
    //获取未读微博数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getUnreadMessageNumber) userInfo:nil repeats:YES];
    [timer fire];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void)decorateUI {

    //添加导航栏左右两端的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageNameAndItsHighlight:@"navigationbar_friendsearch" target:self action:@selector(friendsearchBtnClicking)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageNameAndItsHighlight:@"navigationbar_pop" target:self action:@selector(popBtnClicking)];
    
    //修改titleView为可点击
    WLCTitleButton *titleBtn = [WLCTitleButton buttonWithType:UIButtonTypeCustom];
    NSString *screenName = [[NSUserDefaults standardUserDefaults]valueForKey:@"screen_name"];
    if (screenName == nil) {
        [titleBtn setTitle:@"我的首页" forState:UIControlStateNormal];
    } else {
        [titleBtn setTitle:screenName forState:UIControlStateNormal];
    }
    [titleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
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
    self.titleBtn.selected = !self.titleBtn.selected;
    //增加一个View实现点击取消弹出界面
    WLCTitlePopMenuView *titlePopMenuView = [[WLCTitlePopMenuView alloc]initWithFrame:ScreenBounds];
    titlePopMenuView.delegate = self;
    self.titlePopMenuView = titlePopMenuView;
    [self.view.window addSubview:titlePopMenuView];

}

//实现titlePopMenuView代理方法
-(void)titlePopMenuView:(WLCTitlePopMenuView *)titlePopMenuView didClickBackImage:(UIView *)backImage {
    self.titleBtn.selected = !self.titleBtn.selected;
}

#pragma -mark 获取网络端数据
//获取个人信息
- (void)getUserInfomation {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = @"https://api.weibo.com/2/users/show.json";
    WLCAccessToken *access = [WLCAccessTool readAccessFromLocal];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"access_token"] = access.access_token;
    parameter[@"uid"] = access.uid;
    
    [manager GET:urlStr parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        //获取用户名
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        WLCUser *user = [WLCUser mj_objectWithKeyValues:responseDict];
        [self.titleBtn setTitle:user.screen_name forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults]setValue:user.screen_name forKey:@"screen_name"];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

//获取微博数据
- (void)getLatestStatuses {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = @"https://api.weibo.com/2/statuses/home_timeline.json";
    WLCAccessToken *access = [WLCAccessTool readAccessFromLocal];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"access_token"] = access.access_token;
    parameter[@"since_id"] = @([self.statusArray.firstObject id]);
    NSLog(@"%@",access.access_token);
    [manager GET:urlStr parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        //获取微博内容
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        NSArray *statusTem= responseDict[@"statuses"];
        NSArray *statusModel = [WLCStatuses mj_objectArrayWithKeyValuesArray:statusTem];
        [self.statusArray insertObjects:statusModel atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statusModel.count)]];
//        [self.statusArray addObjectsFromArray:statusModel];
        
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)getMoreStatuses {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = @"https://api.weibo.com/2/statuses/home_timeline.json";
    WLCAccessToken *access = [WLCAccessTool readAccessFromLocal];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"access_token"] = access.access_token;
    //不获取相同内容的微博
    parameter[@"max_id"] = @([self.statusArray.lastObject id] - 1);
    NSLog(@"%@",access.access_token);
    [manager GET:urlStr parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        //获取微博内容
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        NSArray *statusTem= responseDict[@"statuses"];
        NSArray *statusModel = [WLCStatuses mj_objectArrayWithKeyValuesArray:statusTem];
        [self.statusArray addObjectsFromArray:statusModel];
        
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

//获取未读消息数
- (void)getUnreadMessageNumber {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = @"https://rm.api.weibo.com/2/remind/unread_count.json";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    WLCAccessToken *access = [WLCAccessTool readAccessFromLocal];
    parameters[@"access_token"] = access.access_token;
    parameters[@"uid"] = access.uid;
    
    [manager GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        //获取未读微博数
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        WLCUnreadMessage *unreadMessage = [WLCUnreadMessage mj_objectWithKeyValues:responseDict];
        NSLog(@"%d",unreadMessage.status);
        if (unreadMessage.status != 0) {
            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unreadMessage.status];
        } else {
            self.tabBarItem.badgeValue = nil;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma -mark 设置上拉下拉刷新
- (void)refreshHeaderAndFooter {
    __unsafe_unretained UITableView *tableView = self.tableView;
    
    // 下拉刷新
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //获取 新的微博
        [self getLatestStatuses];

        // 结束刷新
        [tableView.mj_header endRefreshing];
        [self.tableView reloadData];

    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 结束刷新
        [self getMoreStatuses];
        [self.tableView reloadData];
        [tableView.mj_footer endRefreshing];

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    WLCStatuses *statuses = self.statusArray[indexPath.row];
    
    cell.textLabel.text = statuses.text;
    
//    cell.textLabel.text = statuses.text;
    
    // Configure the cell...
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self getUnreadMessageNumber];
}

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

//懒加载
-(NSMutableArray *)statusArray {
    if (_statusArray == nil) {
        _statusArray = [NSMutableArray array];
    }
    return _statusArray;
}

@end
