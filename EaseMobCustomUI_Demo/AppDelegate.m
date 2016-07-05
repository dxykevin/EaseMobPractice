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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[EaseMob sharedInstance] registerSDKWithAppKey:kAppKey apnsCertName:nil otherConfig:@{kSDKConfigEnableConsoleLogger:@NO}];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
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
