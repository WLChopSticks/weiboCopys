//
//  WLCOAuthController.m
//  weibo
//
//  Created by 王 on 16/2/20.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCOAuthController.h"
#import "AFHTTPSessionManager.h"
#import "WLCNewFeatureController.h"
#import "WLCAccessToken.h"
#import "MJExtension.h"
#import "WLCTabBarController.h"
#import "WLCAccessTool.h"



#define APP_KEY @"3083161321"
#define APP_SECRET @"27d7a4885fc73246cd1a71e3c836369b"
#define REDIRECT_URL @"https://www.baidu.com"

@interface WLCOAuthController ()<UIWebViewDelegate>

@end

@implementation WLCOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

     //判断是否需要进入授权登陆页面
    [self enterHomeOrLogInView];
    
}

//判断是否需要进入授权页面
- (void)enterHomeOrLogInView {
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
//    NSString *filePath = [path stringByAppendingPathComponent:@"access"];
//    WLCAccessToken *access = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//    
//    if (access == nil) {
//        [self logInView];
//        return ;
//    }
//    NSDate *date = [access.createDate dateByAddingTimeInterval:access.expires_in];
//    NSDate *currentDate = [NSDate date];
//    if ([date compare:currentDate] != NSOrderedAscending) {
//        [self logInView];
//        return;
//    }
    WLCAccessToken *access = [WLCAccessTool readAccessFromLocal];
    if (access == nil) {
        [self logInView];
        return ;
    }
    
    WLCTabBarController *tabBarVC = [[WLCTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
    
}

- (void)logInView {
   
    UIWebView *webView = [[UIWebView alloc]initWithFrame:ScreenBounds];
    webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",APP_KEY,REDIRECT_URL]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    NSString *requestURLStr = request.URL.absoluteString;
    
    //点击取消按钮
    if ([requestURLStr hasSuffix:@"error_code=21330"]) {
        WLCNewFeatureController *newFeatureVC = [[WLCNewFeatureController alloc]init];
        [UIApplication sharedApplication].keyWindow.rootViewController = newFeatureVC;
        return NO;
    }
    
    //点击授权按钮
    if ([requestURLStr hasPrefix:REDIRECT_URL]) {
        
        NSRange range = [requestURLStr rangeOfString:@"code="];
        NSString *code = [requestURLStr substringFromIndex:range.location + range.length];
        NSLog(@"%@",code);
        [self getAccessTokenWithCode:code];
        
        return NO;
    }
    
    return YES;

}


//获取access_token
- (void)getAccessTokenWithCode: (NSString *)code {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //增加支持的text/plain格式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript", nil];

    //请求地址
    NSString *accessTokenURL = @"https://api.weibo.com/oauth2/access_token";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"client_id"] = APP_KEY;
    parameters[@"client_secret"] = APP_SECRET;
    parameters[@"grant_type"] = @"authorization_code";
    parameters[@"code"] = code;
    parameters[@"redirect_uri"] = REDIRECT_URL;
    
    
    [manager POST:accessTokenURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *responseDict = (NSDictionary *)responseObject;
    
        
//        WLCAccessToken *access = [[WLCAccessToken alloc]init];
        WLCAccessToken *access = [WLCAccessToken mj_objectWithKeyValues:responseDict];
//        [access setValuesForKeysWithDictionary:responseDict];
//        NSLog(@"%@",access.access_token);
//        //存储获得到的信息
//        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
//        NSString *filePath = [path stringByAppendingPathComponent:@"access"];
//        NSLog(@"%@",path);
//        [NSKeyedArchiver archiveRootObject:access toFile:filePath];
        [WLCAccessTool saveAccessToLocal:access];
        
        //进入首页
        WLCTabBarController *tabBarVC = [[WLCTabBarController alloc]init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
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
