//
//  XYAddFriendViewController.m
//  EaseMobCustomUI_Demo
//
//  Created by HoldCourt on 16/7/5.
//  Copyright © 2016年 HoldCourt. All rights reserved.
//

#import "XYAddFriendViewController.h"
#import "EaseMob.h"
@interface XYAddFriendViewController () <EMChatManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *addFriendTF;

@end

@implementation XYAddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

/** 添加好友 */
- (IBAction)addFriend:(id)sender {
    
    /** 1.获取要添加好友的名字 */
    NSString *userName = self.addFriendTF.text;
    /** 2.向服务器发送添加好友的请求 */
    NSString *message = [NSString stringWithFormat:@"我是%@\n我想加你为好友",[[EaseMob sharedInstance].chatManager loginInfo][@"username"]];;
    NSLog(@"添加好友-%@",message);
    EMError *error = nil;
    [[EaseMob sharedInstance].chatManager addBuddy:userName message:message error:&error];
    if (error) {
        NSLog(@"添加好友有问题--%@",error);
    } else {
        NSLog(@"添加好友没有问题");
    }
}

#pragma mark - EMChatManagerDelegate


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
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
