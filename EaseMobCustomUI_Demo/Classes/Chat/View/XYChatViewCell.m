//
//  XYChatViewCell.m
//  EaseMobCustomUI_Demo
//
//  Created by HoldCourt on 16/7/6.
//  Copyright © 2016年 HoldCourt. All rights reserved.
//

#import "XYChatViewCell.h"

@implementation XYChatViewCell
- (CGFloat)cellHeight {
    
    /** 重新布局子控件 */
    [self layoutIfNeeded];
    
    return 15 + self.messageLabel.bounds.size.height + 10 + 5;
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
