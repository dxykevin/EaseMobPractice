//
//  XYButton.h
//  EaseMobCustomUI_Demo
//
//  Created by dxykevin on 16/7/10.
//  Copyright © 2016年 HoldCourt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYButton;

typedef void(^XYButtonClickBlock)(XYButton *);

@interface XYButton : UIButton

/** 回调 */
@property (nonatomic, copy) XYButtonClickBlock block;

+ (instancetype)createButton;

@end

