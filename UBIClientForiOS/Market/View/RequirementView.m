//
//  RequirementView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/4/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "RequirementView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>

@implementation RequirementView

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.backgroundColor = COLOR_333c62;
    YYLabel *leftView = [[YYLabel alloc] initWithFont:FONT_DESIGN_32 textColor:COLOR_ffffff text:YYStringWithKey(@"发布需求")];
    [self addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_10);
    }];
    
    YYButton *btn = [[YYButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:@"myorder"] forState:UIControlStateNormal];
    btn.stretchLength = 30.0f;
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_15);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    __weak typeof(self) weakSelf = self;
    [btn bk_addEventHandler:^(id  _Nonnull sender) {
        if (weakSelf.orderBlock) {
            weakSelf.orderBlock();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    YYLabel *rightView = [[YYLabel alloc] initWithFont:FONT_DESIGN_32 textColor:COLOR_ffffff text:YYStringWithKey(@"订单记录")];
    [self addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(btn.mas_left).offset(-YYSIZE_03);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}

@end
