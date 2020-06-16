//
//  PayStatusView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/4/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "PayStatusView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "YYPayStyleView.h"
#import "NSString+Ext.h"
#import "YYEnum.h"

@interface PayStatusView ()

@property (nonatomic, strong) YYLabel  *statusView;
@property (nonatomic, strong) YYLabel  *orderNumView;
@property (nonatomic, strong) YYLabel  *payStyleView;
@property (nonatomic, strong) YYLabel  *totalView;
@property (nonatomic, strong) YYLabel  *priceView;
@property (nonatomic, strong) YYLabel  *dataView;
@property (nonatomic, strong) YYLabel  *phoneView;

@property (nonatomic, strong) YYButton *confirmCollectView; // 确认收款
@property (nonatomic, strong) YYButton *confrimPayView; // 确认支付
@property (nonatomic, strong) YYButton *checkView;  // 查看二维码

@property (nonatomic, strong) YYPayStyleView   *payView;
@property (nonatomic, strong) YYPayStyleView   *styleView;

@property (nonatomic, assign) NSInteger  style; // 1支付宝，2微信
@property (nonatomic, assign) NSInteger  type;  // 1已支付，2未支付
 
@end

@implementation PayStatusView

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
        // 默认选择已支付
        // 默认选择支付宝
        self.style = 1;
        self.type = 1;
    }
    return self;
}

- (void)initSubViews {
    self.statusView = [[YYLabel alloc] initWithFont:FONT_DESIGN_40 textColor:COLOR_ffffff text:@""];
    [self addSubview:self.statusView];
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_10);
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_20);
    }];
    
    YYLabel *statusTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:COLOR_ffffff_A08 text:YYStringWithKey(@"状态")];
    [self addSubview:statusTitleView];
    [statusTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.statusView.mas_left);
        make.top.mas_equalTo(self.statusView.mas_bottom).offset(YYSIZE_05);
    }];
    
    YYLabel *numTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:COLOR_ffffff_A08 text:YYStringWithKey(@"订单号")];
    [self addSubview:numTitleView];
    [numTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.statusView.mas_left);
        make.top.mas_equalTo(statusTitleView.mas_bottom).offset(YYSIZE_60);
    }];
    
    self.orderNumView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_32 textColor:COLOR_ffffff text:@""];
    [self addSubview:self.orderNumView];
    [self.orderNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(numTitleView.mas_bottom);
        make.left.mas_equalTo(numTitleView.mas_right).offset(YYSIZE_10);
    }];
    
    self.payStyleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:[UIColor blueColor] text:YYStringWithKey(@"支付方式：支付宝")];
    [self addSubview:self.payStyleView];
    [self.payStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.statusView.mas_left);
        make.top.mas_equalTo(numTitleView.mas_bottom).offset(YYSIZE_10);
    }];
    
    self.totalView = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:[UIColor blueColor] text:@"¥ 0"];
    [self addSubview:self.totalView];
    [self.totalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.statusView.mas_left);
        make.top.mas_equalTo(self.payStyleView.mas_bottom).offset(YYSIZE_30);
    }];
    
    YYLabel *totalTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:COLOR_ffffff_A08 text:YYStringWithKey(@"交易金额")];
    [self addSubview:totalTitleView];
    [totalTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.statusView.mas_left);
        make.top.mas_equalTo(self.totalView.mas_bottom).offset(YYSIZE_03);
    }];
    
    self.priceView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_28 textColor:COLOR_ffffff text:@"¥ 0"];
    [self addSubview:self.priceView];
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.totalView.mas_top);
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_20);
    }];
    
    YYLabel *priceTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:COLOR_ffffff_A08 text:YYStringWithKey(@"单价")];
    [self addSubview:priceTitleView];
    [priceTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.priceView.mas_left).offset(-YYSIZE_20);
        make.top.mas_equalTo(self.priceView.mas_top);
    }];
    
    self.dataView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_28 textColor:COLOR_ffffff text:@"0 UBI"];
    [self addSubview:self.dataView];
    [self.dataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.priceView.mas_right);
        make.top.mas_equalTo(self.priceView.mas_bottom).offset(YYSIZE_05);
    }];
    
    YYLabel *dataTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:COLOR_ffffff_A08 text:YYStringWithKey(@"数量")];
    [self addSubview:dataTitleView];
    [dataTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(priceTitleView.mas_right);
        make.bottom.mas_equalTo(self.dataView.mas_bottom);
    }];
    
    // 确认支付 卖家确认
    self.payView = [[YYPayStyleView alloc] initViewContent:YYStringWithKey(@"确认支付:") confirmTitle:YYStringWithKey(@"已支付") unConfirmTitle:YYStringWithKey(@"未支付")];
    [self addSubview:self.payView];
    [self.payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(totalTitleView.mas_bottom).offset(YYSIZE_30);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_50));
    }];
    WDWeakify(self);
    self.payView.selectedBlock = ^(NSInteger tap) {
        NSLog(@"确认支付 %ld",(long)tap);
        WDStrongify(self);
        self.type = tap;
    };
    
    // 支付方式 买家
    self.styleView = [[YYPayStyleView alloc] initViewContent:YYStringWithKey(@"支付方式:") confirmTitle:YYStringWithKey(@"支付宝") unConfirmTitle:YYStringWithKey(@"微信")];
    [self addSubview:self.styleView];
    [self.styleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(totalTitleView.mas_bottom).offset(YYSIZE_30);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_50));
    }];
    self.styleView.selectedBlock = ^(NSInteger tap) {
        NSLog(@"选择支付方式 %ld",(long)tap);
        WDStrongify(self);
        self.style = tap;
    };
    self.styleView.hidden = YES;
    
    // 手机号
    self.phoneView = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:COLOR_ffffff text:@"13412322341"];
    [self addSubview:self.phoneView];
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.statusView.mas_left);
        make.top.mas_equalTo(self.payView.mas_bottom).offset(YYSIZE_30);
    }];
    
    self.confirmCollectView = [[YYButton alloc] initWithFont:FONT_DESIGN_32 borderWidth:0 borderColoer:COLOR_486cff.CGColor masksToBounds:YES title:YYStringWithKey(@"确认收款") titleColor:COLOR_ffffff backgroundColor:COLOR_486cff cornerRadius:YYSIZE_21];
    [self addSubview:self.confirmCollectView];
    [self.confirmCollectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.phoneView.mas_bottom).offset(YYSIZE_40);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_42));
    }];
    [self.confirmCollectView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        if (self.collectionBlock) {
            self.collectionBlock(self.type);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    self.confirmCollectView.hidden = YES;
    
    self.confrimPayView = [[YYButton alloc] initWithFont:FONT_DESIGN_32 borderWidth:0 borderColoer:COLOR_486cff.CGColor masksToBounds:YES title:YYStringWithKey(@"确认支付") titleColor:COLOR_ffffff backgroundColor:COLOR_486cff cornerRadius:YYSIZE_21];
    [self addSubview:self.confrimPayView];
    [self.confrimPayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.phoneView.mas_bottom).offset(YYSIZE_40);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_42));
    }];
    [self.confrimPayView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        if (self.payBlock) {
            // 支付方式
            self.payBlock(self.style);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    self.confrimPayView .hidden = YES;
    
    self.checkView = [[YYButton alloc] initWithFont:FONT_DESIGN_32 title:YYStringWithKey(@"收款码>>") titleColor:COLOR_486cff];
    self.checkView.stretchLength = 10.0f;
    [self addSubview:self.checkView];
    [self.checkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.statusView.mas_top).offset(YYSIZE_15);
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_20);
    }];
    [self.checkView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        if (self.checkBlock) {
            self.checkBlock();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    self.checkView.hidden = YES;
}

- (void)setModel:(MyOrderModel *)model {
    _model = model;
    // Direction;   // 1、买家  2、卖家
    if (model.Direction == 1) {
        self.confrimPayView.hidden = NO;
        self.confirmCollectView.hidden = YES;
        self.styleView.hidden = YES;
        self.payView.hidden = NO;
        self.checkView.hidden = NO;
    } else if (model.Direction == 2) {
        self.confrimPayView.hidden = YES;
        self.confirmCollectView.hidden = NO;
        self.styleView.hidden = NO;
        self.payView.hidden = YES;
    }
    self.orderNumView.text = model.OrderID;
    self.phoneView.text = model.Phone;
    self.payStyleView.text = model.PayType == 1 ? YYStringWithKey(@"微信") : YYStringWithKey(@"支付宝");
    self.totalView.text  = [[NSString stringWithFormat:@"%f",[model.Price floatValue] * model.Count] yy_holdDecimalPlaceToIndex:1];
    self.priceView.text = [NSString stringWithFormat:@"¥ %@",model.Price];
    self.dataView.text = [NSString stringWithFormat:@"%ld",(long)model.Count];
    if (model.Direction == 1 && model.Status == 3) {
        self.checkView.hidden = YES;
    }
    if (model.Status == 4) {
        // 交易完成
        self.payView.hidden = YES;
        self.styleView.hidden = YES;
        self.phoneView.hidden = YES;
        self.confirmCollectView.hidden = YES;
        self.confrimPayView.hidden = YES;
    }
    self.statusView.text = yyGetOrderCurrentStatusString(model.Status);
}

@end
