//
//  YYRegisterLoginView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/25.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYRegisterLoginView.h"
#import "YYTextView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "EVOMd5Generate.h"
#import "YYSecureView.h"
#import "YYToastView.h"

@interface YYRegisterLoginView ()

@property (nonatomic,   copy) RegisterConfirmBlock confirmBlock;
@property (nonatomic,   copy) CancelRegisterBlock  cancelBlock;
@property (nonatomic, strong) YYTextView   *addressView;
@property (nonatomic, strong) YYTextView   *codeView;
@property (nonatomic, strong) YYSecureView *passwordView;
@property (nonatomic, strong) YYSecureView *confirmPasswordView;
@property (nonatomic,   copy) NSString *password;
@property (nonatomic,   copy) NSString *repeatPassword;


@end

@implementation YYRegisterLoginView

+ (instancetype)showRegisterLoginViewBlock:(RegisterConfirmBlock)block cancelBlock:(nonnull CancelRegisterBlock)cancelBlock {
    YYRegisterLoginView *view = [[YYRegisterLoginView alloc] init];
    view.confirmBlock = block;
    view.cancelBlock = cancelBlock;
    return view;
}

- (void)dealloc {
    [self.passwordView removeObserver:self forKeyPath:@"secureContent"];
    [self.confirmPasswordView removeObserver:self forKeyPath:@"secureContent"];
}

- (instancetype)init {
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
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_offset(CGSizeMake(YYSIZE_280, YYSIZE_390));
        }];
        
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_36 textColor:COLOR_ffffff text:YYStringWithKey(@"安全设置")];
        [bottomView addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_28);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        YYTextView *addressView = [YYTextView new];
//        addressView.layer.borderColor = COLOR_7d87a0_A03.CGColor;
        [bottomView addSubview:addressView];
        addressView.layer.borderWidth = 0.5;
        addressView.layer.cornerRadius = 5.0;
        addressView.textAlignment = NSTextAlignmentCenter;
        addressView.font = FONT_DESIGN_26;
        addressView.placeholder = YYStringWithKey(@"输入邀请地址");
        addressView.placeholderColor = COLOR_7d87a0_A03;
        addressView.backgroundColor = COLOR_272d48;
        addressView.textContainerInset = UIEdgeInsetsMake(YYSIZE_07_5, 3, YYSIZE_07_5,3);
        [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_28);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(YYSIZE_220, YYSIZE_40));
        }];
        self.addressView = addressView;
        
        YYSecureView *passwordView = [YYSecureView new];
        passwordView.inputUnitCount = 12; // 最大 12
        passwordView.unitSpace = 3;
//        passwordView.layer.borderColor = COLOR_7d87a0_A03.CGColor;
        [bottomView addSubview:passwordView];
        passwordView.layer.borderWidth = 0.5;
        passwordView.layer.cornerRadius = 5.0;
        passwordView.secureTextEntry = YES; // 密文
        passwordView.backgroundColor = COLOR_272d48;
        passwordView.textColor = COLOR_7d87a0_A03;
        passwordView.textAlignment = NSTextAlignmentCenter;
        passwordView.font = FONT_DESIGN_26;
        passwordView.placeholder = YYStringWithKey(@"设置交易密码");
        passwordView.placeholderColor = COLOR_7d87a0_A03;
        passwordView.textContainerInset = UIEdgeInsetsMake(YYSIZE_07_5, 3, YYSIZE_07_5,3);
        [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(addressView.mas_bottom).offset(YYSIZE_15);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(YYSIZE_220, YYSIZE_40));
        }];
        self.passwordView = passwordView;
        
        YYSecureView *confirmPasswordView = [YYSecureView new];
        confirmPasswordView.inputUnitCount = 12; // 最大 12
        confirmPasswordView.unitSpace = 3;
//        confirmPasswordView.layer.borderColor = COLOR_7d87a0_A03.CGColor;
        [bottomView addSubview:confirmPasswordView];
        confirmPasswordView.layer.borderWidth = 0.5;
        confirmPasswordView.layer.cornerRadius = 5.0;
        confirmPasswordView.secureTextEntry = YES; // 密文
        confirmPasswordView.backgroundColor = COLOR_272d48;
        confirmPasswordView.textColor = COLOR_7d87a0_A03;
        confirmPasswordView.placeholderColor = COLOR_7d87a0_A03;
        confirmPasswordView.textAlignment = NSTextAlignmentCenter;
        confirmPasswordView.font = FONT_DESIGN_26;
        confirmPasswordView.placeholder = YYStringWithKey(@"重复交易密码");
        confirmPasswordView.textContainerInset = UIEdgeInsetsMake(YYSIZE_07_5, 3,YYSIZE_07_5 ,3);
        [confirmPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(passwordView.mas_bottom).offset(YYSIZE_15);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(YYSIZE_220, YYSIZE_40));
        }];
        self.confirmPasswordView = confirmPasswordView;
        
        YYTextView *codeView = [YYTextView new];
        //        addressView.layer.borderColor = COLOR_7d87a0_A03.CGColor;
        [bottomView addSubview:codeView];
        codeView.layer.borderWidth = 0.5;
        codeView.layer.cornerRadius = 5.0;
        codeView.textAlignment = NSTextAlignmentCenter;
        codeView.font = FONT_DESIGN_26;
        codeView.placeholder = YYStringWithKey(@"谷歌验证码");
        codeView.placeholderColor = COLOR_7d87a0_A03;
        codeView.backgroundColor = COLOR_272d48;
        codeView.textContainerInset = UIEdgeInsetsMake(YYSIZE_07_5, 3, YYSIZE_07_5,3);
        [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(confirmPasswordView.mas_bottom).offset(YYSIZE_15);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(YYSIZE_220, YYSIZE_40));
        }];
        self.codeView = codeView;
        
        YYButton *cancelView = [YYButton buttonWithType:UIButtonTypeCustom];
        cancelView.stretchLength = 10.0f;
        [cancelView setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
        [bottomView addSubview:cancelView];
        [cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(bottomView.mas_right).offset(-YYSIZE_15);
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_15);
        }];
        WDWeakify(self);
        [cancelView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            [self removeFromSuperview];
            if (self.cancelBlock) {
                self.cancelBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        YYButton *confirmView = [[YYButton alloc] initWithFont:FONT_DESIGN_26 borderWidth:0.5f borderColoer:COLOR_476cff.CGColor masksToBounds:YES title:YYStringWithKey(@"确认") titleColor:COLOR_ffffff backgroundColor:COLOR_476cff cornerRadius:20.0f];
        [bottomView addSubview:confirmView];
        [confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.codeView.mas_bottom).offset(YYSIZE_30);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_220, YYSIZE_40));
        }];
        [confirmView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            if (!self.password) {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"请设置密码") attachedView:[UIApplication sharedApplication].keyWindow];
                return ;
            }
            if (!self.repeatPassword) {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"请重复密码") attachedView:[UIApplication sharedApplication].keyWindow];
                return ;
            }
            NSString *password = [EVOMd5Generate genMd5:self.password];
            NSString *confirmPassword = [EVOMd5Generate genMd5:self.repeatPassword];
            if (self.confirmBlock) {
                self.confirmBlock(self.addressView.text, password, confirmPassword,self.codeView.text);
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        [self.passwordView addObserver: self forKeyPath: @"secureContent" options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context: nil];
        
        [self.confirmPasswordView addObserver: self forKeyPath: @"secureContent" options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context: nil];
    }
    return self;
}

#pragma mark - kvo

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([object isEqual:self.passwordView]) {
        if ([keyPath isEqualToString: @"secureContent"]) {
            self.password = self.passwordView.secureContent;
        }
    } else if ([object isEqual:self.confirmPasswordView]) {
        if ([keyPath isEqualToString: @"secureContent"]) {
            self.repeatPassword = self.confirmPasswordView.secureContent;
        }
    }
}


@end
