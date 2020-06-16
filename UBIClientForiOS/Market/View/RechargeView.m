//
//  RechargeView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/29.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "RechargeView.h"
#import "YYTextView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "SGQRCodeObtain.h"

@interface RechargeView ()

@property (nonatomic,   copy) ConfirmBlock confirmBlock;
@property (nonatomic,   copy) CancelBlock  cancelBlock;

@end

@implementation RechargeView

+ (instancetype)showRechargeViewWithUsdtAddress:(NSString *)address
                                   confirmBlock:(ConfirmBlock _Nullable)confirmBlock
                                    cancelBlock:(CancelBlock _Nullable)cancelBlock {
    RechargeView *view = [[RechargeView alloc] initViewWithUsdtAddress:address];
    view.confirmBlock = confirmBlock;
    view.cancelBlock = cancelBlock;
    return view;
}

- (instancetype)initViewWithUsdtAddress:(NSString *)address {
    if (self = [super init]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
        }];
        self.backgroundColor = COLOR_000000_A05;
        
        UIView *bottomView = [[UIView alloc] init];
        [self addSubview:bottomView];
        bottomView.layer.cornerRadius = 10.0f;
        bottomView.clipsToBounds = YES;
        bottomView.backgroundColor = COLOR_1b213b;
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_210);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_280, YYSIZE_290));
        }];
        
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff text:[NSString stringWithFormat:@"%@,%@",YYStringWithKey(@"为了保证交易正常进行"),YYStringWithKey(@"请往以下地址充值1 USDT激活买单")]];
        titleView.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:titleView];
        titleView.numberOfLines = 0;
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_28);
            make.left.mas_equalTo(bottomView.mas_left).offset(YYSIZE_36);
            make.centerX.mas_equalTo(bottomView.mas_centerX);
        }];
        
//        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff text:YYStringWithKey(@"为了保证交易正常进行")];
//        titleView.textAlignment = NSTextAlignmentCenter;
//        [bottomView addSubview:titleView];
//        titleView.numberOfLines = 0;
//        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_28);
//            make.left.mas_equalTo(bottomView.mas_left).offset(YYSIZE_45);
//            make.centerX.mas_equalTo(bottomView.mas_centerX);
//        }];
        
//        YYLabel *contentView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff text:YYStringWithKey(@"请往以下地址充值1 USDT激活买单")];
//        contentView.textAlignment = NSTextAlignmentCenter;
//        contentView.numberOfLines = 0;
//        [bottomView addSubview:contentView];
//        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(bottomView.mas_centerX);
//            make.left.mas_equalTo(bottomView.mas_left).offset(YYSIZE_45);
//            make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_05);
//        }];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [SGQRCodeObtain generateQRCodeWithData:address size:YYSIZE_77];
        [bottomView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_16);
            make.centerX.mas_equalTo(bottomView.mas_centerX);
        }];
        
        YYLabel *addressView = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_7d87a0 text:address];
        addressView.textAlignment = NSTextAlignmentCenter;
        addressView.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [bottomView addSubview:addressView];
        [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bottomView.mas_centerX);
            make.top.mas_equalTo(imageView.mas_bottom).offset(YYSIZE_16);
            make.width.mas_offset(YYSIZE_200);
        }];
        
//        YYButton *cancelView = [[YYButton alloc] initWithFont:FONT_DESIGN_26 borderWidth:0.5f borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"取消") titleColor:COLOR_3d5afe backgroundColor:COLOR_ffffff cornerRadius:2.0f];
//        [bottomView addSubview:cancelView];
//        [cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_36);
//            make.top.mas_equalTo(addressView.mas_bottom).offset(YYSIZE_16);
//            make.size.mas_offset(CGSizeMake(YYSIZE_91, YYSIZE_31));
//        }];
//        WDWeakify(self);
//        [cancelView bk_addEventHandler:^(id  _Nonnull sender) {
//            WDStrongify(self);
//            [self removeFromSuperview];
//            if (self.cancelBlock) {
//                self.cancelBlock();
//            }
//        } forControlEvents:UIControlEventTouchUpInside];
        
        YYButton *confirmView = [[YYButton alloc] initWithFont:FONT_DESIGN_26 borderWidth:0.5f borderColoer:COLOR_476cff.CGColor masksToBounds:YES title:YYStringWithKey(@"复制地址") titleColor:COLOR_ffffff backgroundColor:COLOR_476cff cornerRadius:20.0f];
        [bottomView addSubview:confirmView];
        [confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bottomView.mas_centerX);
            make.top.mas_equalTo(addressView.mas_bottom).offset(YYSIZE_30);
            make.size.mas_offset(CGSizeMake(YYSIZE_220, YYSIZE_40));
        }];
        WDWeakify(self);
        [confirmView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            [self removeFromSuperview];
            if (self.confirmBlock) {
                self.confirmBlock(address);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

@end
