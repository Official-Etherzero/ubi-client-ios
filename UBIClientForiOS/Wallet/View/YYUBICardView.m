//
//  YYUBICardView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/2/17.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYUBICardView.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import "NSString+Ext.h"
#import <BlocksKit/BlocksKit.h>
#import "YYToastView.h"
#import "UIButton+Ext.h"
#import "WalletDataManager.h"

@interface YYUBICardView ()

@property (nonatomic, strong) YYLabel *balanceView;
@property (nonatomic, strong) YYLabel *balanceTitleView;
@property (nonatomic, strong) YYLabel *usdtView;

@property (nonatomic, strong) YYLabel  *addressView;
@property (nonatomic, strong) YYButton *cpView;


@end

@implementation YYUBICardView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_151824;
        self.layer.cornerRadius = 15.0f;
        self.clipsToBounds = YES;
        
        UIImageView *bottomView = [[UIImageView alloc] init];
        bottomView.image = [UIImage imageNamed:@"ubiasset_bg"];
        [self addSubview:bottomView];
        bottomView.layer.cornerRadius = 15.0f;
        bottomView.clipsToBounds = YES;
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_offset(CGSizeMake(YYSIZE_300, YYSIZE_175));
        }];
        
        self.balanceView = [[YYLabel alloc] initWithFont:FONT_BEBAS_48 textColor:COLOR_ffffff text:@"0"];
        [self addSubview:self.balanceView];
        [self.balanceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_28);
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_15);
        }];
        
        self.balanceTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_fefeff text:@"UBI"];
        [self addSubview:self.balanceTitleView];
        [self.balanceTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.balanceView.mas_bottom);
            make.left.mas_equalTo(self.balanceView.mas_right).offset(YYSIZE_02);
        }];
        
        self.usdtView = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_cbd9ff text:@"≈0"];
        [self addSubview:self.usdtView];
        [self.usdtView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.balanceView.mas_bottom).offset(YYSIZE_08);
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_15);
        }];
        self.usdtView.hidden = YES;
        
        self.cpView = [YYButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.cpView];
        self.cpView.stretchLength = 5.0f;
        [self.cpView setImage:[UIImage imageNamed:@"copy"] forState:UIControlStateNormal];
        [self.cpView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_20);
            make.top.mas_equalTo(self.balanceTitleView.mas_bottom).offset(YYSIZE_50);
        }];
        self.cpView.hidden = YES;
        WDWeakify(self);
        [self.cpView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            if (self.addressView.text) {
                pasteboard.string = self.addressView.text;
                [YYToastView showCenterWithTitle:YYStringWithKey(@"复制成功") attachedView:[UIApplication sharedApplication].keyWindow];
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        self.addressView = [[YYLabel alloc] initWithFont:FONT_DESIGN_20 textColor:COLOR_cbd9ff text:[WalletDataManager accountModel].address];
        self.addressView.textAlignment = NSTextAlignmentRight;
        self.addressView.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self addSubview:self.addressView];
        [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.cpView.mas_centerY);
            make.right.mas_equalTo(self.cpView.mas_left).offset(-YYSIZE_03);
            make.size.mas_offset(CGSizeMake(YYSIZE_170, YYSIZE_11));
        }];
        self.addressView.hidden = YES;
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = COLOR_ffffff_A01;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.cpView.mas_bottom).offset(YYSIZE_08);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_260, 0.5));
        }];
        
        NSArray *titles = @[@"转账",@"收款"/*,@"Transfer"*/];
        NSArray *images = @[@"send",@"Receive"/*,@"transfer"*/];
        YYButton *lastView = nil;
        for (int i = 0; i < titles.count; i ++) {
            NSString *_t = titles[i];
            NSString *_img = images[i];
            WDWeakify(self);
            YYButton *btn = ({
                YYButton *v = [YYButton buttonWithType:UIButtonTypeCustom];
                v.layer.cornerRadius = YYSIZE_12;
                v.clipsToBounds = YES;
                v.tag = i;
                [v setImage:[UIImage imageNamed:_img] forState:UIControlStateNormal];
                [v bk_addEventHandler:^(id  _Nonnull sender) {
                    WDStrongify(self);
                    if (self.functionBlock) {
                        self.functionBlock(v.tag);
                    }
                } forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:v];
                [v setTitle:YYStringWithKey(_t) forState:UIControlStateNormal];
                [v setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
                [v.titleLabel setFont:FONT_DESIGN_22];
                [v setImage:[UIImage imageNamed:_img] forState:UIControlStateNormal];
                [v yy_leftButtonAndImageWithSpacing:YYSIZE_03];
                [v mas_makeConstraints:^(MASConstraintMaker *make) {
                    if (lastView) {
                        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_40);
                    } else {
                        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_40);
                    }
                    make.size.mas_offset(CGSizeMake(YYSIZE_75, YYSIZE_25));
                    make.top.mas_equalTo(lineView.mas_bottom).offset(YYSIZE_10);
                }];
                lastView = v;
                v;
            });
        }
    }
    return self;
}

- (void)setBalance:(NSString *)balance {
    _balance = balance;
    if (self.usdtPrice) {
        [self showUsdtView];
    }
    self.balanceView.text = [balance yy_holdDecimalPlaceToIndex:8];
}

- (void)setUsdtPrice:(NSString *)usdtPrice {
    _usdtPrice = usdtPrice;
    if (self.balance) {
        [self showUsdtView];
    }
}

- (void)showUsdtView {
    double total = [self.balance doubleValue] * [self.usdtPrice doubleValue];
    NSString *totalString = [[NSString stringWithFormat:@"%f",total] yy_holdDecimalPlaceToIndex:8];
    self.usdtView.text = [NSString stringWithFormat:@"%@ USDT",totalString];
}

@end
