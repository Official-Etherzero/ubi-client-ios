//
//  YYTradingCardView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/2/17.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYTradingCardView.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import "NSString+Ext.h"

@interface YYTradingCardView ()

@property (nonatomic, strong) YYLabel *balanceView;
@property (nonatomic, strong) YYLabel *frozenView;
@property (nonatomic, strong) YYLabel *availableView;

@end

@implementation YYTradingCardView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_151824;
        self.layer.cornerRadius = 15.0f;
        self.clipsToBounds = YES;
        
        UIImageView *bottomView = [[UIImageView alloc] init];
        bottomView.image = [UIImage imageNamed:@"trade_bg"];
        [self addSubview:bottomView];
        bottomView.layer.cornerRadius = 15.0f;
        bottomView.clipsToBounds = YES;
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_offset(CGSizeMake(YYSIZE_300, YYSIZE_175));
        }];
        
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_cbd9ff text:YYStringWithKey(@"Trading Account (UBI)")];
        [self addSubview:titleView];
        titleView.textAlignment = NSTextAlignmentCenter;
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_28);
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_20);
        }];
        
        self.balanceView = [[YYLabel alloc] initWithFont:FONT_BEBAS_44 textColor:COLOR_ffffff text:@"0"];
        [self addSubview:self.balanceView];
        self.balanceView.textAlignment = NSTextAlignmentCenter;
        [self.balanceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_06);
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_20);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        [self addSubview:lineView];
        lineView.backgroundColor = COLOR_ffffff_A01;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.balanceView.mas_bottom).offset(YYSIZE_30);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_260, 0.5));
        }];
        
        YYLabel *frozenTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_20 textColor:COLOR_cbd9ff text:YYStringWithKey(@"Frozen (UBI)")];
        [self addSubview:frozenTitleView];
        [frozenTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_20);
            make.top.mas_equalTo(lineView.mas_bottom).offset(YYSIZE_20);
        }];
        
        self.frozenView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff text:@"0"];
        [self addSubview:self.frozenView];
        [self.frozenView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_20);
            make.top.mas_equalTo(frozenTitleView.mas_bottom).offset(YYSIZE_08);
        }];
        
        YYLabel *availableTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_20 textColor:COLOR_cbd9ff text:YYStringWithKey(@"Available (UBI)")];
        [self addSubview:availableTitleView];
        [availableTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_20);
            make.top.mas_equalTo(frozenTitleView.mas_top);
        }];
        
        self.availableView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff text:@"0"];
        [self addSubview:self.availableView];
        [self.availableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_20);
            make.top.mas_equalTo(availableTitleView.mas_bottom).offset(YYSIZE_08);
        }];
    }
    return self;
}

- (void)setModel:(BlanceModel *)model {
    _model = model;
    self.balanceView.text = [model.UBIIN yy_holdDecimalPlaceToIndex:8];
    self.frozenView.text = [model.FrozenUBI yy_holdDecimalPlaceToIndex:8];
    self.availableView.text = [[NSString stringWithFormat:@"%f",([model.UBIIN doubleValue] - [model.FrozenUBI doubleValue])] yy_holdDecimalPlaceToIndex:8];
}


@end
