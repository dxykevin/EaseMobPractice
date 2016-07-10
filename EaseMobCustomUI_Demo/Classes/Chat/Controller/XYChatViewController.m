//
//  XYChatViewController.m
//  EaseMobCustomUI_Demo
//
//  Created by dxykevin on 16/7/10.
//  Copyright © 2016年 HoldCourt. All rights reserved.
//

#import "XYChatViewController.h"
#import "XYToolView.h"
#import "XYChatViewCell.h"
@interface XYChatViewController () <UITableViewDelegate,UITableViewDataSource>
/** 聊天消息 */
@property (nonatomic,strong) NSMutableArray *messageData;
/** 列表 */
@property (nonatomic,strong) UITableView *tableView;
@end
NSString *const identifer = @"XYChatViewCell";
@implementation XYChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"聊天界面";
    
    [self initSubViews];
    
    [self loadData];
    
    [self.tableView registerClass:[XYChatViewCell class] forCellReuseIdentifier:identifer];
    
    /** 通知 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (keyboardFrame.origin.y < kScreenHeight) {
        CGRect frame = self.contentView.frame;
        frame.origin.y = -keyboardFrame.size.height;
        self.contentView.frame = frame;
    } else {
        CGRect frame = self.contentView.frame;
        frame.origin.y = 0;
        self.contentView.frame = frame;
    }
}

- (void)loadData {
    
    /** 获取本地的聊天消息 */
    NSString *chatter = @"test1";
    /** 获取当前对象的会话 */
    EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:chatter type:EMConversationTypeChat createIfNotExist:YES];
    /** 加载当前会话的所有消息 */
    NSArray *messages = [conversation loadMoreMessagesFromId:nil limit:20 direction:(EMMessageSearchDirectionUp)];
    /** 初始化数组 */
    self.messageData = [NSMutableArray arrayWithArray:messages];
    [self scrollBottom];
}

- (void)initSubViews {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - 44) style:(UITableViewStylePlain)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellEditingStyleNone;
    [self.contentView addSubview:tableView];
    self.tableView = tableView;
    
    XYToolView *toolView = [[XYToolView alloc] init];
    [self.contentView addSubview:toolView];
    [toolView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.bottom);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.bottom.equalTo(self.view.bottom);
    }];
    /** 发送消息 */
    __weak typeof(self) weakSelf = self;
    toolView.sendTextBlock = ^(UITextView *textView,XYToolViewEditTextViewType type) {
        
        DXYLog(@"你点击了完成按钮");
        
        /** 内容对象 */
        EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:textView.text];
        
        /** 生成message */
        EMMessage *message = [[EMMessage alloc] initWithConversationID:@"kevin" from:@"" to:@"" body:body ext:nil];
        message.chatType = EMChatTypeChat;
        
        [[EMClient sharedClient].chatManager asyncSendMessage:message progress:^(int progress) {
            DXYLog(@"progress == %zd",progress);
        } completion:^(EMMessage *message, EMError *error) {
            DXYLog(@"消息发送完成");
            /** 添加数据 */
            [weakSelf.messageData addObject:message];
            /** 刷新列表 */
            [weakSelf.tableView reloadData];
            /** 刷新到最低端 */
            [weakSelf scrollBottom];
            /** 清空数据 */
            textView.text = @"";
            
        }];
    };
}

#pragma mark - delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.contentView endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.messageData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XYChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    cell.message = self.messageData[indexPath.row];
    return cell.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XYChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    cell.message = self.messageData[indexPath.row];
    return cell;
}

- (void)scrollBottom {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messageData.count - 1 inSection:0];
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];
}

- (NSMutableArray *)messageData {
    
    if (!_messageData) {
        _messageData = [NSMutableArray array];
    }
    return _messageData;
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
