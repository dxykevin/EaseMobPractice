//
//  XYChatViewCell.h
//  EaseMobCustomUI_Demo
//
//  Created by dxykevin on 16/7/10.
//  Copyright © 2016年 HoldCourt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYChatViewCell : UITableViewCell
/** message */
@property (nonatomic,strong) EMMessage *message;
/** cell高度 */
@property (nonatomic,assign) CGFloat cellHeight;
@end
