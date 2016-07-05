//
//  XYConversationViewController.m
//  EaseMobCustomUI_Demo
//
//  Created by HoldCourt on 16/7/5.
//  Copyright © 2016年 HoldCourt. All rights reserved.
//

#import "XYConversationViewController.h"
#import "EaseMob.h"
@interface XYConversationViewController () <EMChatManagerDelegate,EMChatManagerBuddyDelegate>

@end

@implementation XYConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 监听网络状态 */
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

#pragma mark - EMChatManagerDelegate
/** 网络连接状态变化发生的回调 */
- (void)didConnectionStateChanged:(EMConnectionState)connectionState {
    
    if (connectionState == eEMConnectionDisconnected) {
        NSLog(@"网络未连接");
        self.title = @"网络未连接";
    } else {
        NSLog(@"网络连接成功");
        self.title = @"网络连接成功";
    }
}

- (void)willAutoReconnect {
    
    NSLog(@"将自动重新连接");
    self.title = @"连接中...";
}

- (void)didAutoReconnectFinishedWithError:(NSError *)error {
    
    if (!error) {
        NSLog(@"自动重新连接成功");
        self.title = @"会话";
    } else {
        NSLog(@"自动连接失败---%@",error);
    }
}

- (void)dealloc {
    
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

/*!
 @method
 @brief 接收到好友请求时的通知
 @discussion
 @param username 发起好友请求的用户username
 @param message  收到好友请求时的say hello消息
 */
- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message {
    
    NSLog(@"接收到好友请求时的通知---%@ message == %@",username,message);
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

/*!
 @method
 @brief 接受好友请求成功的回调
 @discussion
 @param username 登录用户接受了"username发过来的好友请求"成功的回调
 */
- (void)didAcceptBuddySucceed:(NSString *)username {
    
}

/*!
 @method
 @brief 登录的用户被好友从列表中删除了
 @discussion
 @param username 删除的好友username
 */
- (void)didRemovedByBuddy:(NSString *)username {
    
    
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
