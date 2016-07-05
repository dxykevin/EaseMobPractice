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
    
    NSLog(@"%@",NSHomeDirectory());
    
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

- (void)dealloc {
    
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

/*!
 @method
 @brief 好友请求被接受时的回调
 @discussion
 @param username 之前发出的好友请求被用户username接受了
 */
- (void)didAcceptedByBuddy:(NSString *)username {
    
    NSString *message = [NSString stringWithFormat:@"%@同意了你的好友请求",username];
    NSLog(@"%@",message);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"好友添加消息" message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}

/*!
 @method
 @brief 好友请求被拒绝时的回调
 @discussion
 @param username 之前发出的好友请求被用户username拒绝了
 */
- (void)didRejectedByBuddy:(NSString *)username {
    
    NSString *message = [NSString stringWithFormat:@"%@拒绝了你的好友请求",username];
    NSLog(@"%@",message);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"好友添加消息" message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}
@end
