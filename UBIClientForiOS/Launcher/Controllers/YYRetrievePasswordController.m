//
//  YYRetrievePasswordController.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/19.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYRetrievePasswordController.h"
#import "YYViewHeader.h"
#import "YYPlaceholderView.h"
#import "YYPageView.h"
#import "UIView+Ext.h"
#import "YYResetPasswordController.h"
#import "YYInterfaceMacro.h"
#import <BlocksKit/BlocksKit.h>
#import "YYCodeView.h"
#import "YYMessageViewModel.h"
#import "YYEnum.h"
#import "MessageView.h"
#import "NSString+Ext.h"
#import "YYGCDTimer.h"
#import "YYUserInfoViewModel.h"
#import "RequestModel.h"
#import "WDTabbarController.h"
#import "EVOMd5Generate.h"

@interface YYRetrievePasswordController ()
<YYPageViewDelegate>

@property (nonatomic, strong) YYPageView         *pageView;
@property (nonatomic, strong) YYPlaceholderView  *emailView;
@property (nonatomic, strong) YYPlaceholderView  *phoneView;
@property (nonatomic, strong) YYButton           *nextStep;
@property (nonatomic, strong) YYLabel            *warningView;
@property (nonatomic, strong) YYMessageViewModel *viewModel;
@property (nonatomic, strong) YYUserInfoViewModel  *infoViewModel;

@property (nonatomic, strong) YYPlaceholderView *passwordView;
@property (nonatomic, strong) YYPlaceholderView *confirmView;
@property (nonatomic, strong) YYPlaceholderView *verificationView;
@property (nonatomic, strong) YYButton          *codeButton;
@property (nonatomic, strong) YYButton          *regionButton;
@property (nonatomic, strong) YYLabel           *timeView;
@property (nonatomic,   copy) NSString          *gcdTimer;
@property (nonatomic, assign) NSInteger         currentCount;

@end

@implementation YYRetrievePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_151824;
    // 输入框
    YYPlaceholderView *phoneView = [[YYPlaceholderView alloc] initWithAttackView:self.view plcStr:YYStringWithKey(@"请输入您的手机号") leftMargin:YYSIZE_54];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_15);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_15);
        }
        make.height.mas_offset(YYSIZE_60);
    }];
    self.phoneView = phoneView;
    
    self.regionButton = [[YYButton alloc] initWithFont:FONT_PingFangSC_Medium_26 borderWidth:0 borderColoer:COLOR_151824.CGColor masksToBounds:NO title:@"+86" titleColor:COLOR_476cff backgroundColor:COLOR_151824 cornerRadius:0];
    [phoneView addSubview:self.regionButton];
    [self.regionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_20);
        make.centerY.mas_equalTo(phoneView.mas_centerY).offset(YYSIZE_08);
        make.size.mas_offset(CGSizeMake(YYSIZE_24, YYSIZE_10));
    }];
    
    // 密码框
    YYPlaceholderView *passwordView = [[YYPlaceholderView alloc] initWithAttackView:self.view plcStr:YYStringWithKey(@"请输入8-16位密码") leftMargin:YYSIZE_24];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(phoneView.mas_bottom);
        make.height.mas_offset(YYSIZE_60);
    }];
    self.passwordView = passwordView;
    
    YYPlaceholderView *confirmView = [[YYPlaceholderView alloc] initWithAttackView:self.view plcStr:YYStringWithKey(@"请确认上面的密码") leftMargin:YYSIZE_24];
    [confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(passwordView.mas_bottom);
        make.height.mas_offset(YYSIZE_60);
    }];
    self.confirmView = confirmView;
    
    // 获取验证码
    YYPlaceholderView *verificationView = [[YYPlaceholderView alloc] initWithAttackView:self.view plcStr:YYStringWithKey(@"请输入验证码") leftMargin:YYSIZE_24];
    [verificationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(confirmView.mas_bottom);
        make.height.mas_offset(YYSIZE_60);
    }];
    self.verificationView = verificationView;
    
    self.codeButton = [[YYButton alloc] initWithFont:FONT_DESIGN_26 title:YYStringWithKey(@"获取验证码") titleColor:COLOR_5d4fe0];
    [self.view addSubview:self.codeButton];
    [self.codeButton addTarget:self action:@selector(handleVerificateCodeClick) forControlEvents:UIControlEventTouchUpInside];
    self.codeButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(verificationView.mas_centerY).offset(YYSIZE_05);
        make.right.mas_equalTo(self.view.mas_right).offset(-YYSIZE_20);
        make.size.mas_offset(CGSizeMake(YYSIZE_70, YYSIZE_12));
    }];
    
    self.timeView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_5d4fe0 text:@"60s"];
    [self.view addSubview:self.timeView];
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(verificationView.mas_centerY).offset(YYSIZE_05);
        make.right.mas_equalTo(self.view.mas_right).offset(-YYSIZE_20);
        make.size.mas_offset(CGSizeMake(YYSIZE_40, YYSIZE_12));
    }];
    self.timeView.hidden = YES;
    
    
    self.nextStep = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0 borderColoer:COLOR_476cff.CGColor masksToBounds:YES title:YYStringWithKey(@"下一步") titleColor:COLOR_ffffff backgroundColor:COLOR_476cff cornerRadius:YYSIZE_28];
    self.nextStep.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.nextStep yy_setGradientColors:@[(__bridge id)COLOR_ffca46.CGColor,(__bridge id)COLOR_5d4fe0.CGColor]];
    [self.view addSubview:self.nextStep];
    [self.nextStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verificationView.mas_bottom).offset(YYSIZE_30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_57));
    }];
    WDWeakify(self);
    [self.nextStep bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        [self.phoneView resignFirstResponder];
        [self resetPassword];
//        NSString *title = YYStringWithKey(@"短信验证码");
//        if (![self.phoneView.content yy_isPhoneNumber]) {
//            [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入正确的手机号") attachedView:[UIApplication sharedApplication].keyWindow];
//            return ;
//        }
//        [self showCodeViewTitle:title];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)resetPassword {
    [self judge];
    if (self.verificationView.content.length == 0) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入短信验证码") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    NSString *pswStr = [EVOMd5Generate genMd5:self.confirmView.content];
    [self.infoViewModel yy_viewModelResetPasswordByPhoneWithAreaCode:@"86" mobil:self.phoneView.content newPsw:pswStr verifyCode:self.verificationView.content success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[RequestModel class]]) {
            RequestModel *model = responseObject;
            if (model.code == 0) {
                // 修改密码成功
                [self.navigationController popViewControllerAnimated:YES];
            }
            [YYToastView showCenterWithTitle:model.msg attachedView:[UIApplication sharedApplication].keyWindow];
        }
    } failure:^(NSError * _Nonnull error) {
        [YYToastView showCenterWithTitle:error.localizedDescription attachedView:[UIApplication sharedApplication].keyWindow];
    }];
}

- (void)judge {
    if (self.phoneView.content.length == 0) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入手机号码") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (![self.phoneView.content yy_isPhoneNumber]) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入正确的手机号码") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    
    if (!(self.passwordView.content && self.passwordView.content.length > 0)) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入新的登录密码") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (!(self.confirmView.content && self.confirmView.content.length > 0)) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请确认密码") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (![self.passwordView.content isEqualToString:self.confirmView.content]) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"密码不一致") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
}

- (void)handleVerificateCodeClick {
    [self judge];
    [self.viewModel yy_viewModelGetSMSCodeWithAreaCode:@"86" mobile:self.phoneView.content success:^(id  _Nonnull responseObject) {
        if (responseObject) {
            [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
        }
    } failure:nil];
    
    self.codeButton.hidden = YES;
    self.timeView.hidden = NO;
    self.currentCount = 60;
    self.gcdTimer = [YYGCDTimer timerTask:self selector:@selector(openFire) start:0 interval:1.0f repeats:YES async:YES];
}

-(void)openFire {
    if (self.currentCount == 1) {
        [YYGCDTimer canelTimer:self.gcdTimer];
        dispatch_async_main_safe(^{
            self.codeButton.hidden = NO;
            self.timeView.hidden = YES;
        });
        return;
    }
    self.currentCount --;
    dispatch_async_main_safe((^{
        self.timeView.text = [NSString stringWithFormat:@"%lds",(long)self.currentCount];
    }));
}

- (void)showCodeViewTitle:(NSString *)title {
    WDWeakify(self);
    [MessageView showMessageViewTitle:title SendBlock:^{
        WDStrongify(self);
        [self getCodeAction];
    } confirmBlock:^(NSString * _Nonnull codeStr) {
        [self VerifyCodeAction:codeStr];
    }];
}

- (void)getCodeAction {
    if (self.pageView.index == 0) {
        [self.viewModel yy_viewModelGetMailCodeWithMail:self.emailView.content success:^(id  _Nonnull responseObject) {

        } failure:nil];
    } else {
        [self.viewModel yy_viewModelGetSMSCodeWithAreaCode:@"86" mobile:self.phoneView.content success:^(id  _Nonnull responseObject) {
            
        } failure:nil];
    }
}

- (void)VerifyCodeAction:(NSString *)codeStr {
    WDWeakify(self);
    if (self.pageView.index == 0) {
        [self.viewModel yy_viewModelVerifyMailWithMail:self.emailView.content verifyCode:codeStr success:^(id  _Nonnull responseObject) {
            WDStrongify(self);
            [self enterResetPasswordVC];
        } failure:nil];
    } else {
        [self.viewModel yy_viewModelVerifySMSCodeWithAreaCode:@"86" mobile:self.phoneView.content verifyCode:codeStr success:^(id  _Nonnull responseObject) {
            WDStrongify(self);
            [self enterResetPasswordVC];
        } failure:nil];
    }
}

- (void)enterResetPasswordVC {
    YYResetPasswordController *vc = [YYResetPasswordController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy

- (YYMessageViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYMessageViewModel alloc] init];
    }
    return _viewModel;
}

- (YYUserInfoViewModel *)infoViewModel {
    if (!_infoViewModel) {
        _infoViewModel = [[YYUserInfoViewModel alloc] init];
    }
    return _infoViewModel;
}

#pragma mark - YYPageViewDelegate

- (void)pageViewDidChangeIndex:(YYPageView *)pageView {
    if (pageView.index == 0) {
        self.emailView.hidden = NO;
        self.phoneView.hidden = YES;
    } else {
        self.emailView.hidden = YES;
        self.phoneView.hidden = NO;
    }
}

@end
