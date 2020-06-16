//
//  YYWalletTopView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/2/16.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYWalletTopView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"

@interface YYWalletTopView ()

@property (nonatomic, strong) YYLabel  *titleView;
@property (nonatomic, strong) YYButton *setView;
@property (nonatomic, strong) YYButton *scanView;

@end

@implementation YYWalletTopView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_151824;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.titleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_40 textColor:COLOR_ffffff text:YYStringWithKey(@"UBI Robot")];
    [self addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    self.setView = [YYButton buttonWithType:UIButtonTypeCustom];
    [self.setView setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
    [self addSubview:self.setView];
    self.setView.stretchLength = 20.0f;
    [self.setView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    __weak typeof(self) weakSelf = self;
    [self.setView bk_addEventHandler:^(id  _Nonnull sender) {
        if (weakSelf.setBlock) {
            weakSelf.setBlock();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.scanView = [YYButton buttonWithType:UIButtonTypeCustom];
    [self.scanView setImage:[UIImage imageNamed:@"scan"] forState:UIControlStateNormal];
    [self addSubview:self.scanView];
    self.scanView.stretchLength = 20.0f;
    [self.scanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self.scanView bk_addEventHandler:^(id  _Nonnull sender) {
        if (weakSelf.scanBlock) {
            weakSelf.scanBlock();
        }
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleView.text = title;
}

@end
