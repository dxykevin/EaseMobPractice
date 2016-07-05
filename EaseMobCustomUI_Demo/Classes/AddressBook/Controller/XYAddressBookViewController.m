//
//  XYAddressBookViewController.m
//  EaseMobCustomUI_Demo
//
//  Created by HoldCourt on 16/7/5.
//  Copyright © 2016年 HoldCourt. All rights reserved.
//

#import "XYAddressBookViewController.h"
#import "EaseMob.h"
@interface XYAddressBookViewController () <EMChatManagerDelegate>
@property (nonatomic,strong) NSArray *buddylist;
@end

@implementation XYAddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
#warning 好友列表buddylist需要在自动登录成功后才有值
    /** 获取好友列表数据
     1.好友列表buddylist需要在自动登录成功后才有值
     2.buddylist的数据是从本地数据库获取
     3.如果从服务器获取好友列表,调用[[EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error)
     4.如果当前有添加好友请求 环信SDK内部会往数据库的buddy表添加好友记录
     5.如果程序删除或者用户第一次登录 buddyList表是没有记录的
        解决方案:
        1.要从服务器获取好友列表记录
        2.用户第一次登录后,自动从服务器获取好友列表
     */

    
    self.buddylist = [[EaseMob sharedInstance].chatManager buddyList];
    NSLog(@"self.buddylist == %@",self.buddylist);
 
#warning 强调buddylist没有值的情况 1.第一次登录 2.自动登录还没有完成
//    if (self.buddylist.count == 0) {
//        /** 数据库没有好友记录 */
//        [[EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
//            NSLog(@"buddyListbuddyList == %@",buddyList);
//            for (EMBuddy *buddy in buddyList) {
//                NSLog(@"%@",buddy.username);
//            }
//        } onQueue:nil];
//    }
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"addressCell"];
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

    return self.buddylist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressCell"];
    EMBuddy *buddy = self.buddylist[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"chatListCellHead"];
    cell.textLabel.text = buddy.username;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

#pragma mark - EMChatManagerDelegate
- (void)didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error {
    
    if (!error) {
        /** 自动登录成功后 此时buddylist才有值 */
        self.buddylist = [[EaseMob sharedInstance].chatManager buddyList];
        /** 刷新表格 */
        [self.tableView reloadData];
    }
}

- (void)didAcceptedByBuddy:(NSString *)username {
    
    /** 把新的好友显示在列表中 */
    NSArray *buddyList = [[EaseMob sharedInstance].chatManager buddyList];
    NSLog(@"好友添加请求同意 %@",buddyList);
#warning buddyList的个数 仍然是没有添加好友之前的个数 从新服务器获取
    [self loadBuddyListFromServer];
}

- (void)loadBuddyListFromServer {
    
    [[EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
        NSLog(@"从服务器获取的好友列表 %@",buddyList);
        
        /** 赋值数据源 */
        self.buddylist = buddyList;
        /** 刷新 */
        [self.tableView reloadData];
    } onQueue:nil];
}

/** 好友列表数据被更新 */
- (void)didUpdateBuddyList:(NSArray *)buddyList changedBuddies:(NSArray *)changedBuddies isAdd:(BOOL)isAdd {
    
    
}

- (NSArray *)buddylist {
    if (!_buddylist) {
        _buddylist = [NSArray array];
    }
    return _buddylist;
}

@end
