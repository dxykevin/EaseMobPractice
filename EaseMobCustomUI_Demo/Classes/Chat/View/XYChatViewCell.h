//
//  XYChatViewCell.h
//  EaseMobCustomUI_Demo
//
//  Created by HoldCourt on 16/7/6.
//  Copyright © 2016年 HoldCourt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYChatViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

- (CGFloat)cellHeight;
@end
