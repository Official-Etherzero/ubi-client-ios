//
//  OrderView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/4/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "OrderView.h"
#import "YYViewHeader.h"
#import "YYTextView.h"
#import <BlocksKit/BlocksKit.h>
#import "YYToastView.h"

@interface OrderView ()

@property (nonatomic, strong) UITextField *priceView;
@property (nonatomic, strong) UITextField *dataView;
@property (nonatomic, strong) YYButton    *btnView;

@end

@implementation OrderView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_1a203a;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    
    self.dataView = [[UITextField alloc] init];
    self.dataView.borderStyle = UITextBorderStyleNone;
    [self.dataView setFont:FONT_DESIGN_32];
    self.dataView.placeholder = YYStringWithKey(@"最低1个UBI");
    self.dataView.backgroundColor = COLOR_252c4d;
    self.dataView.textColor = COLOR_ffffff;
    NSMutableAttributedString *plc = [[NSMutableAttributedString alloc] initWithString:YYStringWithKey(@"最低1个UBI") attributes:@{NSFontAttributeName: FONT_DESIGN_32,NSForegroundColorAttributeName: COLOR_ffffff_A05}];
    self.dataView.attributedPlaceholder = plc;
    self.dataView.secureTextEntry = NO;
    self.dataView.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.dataView];
    [self.dataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_15);
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_17);
        make.size.mas_offset(CGSizeMake(YYSIZE_155, YYSIZE_40));
    }];
    
    self.priceView = [[UITextField alloc] init];
    self.priceView.placeholder = @"0";
    self.priceView.borderStyle = UITextBorderStyleNone;
    self.priceView.textColor = COLOR_ffffff;
    [self.priceView setFont:FONT_DESIGN_32];
    self.priceView.backgroundColor = COLOR_252c4d;
    self.priceView.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *pricePlc = [[NSMutableAttributedString alloc] initWithString:YYStringWithKey(@"0") attributes:@{NSFontAttributeName: FONT_DESIGN_32,NSForegroundColorAttributeName: COLOR_ffffff_A05}];
    self.priceView.attributedPlaceholder = pricePlc;
    self.priceView.secureTextEntry = NO;
    [self addSubview:self.priceView];
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dataView.mas_top);
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_15);
        make.size.mas_offset(CGSizeMake(YYSIZE_155, YYSIZE_40));
    }];
    
    self.btnView = [[YYButton alloc] initWithFont:FONT_DESIGN_36 borderWidth:0 borderColoer:COLOR_486cff.CGColor masksToBounds:YES title:YYStringWithKey(@"求购") titleColor:COLOR_ffffff backgroundColor:COLOR_486cff cornerRadius:17.5];
    [self addSubview:self.btnView];
    [self.btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_75);
        make.size.mas_offset(CGSizeMake(YYSIZE_250, YYSIZE_35));
    }];
    __weak typeof(self) weakSelf = self;
    [self.btnView bk_addEventHandler:^(id  _Nonnull sender) {
        if ([weakSelf.dataView.text floatValue] < 1.0) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"最少一个UBI") attachedView:[UIApplication sharedApplication].keyWindow];
            return;
        }
        if ([weakSelf.priceView.text floatValue] == 0) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"价格要大于0") attachedView:[UIApplication sharedApplication].keyWindow];
            return;
        }
        if (weakSelf.buyBlock) {
            weakSelf.buyBlock([weakSelf.dataView.text floatValue], [weakSelf.priceView.text floatValue]);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    YYLabel *leftView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_5d76ae text:YYStringWithKey(@"1.卖家匹配后请10分钟内完成支付，超过2小时订单取消。")];
    leftView.numberOfLines = 0;
    [self addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.btnView.mas_bottom).offset(YYSIZE_15);
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_20);
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_08);
        make.height.mas_offset(YYSIZE_12);
    }];
    
    YYLabel *rightView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_5d76ae text:YYStringWithKey(@"2.上传虚假打款凭证、P图凭证等恶意违规行为封禁账号。")];
    rightView.numberOfLines = 0;
    [self addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftView.mas_left);
        make.top.mas_equalTo(leftView.mas_bottom).offset(YYSIZE_05);
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_08);
        make.height.mas_offset(YYSIZE_12);
    }];
}

@end
