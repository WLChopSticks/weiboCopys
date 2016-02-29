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
#import "WLCStatusesCell.h"
#import "WLCHTTPRequestTool.h"
#import "WLCBaseDataTool.h"
#import "WLCStatusesResult.h"
#import "WLCHomeDataTool.h"


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
    
    [self.tableView registerClass:[WLCStatusesCell class] forCellReuseIdentifier:ID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //添加控件
    [self decorateUI];
    
    //获取个人信息
    [self getUserInfomation];
    
    //获取数据
    [self getLatestStatuses];
    
    //设置上拉下拉刷新
    [self refreshHeaderAndFooter];
    
    //获取未读微博数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:100 target:self selector:@selector(getUnreadMessageNumber) userInfo:nil repeats:YES];
//    [timer fire];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
    //设置预估行高
    self.tableView.estimatedRowHeight = 300;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
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
    

    WLCAccessToken *access = [WLCAccessTool readAccessFromLocal];
    
    [WLCHomeDataTool getUserInfoWithUid:access.uid success:^(WLCUser *result) {
        
        //获取用户名
        [self.titleBtn setTitle:result.screen_name forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults]setValue:result.screen_name forKey:@"screen_name"];
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}

//获取微博数据
- (void)getLatestStatuses {
    
    [WLCHomeDataTool getStatusesWithSinceId:[self.statusArray.firstObject id] maxId:0 success:^(WLCStatusesResult *result) {
        
        //获取微博内容
        NSArray *statusModel = [WLCStatuses mj_objectArrayWithKeyValuesArray:result.statuses];
        [self.statusArray insertObjects:statusModel atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statusModel.count)]];
        
        [self.tableView reloadData];
        
        [self showRefreshStatusesNumber:statusModel.count];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

- (void)getMoreStatuses {

    long long max = [self.statusArray.lastObject id] - 1;
    
    [WLCHomeDataTool getMoreStatusesWithSinceId:0 maxId:max success:^(WLCStatusesResult *result) {
        
        //获取微博内容
        NSArray *statusModel = [WLCStatuses mj_objectArrayWithKeyValuesArray:result.statuses];
        [self.statusArray addObjectsFromArray:statusModel];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];

}

//获取未读消息数
- (void)getUnreadMessageNumber {

    WLCAccessToken *access = [WLCAccessTool readAccessFromLocal];
    
    [WLCHomeDataTool getUnreadMessageNumberWithUid:access.uid success:^(WLCStatusesResult *result) {
        
        //获取未读微博数
        WLCUnreadMessage *unreadMessage = [WLCUnreadMessage mj_objectWithKeyValues:result.statuses];
                NSLog(@"%d",unreadMessage.status);
        
        
        if (unreadMessage.status != 0) {
            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unreadMessage.status];
        } else {
            self.tabBarItem.badgeValue = nil;
        }

    } failure:^(NSError *error) {
        
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

#pragma -mark 下拉刷新后提示更新了多少微博
- (void)showRefreshStatusesNumber: (NSInteger )number {
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    [tipLabel setTextColor:[UIColor whiteColor]];
    [tipLabel setFont:[UIFont systemFontOfSize:15]];
    //判断是否有更新的微博
    if (number == 0) {
        tipLabel.text = @"没有可更新的微博";
    }else {
        tipLabel.text = [NSString stringWithFormat:@"共更新%ld条微博",(long)number];
    }
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.backgroundColor = [UIColor orangeColor];
    [self.navigationController.view insertSubview:tipLabel belowSubview:self.navigationController.navigationBar];
    
    tipLabel.y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - tipLabel.height;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        tipLabel.transform = CGAffineTransformMakeTranslation(0, tipLabel.height);
    } completion:^(BOOL finished) {
       [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
           tipLabel.y -= tipLabel.height;
       } completion:^(BOOL finished) {
           [tipLabel removeFromSuperview];
       }];
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
    WLCStatusesCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    WLCStatuses *statuses = self.statusArray[indexPath.row];
    //传递数据
    cell.statuses = statuses;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self getUnreadMessageNumber];
}



//懒加载
-(NSMutableArray *)statusArray {
    if (_statusArray == nil) {
        _statusArray = [NSMutableArray array];
    }
    return _statusArray;
}

@end
