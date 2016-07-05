//
//  AppDelegate.m
//  EaseMobCustomUI_Demo
//
//  Created by HoldCourt on 16/7/4.
//  Copyright © 2016年 HoldCourt. All rights reserved.
//

#import "AppDelegate.h"
#import "EaseMob.h"
#define kAppKey @"dxykevin#hcdemo"
@interface AppDelegate () <EMChatManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[EaseMob sharedInstance] registerSDKWithAppKey:kAppKey apnsCertName:nil otherConfig:@{kSDKConfigEnableConsoleLogger:@NO}];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    if ([[EaseMob sharedInstance].chatManager isAutoLoginEnabled]) {
        self.window.rootViewController = [UIStoryboard storyboardWithName:@"Main" bundle:nil].instantiateInitialViewController;
    }
    return YES;
}

#pragma mark - EMChatManagerDelegate
/** 自动登录的回调 */
- (void)didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error {
    
    if (!error) {
        NSLog(@"自动登录成功---%@",loginInfo);
    } else {
        NSLog(@"自动登录失败---%@",error);
    }
}
// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

// 申请处理时间
- (void)applicationWillTerminate:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

@end
