//
//  XYLoginViewController.m
//  EaseMobCustomUI_Demo
//
//  Created by HoldCourt on 16/7/5.
//  Copyright © 2016年 HoldCourt. All rights reserved.
//

#import "XYLoginViewController.h"
#import "EaseMob.h"
@interface XYLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@end

@implementation XYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 注册 */
- (IBAction)register:(id)sender {
    
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:self.userNameTF.text password:self.pwdTF.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
        if (!error) {
            NSLog(@"注册成功---%@",username);
        } else {
            NSLog(@"注册失败---%@",error);
        }
    } onQueue:dispatch_get_main_queue()];
}

/** 登录 */
- (IBAction)login:(id)sender {
    
    NSString *message = @"";
    
    if (self.pwdTF.text.length == 0 && self.userNameTF.text.length == 0) {
        message = @"请输入账号和密码";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    } else if (self.pwdTF.text.length == 0) {
        message = @"请输入密码";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    } else if (self.userNameTF.text.length == 0) {
        message = @"请输入账号";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.userNameTF.text password:self.pwdTF.text completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error) {
            NSLog(@"登录成功---%@",loginInfo);
        } else {
            NSLog(@"登录失败---%@",error);
        }
    } onQueue:dispatch_get_main_queue()];
    
    /** 设置自动登录 */
    
    /** 来到主界面 */
    self.view.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
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
