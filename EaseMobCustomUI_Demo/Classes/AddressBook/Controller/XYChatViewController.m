//
//  XYChatViewController.m
//  EaseMobCustomUI_Demo
//
//  Created by HoldCourt on 16/7/6.
//  Copyright © 2016年 HoldCourt. All rights reserved.
//

#import "XYChatViewController.h"
#import "XYChatViewCell.h"
#import "XYSendChatViewCell.h"
@interface XYChatViewController () <UITableViewDelegate,UITableViewDataSource>
/** 输入工具条底部的约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewBottomConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *datasources;
/** 计算高度的cell */
@property (nonatomic,strong) XYChatViewCell *chatCellTool;
/** 计算高度的cell */
@property (nonatomic,strong) XYSendChatViewCell *sendChatCellTool;
@end

@implementation XYChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"聊天界面";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHiden:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYChatViewCell class]) bundle:nil] forCellReuseIdentifier:@"chatCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYSendChatViewCell class]) bundle:nil] forCellReuseIdentifier:@"sendChatCell"];
    
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"你好你好你好"];
    for (int i = 0; i < 20; i ++) {
        [str appendString:@"呵呵哒你是一个好演员"];
        [self.datasources addObject:str];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datasources.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /** 设置label的数据源 */
    if (indexPath.row % 2 == 0) {
        self.sendChatCellTool.messageLabel.text = self.datasources[indexPath.row];
        return [self.sendChatCellTool cellHeight];
    } else {
        self.chatCellTool.messageLabel.text = self.datasources[indexPath.row];
        return [self.chatCellTool cellHeight];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row % 2 == 0) {
        XYSendChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sendChatCell"];
        cell.messageLabel.text = self.datasources[indexPath.row];
        return cell;
    } else {
        XYChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chatCell"];
        cell.messageLabel.text = self.datasources[indexPath.row];
        return cell;
    }
}

- (void)keyboardWillShow:(NSNotification *)notifation {
    
    /** 获取键盘结束时的位置 */
    NSLog(@"%@",notifation.userInfo);
    CGRect endFrame = [notifation.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = endFrame.size.height;
    /** 更改底部的约束 */
    self.inputViewBottomConstraint.constant = height;
    [UIView animateWithDuration:[notifation.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        /** 解决转场的时候中间出现间隙 */
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHiden:(NSNotification *)notifation {
    
    /** 获取键盘结束时的位置 */
//    CGRect endFrame = [notifation.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat height = endFrame.size.height;
    /** 更改底部的约束 */
    self.inputViewBottomConstraint.constant = 0;
    [UIView animateWithDuration:[notifation.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSMutableArray *)datasources {
    
    if (!_datasources) {
        _datasources = [NSMutableArray array];
    }
    return _datasources;
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
