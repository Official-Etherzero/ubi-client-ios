//
//  YYLoginController.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/19.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYLoginController.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import "APIMacro.h"
#import "RequestModel.h"
#import "UserModel.h"
#import "YYUserDefaluts.h"
#import "YYModel.h"
#import "UsersDefalutMacro.h"
#import "YYMessageViewModel.h"
#import "YYRegisterViewModel.h"
#import "YYLoginViewModel.h"
#import "TerminalModel.h"
#import "YYUserInfoModel.h"

#import "NSString+AES.h"

#import "YYLoginHeaderView.h"
#import "YYLoginView.h"
#import "YYRegisterView.h"
#import "YYToastView.h"

#import "YYRetrievePasswordController.h"
#import "YYPlaceholderView.h"
#import "NSString+Ext.h"
#import "EVOMd5Generate.h"

@interface YYLoginController ()
<YYLoginHeaderViewDelegate,
YYRegisterViewDelegate,
YYLoginViewDelegate>

@property (nonatomic, strong) YYLoginHeaderView    *headerView;
@property (nonatomic, strong) YYLoginView          *loginView;
@property (nonatomic, strong) YYRegisterView       *registerView;
@property (nonatomic, strong) YYLoginViewModel     *loginViewModel;
@property (nonatomic, strong) YYRegisterViewModel  *registerViewModel;
@property (nonatomic, strong) YYMessageViewModel   *messageViewModel;
@property (nonatomic, assign) BOOL                 isChangeLoginView;

@property (nonatomic, strong) YYPlaceholderView *phoneView;
@property (nonatomic, strong) YYPlaceholderView *passwordView;

@property (nonatomic, strong) YYButton *regionBtn;
@property (nonatomic, strong) YYButton *loginBtn;
@property (nonatomic, strong) YYButton *forgetBtn;

@end

@implementation YYLoginController
// 登录注册放一起

- (instancetype)initLoginViewController {
    if (self = [super init]) {
        self.isChangeLoginView = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_151824;
    self.navigationItem.title = YYStringWithKey(@"登录");
    [self initSubViews];
}

- (void)initSubViews {
   self.phoneView = [[YYPlaceholderView alloc] initWithAttackView:self.view plcStr:YYStringWithKey(@"手机号") leftMargin:YYSIZE_54];
   [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.mas_equalTo(self.view);
       if (iOS11) {
           make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_32);
       } else {
           make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_32);
       }
       make.height.mas_offset(YYSIZE_60);
   }];
   
   self.regionBtn = [[YYButton alloc] initWithFont:FONT_PingFangSC_Medium_26 borderWidth:0 borderColoer:COLOR_ffffff.CGColor masksToBounds:NO title:@"+86" titleColor:COLOR_5d4fe0 backgroundColor:COLOR_151824 cornerRadius:0];
   [self.phoneView addSubview:self.regionBtn];
   [self.regionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_20);
       make.centerY.mas_equalTo(self.phoneView.mas_centerY).offset(YYSIZE_08);
       make.size.mas_offset(CGSizeMake(YYSIZE_24, YYSIZE_10));
   }];
    
    self.passwordView = [[YYPlaceholderView alloc] initWithAttackView:self.view plcStr:YYStringWithKey(@"密码") leftMargin:YYSIZE_24];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.phoneView.mas_bottom);
        make.height.mas_offset(YYSIZE_60);
    }];
    
    // 立即登录
    self.loginBtn = [[YYButton alloc] initWithFont:FONT_PingFangSC_BLOD_30 borderWidth:0.0f borderColoer:COLOR_476cff.CGColor masksToBounds:YES title:YYStringWithKey(@"登录") titleColor:COLOR_ffffff backgroundColor:COLOR_476cff cornerRadius:YYSIZE_28];
    [self.view addSubview:self.loginBtn];
    [self.loginBtn addTarget:self action:@selector(loginViewClick) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.passwordView.mas_bottom).offset(YYSIZE_40);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_57));
    }];
    
    self.forgetBtn = [[YYButton alloc] initWithFont:FONT_PingFangSC_Medium_30 title:YYStringWithKey(@"忘记密码?") titleColor:COLOR_476cff];
    [self.view addSubview:self.forgetBtn];
    [self.forgetBtn addTarget:self action:@selector(forgetPasswordClick) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(YYSIZE_20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
}

- (void)loginViewClick {
    // 手机
    if (![self.phoneView.content yy_isPhoneNumber]) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入正确的手机号") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    // 密码 md5 加密
    NSString *pswStr = [EVOMd5Generate genMd5:self.passwordView.content];
    [self yy_loginViewLoginByPhoneWithArea:@"86" mobile:self.phoneView.content password:pswStr];
}

- (void)forgetPasswordClick {
    [self yy_loginViewEnterForgetController];
}

#pragma mark - YYLoginHeaderViewDelegate

- (void)yy_exitCurrentController {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

#pragma mark - YYRegisterViewDelegate

- (void)yy_showLoginViewHidenRegisterView {
    self.loginView.hidden = NO;
    self.registerView.hidden = YES;
}

// 发验短信验证码
- (void)yy_sendMobileVerificationCodeWithMobile:(NSString *)mobile area:(nonnull NSString *)area {
    [self.messageViewModel yy_viewModelGetSMSCodeWithAreaCode:area mobile:mobile success:^(id  _Nonnull responseObject) {
    } failure:nil];
}

- (void)yy_sendEmailVerificationCodeWithEmail:(NSString *)email {
    [self.messageViewModel yy_viewModelGetMailCodeWithMail:email success:^(id  _Nonnull responseObject) {
    } failure:nil];
}

// 手机注册
- (void)yy_registeAccountMobile:(NSString *)mobile area:(NSString *)area password:(NSString *)password vcode:(NSString *)vcode incode:(NSString *)incode {
    WDWeakify(self);
    [self.registerViewModel yy_viewModelRegisterByPhoneWithPassword:password inviteCode:incode randNum:[TerminalModel getRandNumStr] mobile:mobile verifyCode:vcode success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[YYUserInfoModel class]]) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"注册成功") attachedView:[UIApplication sharedApplication].keyWindow];
            WDStrongify(self);
            if (self.loginBlock) {
                self.loginBlock();
            }
            [self yy_exitCurrentController];
        } else {
            if (responseObject) {
               [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
            }
        }
       
    } failure:nil];
}

// 邮箱注册
- (void)yy_registeAccountEmail:(NSString *)email password:(NSString *)password vcode:(NSString *)vcode incode:(NSString *)incode {
    WDWeakify(self);
    [self.registerViewModel yy_viewModelRegisterByMailWithPassword:password inviteCode:incode randNum:[TerminalModel getRandNumStr] mail:email verifyCode:vcode success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[YYUserInfoModel class]]) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"注册成功") attachedView:[UIApplication sharedApplication].keyWindow];
        }
        WDStrongify(self);
        if (self.loginBlock) {
            self.loginBlock();
        }
        [self yy_exitCurrentController];
    } failure:nil];
}

#pragma mark - YYLoginViewDelegate

- (void)yy_showRegisterViewHiddenLoginView {
    self.loginView.hidden = YES;
    self.registerView.hidden = NO;
}

- (void)yy_loginViewEnterRegionController {
//    [self.navigationController pushViewController:[YYRegionController new] animated:YES];
}

- (void)yy_loginViewEnterForgetController {
    [self.navigationController pushViewController:[[YYRetrievePasswordController alloc] initWithTitle:YYStringWithKey(@"忘记密码")] animated:YES];
}

// 这里是直接登录的
- (void)yy_loginViewLoginByPhoneWithArea:(NSString *)area
                                  mobile:(NSString *)mobile
                                password:(NSString *)password {
    WDWeakify(self);
    [self.loginViewModel yy_viewModelLoginByPhoneWithPassword:password mobile:mobile areaCode:area success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[YYUserInfoModel class]]) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"登录成功") attachedView:[UIApplication sharedApplication].keyWindow];
            WDStrongify(self);
            if (self.loginBlock) {
                self.loginBlock();
            }
            [self yy_exitCurrentController];
        } else {
            NSString *str = responseObject;
            if (str && str.length > 0) {
                [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [YYToastView showCenterWithTitle:error.localizedDescription attachedView:[UIApplication sharedApplication].keyWindow];
    }];
}

- (void)yy_loginViewLoginByMailWithMail:(NSString *)mail
                               password:(NSString *)password {
    WDWeakify(self);
    [self.loginViewModel yy_viewModelLoginByMailWithPassword:password mail:mail success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[YYUserInfoModel class]]) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"登录成功") attachedView:[UIApplication sharedApplication].keyWindow];
            WDStrongify(self);
            if (self.loginBlock) {
                self.loginBlock();
            }
            [self yy_exitCurrentController];
        } else {
            NSString *str = responseObject;
            if (str && str.length > 0) {
                [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [YYToastView showCenterWithTitle:error.localizedDescription attachedView:[UIApplication sharedApplication].keyWindow];
    }];
}

#pragma mark - lazy

- (YYMessageViewModel *)messageViewModel {
    if (!_messageViewModel) {
        _messageViewModel = [[YYMessageViewModel alloc] init];
    }
    return _messageViewModel;
}

- (YYLoginViewModel *)loginViewModel {
    if (!_loginViewModel) {
        _loginViewModel = [[YYLoginViewModel alloc] init];
    }
    return _loginViewModel;
}

- (YYRegisterViewModel *)registerViewModel {
    if (!_registerViewModel) {
        _registerViewModel = [[YYRegisterViewModel alloc] init];
    }
    return _registerViewModel;
}

@end
