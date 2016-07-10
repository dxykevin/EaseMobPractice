//
//  XYRootViewController.m
//  EaseMobCustomUI_Demo
//
//  Created by dxykevin on 16/7/10.
//  Copyright © 2016年 HoldCourt. All rights reserved.
//

#import "XYRootViewController.h"
@interface XYRootViewController ()

@end

@implementation XYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XYContentView *contentView = [[XYContentView alloc] init];
    contentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    self.myAppDelegate = app;
}

@end
