//
//  XYButton.m
//  EaseMobCustomUI_Demo
//
//  Created by dxykevin on 16/7/10.
//  Copyright © 2016年 HoldCourt. All rights reserved.
//

#import "XYButton.h"

@implementation XYButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)click:(XYButton *)btn
{
    if (_block) {
        _block(btn);
    }
}

+ (instancetype)createButton
{
    return [XYButton buttonWithType:UIButtonTypeCustom];
}

@end

