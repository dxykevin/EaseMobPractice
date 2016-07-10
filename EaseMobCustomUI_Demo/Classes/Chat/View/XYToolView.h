//
//  XYToolView.h
//  EaseMobCustomUI_Demo
//
//  Created by dxykevin on 16/7/10.
//  Copyright © 2016年 HoldCourt. All rights reserved.
//

typedef enum {
    XYToolViewVoiceTypeStart,
    XYToolViewVoiceTypeStop,
    XYToolViewVoiceTypeCancel
}XYToolViewVoiceType;

typedef enum {
    XYToolViewEditTextViewTypeSend,
    XYToolViewEditTextViewTypeBegin
} XYToolViewEditTextViewType;

#import <UIKit/UIKit.h>
@class XYButton;


typedef void(^XYToolViewSendTextBlock)(UITextView *text,XYToolViewEditTextViewType);
// block方式
typedef void(^XYToolViewVoiceBlcok)(XYToolViewVoiceType,XYButton *);

typedef void(^XYToolViewMoreBtnBlock)();

@protocol XYToolViewVoiceDelegate <NSObject>

- (void)toolViewWithType:(XYToolViewVoiceType)type button:(XYButton *)btn;

@end

@interface XYToolView : UIView

/** 发送消息的回调 */
@property (nonatomic, copy) XYToolViewSendTextBlock sendTextBlock;

@property (nonatomic,assign)id<XYToolViewVoiceDelegate> delegate;

/** 点击更多按钮的回调 */
@property (nonatomic, copy) XYToolViewMoreBtnBlock moreBtnBlock;
@end
