//
//  AppDelegate.m
//  weibo
//
//  Created by 王 on 16/2/18.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//3083161321
//App Secret：27d7a4885fc73246cd1a71e3c836369b

#import "AppDelegate.h"
#import "WLCTabBarController.h"
#import <KSCrash/KSCrashInstallationStandard.h>
#import "WLCNewFeatureController.h"
#import "WLCOAuthController.h"
#import "WLCAccessToken.h"
#import "SDImageCache.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]init];
    
    WLCTabBarController *tabBarVC = [[WLCTabBarController alloc]init];
    
    WLCNewFeatureController *vc = [[WLCNewFeatureController alloc]init];
    
    //检测版本号
    NSString *versionStr = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    CGFloat version = versionStr.floatValue;
    //读取版本号
    NSString *lastVersionStr = [[NSUserDefaults standardUserDefaults]valueForKey:@"version"];
    CGFloat lastVersion = lastVersionStr.floatValue;
    if (version > lastVersion) {
        self.window.rootViewController = vc;
    }else {
        //是否已经登录
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        NSString *filePath = [path stringByAppendingPathComponent:@"access"];
        WLCAccessToken *access = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        
        if (access == nil) {
             WLCOAuthController *oauth = [[WLCOAuthController alloc]init];
             self.window.rootViewController = oauth;

        }else {
            //已经获取令牌 可以登录
            self.window.rootViewController = tabBarVC;
        }
        
    }
    
    //存储版本号
    [[NSUserDefaults standardUserDefaults]setValue:versionStr forKey:@"version"];
//    NSLog(@"%@",versionStr);
    

    [self.window makeKeyAndVisible];
    
//    bug检测
//    KSCrashInstallationStandard* installation = [KSCrashInstallationStandard sharedInstance];
//    installation.url = [NSURL URLWithString:@"https://collector.bughd.com/kscrash?key=03f259f078426c1e98d7f401d36017c1"];
//    [installation install];
//    [installation sendAllReportsWithCompletion:nil];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[SDImageCache sharedImageCache]clearDisk];
}

@end
