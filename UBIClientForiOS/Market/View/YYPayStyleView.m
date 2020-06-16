//
//  YYPayStyleView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/4/27.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYPayStyleView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"

@interface YYPayStyleView ()

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *confirmTitle;
@property (nonatomic, copy) NSString *unConfirmTitle;

@property (nonatomic, strong) YYButton *selectedView;
@property (nonatomic, strong) YYButton *unSelectedView;

@end

@implementation YYPayStyleView

- (instancetype)initViewContent:(NSString *)content confirmTitle:(NSString *)confirmTitle unConfirmTitle:(NSString *)unConfirmTitle {
    if (self = [super init]) {
        self.content = content;
        self.confirmTitle = confirmTitle;
        self.unConfirmTitle = unConfirmTitle;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:COLOR_ffffff_A08 text:self.content];
    [self addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_20);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    self.selectedView = [YYButton buttonWithType:UIButtonTypeCustom];
    [self.selectedView setImage:[UIImage imageNamed:@"Check"] forState:UIControlStateNormal];
    [self.selectedView setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateSelected];
    [self addSubview:self.selectedView];
    self.selectedView.stretchLength = 20.0f;
    [self.selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleView.mas_centerY);
        make.left.mas_equalTo(titleView.mas_right).offset(YYSIZE_10);
    }];
    [self.selectedView addTarget:self action:@selector(confirmSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    YYLabel *confirmTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_ffffff_A04 text:YYStringWithKey(self.confirmTitle)];
    [self addSubview:confirmTitleView];
    [confirmTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectedView.mas_right).offset(YYSIZE_02);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    self.unSelectedView = [YYButton buttonWithType:UIButtonTypeCustom];
    [self.unSelectedView setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    [self.unSelectedView setImage:[UIImage imageNamed:@"Check"] forState:UIControlStateSelected];
    [self addSubview:self.unSelectedView];
    self.unSelectedView.stretchLength = 20.f;
    [self.unSelectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleView.mas_centerY);
        make.left.mas_equalTo(confirmTitleView.mas_right).offset(YYSIZE_60);
    }];
    [self.unSelectedView addTarget:self action:@selector(unSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
    
    YYLabel *unConfirmTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_ffffff_A04 text:YYStringWithKey(self.unConfirmTitle)];
    [self addSubview:unConfirmTitleView];
    [unConfirmTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.unSelectedView.mas_right).offset(YYSIZE_02);;
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}

- (void)confirmSelected:(UIButton *)btn {
    self.selectedView.selected = !btn.selected;
    self.unSelectedView.selected = btn.selected;
    if (self.selectedBlock) {
        // 1、 成功 2、不成功
        // 1、支付宝 2、微信
        if (!self.selectedView.selected) {
            self.selectedBlock(1);
        } else {
            self.selectedBlock(2);
        }
    }
}

- (void)unSelectedAction:(UIButton *)btn {
    self.unSelectedView.selected = !btn.selected;
    self.selectedView.selected = btn.selected;
    if (!self.unSelectedView.selected) {
        self.selectedBlock(1);
    } else {
        self.selectedBlock(2);
    }
}



@end
