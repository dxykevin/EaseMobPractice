//
//  XYRootViewController.h
//  EaseMobCustomUI_Demo
//
//  Created by dxykevin on 16/7/10.
//  Copyright © 2016年 HoldCourt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYContentView.h"
#import "AppDelegate.h"
@interface XYRootViewController : UIViewController
/** 控制器的view */
@property (nonatomic, strong) XYContentView *contentView;

@property (nonatomic, strong) AppDelegate *myAppDelegate;

//- (void)setChatDelegate;
@end
