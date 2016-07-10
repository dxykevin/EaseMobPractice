//
//  XYChatViewCell.m
//  EaseMobCustomUI_Demo
//
//  Created by dxykevin on 16/7/10.
//  Copyright © 2016年 HoldCourt. All rights reserved.
//

#import "XYChatViewCell.h"
#import "XYButton.h"


@interface XYChatViewCell ()
/** 时间 */
@property (nonatomic,strong) UILabel *timeLb;
/** 聊天消息 */
@property (nonatomic,strong) XYButton *chatBt;
/** 头像 */
@property (nonatomic,strong) XYButton *iconBt;
@end
@implementation XYChatViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubViews];
    }
    return self;
}

/** 添加子控件 */
- (void)setupSubViews {
    
    /** 时间 */
    UILabel *timeLb = [[UILabel alloc] init];
    timeLb.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:timeLb];
    
    /** 聊天消息 */
    XYButton *chatBt = [XYButton createButton];
    chatBt.contentEdgeInsets = UIEdgeInsetsMake(15, 20, 25, 20);
    chatBt.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.contentView addSubview:chatBt];
    
    /** 头像 */
    XYButton *iconBt = [XYButton createButton];
    [self.contentView addSubview:iconBt];
    
    self.timeLb = timeLb;
    self.chatBt = chatBt;
    self.iconBt = iconBt;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.timeLb makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.top);
        make.left.equalTo(self.contentView.left);
        make.right.equalTo(self.contentView.right);
        make.height.equalTo(44 / 2);
    }];
}

- (void)setMessage:(EMMessage *)message {
    
    _message = message;
    CGFloat height = 0;
    CGFloat width = kScreenWidth / 2 + 40;
    self.cellHeight = height;
    /** 时间 */
    self.timeLb.text = [NSString stringWithFormat:@"%lldld",message.timestamp];
    switch (message.body.type) {
        case EMMessageBodyTypeText: {
            EMTextMessageBody *body = (EMTextMessageBody *)message.body;
            [self.chatBt setTitle:body.text forState:(UIControlStateNormal)];
            [self.chatBt setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            height = [body.text boundingRectWithSize:CGSizeMake(kScreenWidth / 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15.0f]} context:nil].size.height;
            height += 40;
            if ([message.from isEqualToString:[[EMClient sharedClient] currentUsername]]) {
                /** 自己发送的 */
                /** 头像在右侧 */
                [self.chatBt setBackgroundImage:[self resizingImageWithName:@"chat_sender_bg"] forState:(UIControlStateNormal)];
                [self.iconBt setBackgroundImage:[UIImage imageNamed:@"chatListCellHead"] forState:(UIControlStateNormal)];
                [self.iconBt makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.timeLb.bottom).offset(10);
                    make.right.equalTo(self.contentView.right).offset(-10);
                    make.width.height.equalTo(44);
                }];
                [self.chatBt makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.iconBt.top);
                    make.right.equalTo(self.iconBt.left).offset(-10);
                    make.width.equalTo(width);
                    make.height.equalTo(height);
                }];
            } else {
                /** 别人发送的 */
                /** 头像在左侧 */
                [self.chatBt setBackgroundImage:[self resizingImageWithName:@"chat_receiver_bg"] forState:(UIControlStateNormal)];
                [self.iconBt setBackgroundImage:[UIImage imageNamed:@"chatListCellHead"] forState:(UIControlStateNormal)];
                [self.iconBt makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.timeLb.bottom).offset(10);
                    make.left.equalTo(self.contentView.left).offset(10);
                    make.width.height.equalTo(44);
                }];
                [self.chatBt makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.iconBt.top);
                    make.left.equalTo(self.iconBt.right).offset(10);
                    make.width.equalTo(width);
                    make.height.equalTo(height);
                }];
            }
        }
            break;
        case EMMessageBodyTypeImage:
            break;
        case EMMessageBodyTypeVideo:
            break;
        case EMMessageBodyTypeLocation:
            break;
        case EMMessageBodyTypeVoice:
            break;
        default:
            break;
    }
}

/** 图片拉伸 */
- (UIImage *)resizingImageWithName:(NSString *)name
{
    UIImage *normalImg = [UIImage imageNamed:name];
    
    CGFloat w = normalImg.size.width * 0.5f;
    CGFloat h = normalImg.size.height * 0.5f;
    
    return [normalImg resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}

- (CGFloat)cellHeight {
    
    return _cellHeight + 10;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
