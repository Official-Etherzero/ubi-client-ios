//
//  WDGoogleValidationController.m
//  UBIClientForiOS
//
//  Created by yang on 2020/2/26.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "WDGoogleValidationController.h"
#import "YYViewHeader.h"
#import "YYValidationCodeView.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "YYToastView.h"
#import "UIView+Ext.h"
#import "YYUserInfoViewModel.h"
#import "WalletDataManager.h"
#import "GoogleModel.h"
#import "SGQRCodeObtain.h"

@interface WDGoogleValidationController ()

@property (nonatomic, strong) YYValidationCodeView  *codeView;
@property (nonatomic, strong) UIImageView           *qrCodeView;
@property (nonatomic, strong) YYLabel               *googleCodeView;
@property (nonatomic, strong) YYButton              *cpView;
@property (nonatomic, strong) YYButton              *bindView;
@property (nonatomic, strong) YYUserInfoViewModel   *viewModel;
@property (nonatomic,   copy) NSString              *codeString;

@end

@implementation WDGoogleValidationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_151824;
    self.navigationItem.title = YYStringWithKey(@"谷歌验证绑定");
    [self initSubViews];
    [self initViewModel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage yy_imageWithColor:COLOR_151824] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : COLOR_ffffff,
                                                                      NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
}


- (void)initSubViews {
    self.qrCodeView = [[UIImageView alloc] init];
    [self.view addSubview:self.qrCodeView];
    [self.qrCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_25);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_25);
        }
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_47);
        make.size.mas_offset(CGSizeMake(YYSIZE_125, YYSIZE_125));
    }];
    
    self.googleCodeView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_476cff text:@"JP2SSBKHJK22890JH"];
    [self.view addSubview:self.googleCodeView];
    [self.googleCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.qrCodeView.mas_top).offset(YYSIZE_35);
        make.left.mas_equalTo(self.qrCodeView.mas_right).offset(YYSIZE_20);
    }];
    
    self.cpView = [[YYButton alloc] initWithFont:FONT_DESIGN_24 title:YYStringWithKey(@"复制秘钥") titleColor:COLOR_476cff];
    [self.view addSubview:self.cpView];
    self.cpView.layer.cornerRadius = 2.0f;
    self.cpView.clipsToBounds = YES;
    self.cpView.backgroundColor = COLOR_1b213b;
    [self.cpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.qrCodeView.mas_right).offset(YYSIZE_20);
        make.top.mas_equalTo(self.googleCodeView.mas_bottom).offset(YYSIZE_20);
        make.size.mas_offset(CGSizeMake(YYSIZE_70, YYSIZE_25));
    }];
    WDWeakify(self);
    [self.cpView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.googleCodeView.text;
        [YYToastView showCenterWithTitle:YYStringWithKey(@"复制成功") attachedView:self.view];
    } forControlEvents:UIControlEventTouchUpInside];
    
    YYLabel *firstView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_ffffff text:YYStringWithKey(@"•  请将上面的密钥复制或扫码添加到谷歌验证器")];
    firstView.numberOfLines = 0;
    [self.view addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_26);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.qrCodeView.mas_bottom).offset(YYSIZE_28);
    }];
    
    YYLabel *secondView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_ffffff text:YYStringWithKey(@"•  请妥善备份保管好密钥，用于手机更换或遗失时恢复谷歌验证器")];
    [self.view addSubview:secondView];
    secondView.numberOfLines = 0;
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_26);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(firstView.mas_bottom).offset(YYSIZE_08);
    }];
    
    YYLabel *thirdView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_ffffff text:YYStringWithKey(@"•  请在输入框输入6位数的谷歌验证码")];
    [self.view addSubview:thirdView];
    thirdView.numberOfLines = 0;
    [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_26);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(secondView.mas_bottom).offset(YYSIZE_08);
    }];
    
    CGFloat CodeViewHeight;
    if (IS_IPHONE_X_orMore) {
        CodeViewHeight = YYSIZE_327 + YYSIZE_24;
    } else {
        CodeViewHeight = YYSIZE_327;
    }
    self.codeView = [[YYValidationCodeView alloc] initWithFrame:CGRectMake(YYSIZE_22, CodeViewHeight, YYSIZE_331, YYSIZE_50) labelCount:6 labelDistance:6];
    [self.view addSubview:self.codeView];
    self.codeView.codeBlock = ^(NSString *codeString) {
        NSLog(@"验证码:%@", codeString);
        WDStrongify(self);
        self.codeString = codeString;
    };
    
    self.bindView = [[YYButton alloc] initWithFont:FONT_PingFangSC_Medium_32 borderWidth:0 borderColoer:COLOR_476cff.CGColor masksToBounds:YES title:YYStringWithKey(@"绑定") titleColor:COLOR_ffffff backgroundColor:COLOR_476cff cornerRadius:28.0f];
    [self.view addSubview:self.bindView];
    [self.bindView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeView.mas_bottom).offset(YYSIZE_20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_57));
    }];
    [self.bindView bk_addEventHandler:^(id  _Nonnull sender) {
        // 绑定操作
        WDStrongify(self);
        [self bindingGoogle];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)initViewModel {
    WDWeakify(self);
    [self.viewModel yy_viewModelGoogleVerifyQrCodeWithAddress:[WalletDataManager accountModel].address success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[GoogleModel class]]) {
            WDStrongify(self);
            GoogleModel *model = responseObject;
            self.googleCodeView.text = model.SecretKey;
            self.qrCodeView.image = [SGQRCodeObtain generateQRCodeWithData:model.QRStr size:YYSIZE_125];
        }
    } failure:nil];
}

- (void)bindingGoogle {
    if (!self.codeString || (self.codeString && self.codeString.length < 6)) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入谷歌验证码") attachedView:self.view];
        return;
    }
    WDWeakify(self);
    [self.viewModel yy_viewModelGoogleBindingWithAddress:[WalletDataManager accountModel].address code:self.codeString success:^(id  _Nonnull responseObject) {
        WDStrongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:nil];
}

#pragma mark - lazy

- (YYUserInfoViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYUserInfoViewModel alloc] init];
    }
    return _viewModel;
}

@end
