//
//  WDCollectionController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDCollectionController.h"
#import "YYViewHeader.h"
#import "SGQRCodeObtain.h"
#import "AccountModel.h"
#import "WDWalletUserInfo.h"
#import "YYToastView.h"
#import "WalletDataManager.h"
#import "YYUserDefaluts.h"

@interface WDCollectionController ()

@property (nonatomic, strong) SGQRCodeObtain *obtain;
@property (nonatomic, strong) AccountModel   *model;
@property (nonatomic, strong) UIImageView    *imageView;
@property (nonatomic, strong) UILabel        *label;
@property (nonatomic, strong) UIButton       *button;
@property (nonatomic,   copy) NSString       *address;

@end

@implementation WDCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_151824;
    [self initSubViews];
    self.obtain = [SGQRCodeObtain QRCodeObtain];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initDatas];
}

- (void)initSubViews {
    self.imageView = [UIImageView new];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(114);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(200, 200));
    }];
    
    self.label = [UILabel new];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = COLOR_ffffff;
    self.label.font = FONT_DESIGN_24;
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(25);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.button];
    [self.button.titleLabel setFont:FONT_DESIGN_30];
    [self.button setBackgroundColor:COLOR_476cff];
    [self.button setTitleColor:COLOR_d9dbdb forState:UIControlStateDisabled];
    [self.button setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    [self.button setTitleColor:COLOR_59dab4 forState:UIControlStateSelected];
    self.button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.button.layer setMasksToBounds:YES];
    self.button.layer.cornerRadius = 25.0f;
    [self.button setTitle:YYStringWithKey(@"复制收款账号") forState:UIControlStateNormal];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.label.mas_bottom).offset(50);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(331, 50));
    }];
    [self.button addTarget:self action:@selector(copyWalletAddressClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initDatas {
//    self.model = [WalletDataManager accountModel];
    self.address = [YYUserDefaluts yy_getUserId];
    self.label.text = [YYUserDefaluts yy_getUserId];
    self.imageView.image = [SGQRCodeObtain generateQRCodeWithData:self.address size:200];
}

#pragma mark -

- (void)copyWalletAddressClick {
    if (self.address) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.address;
    }
    [YYToastView showAboveWithTitle:YYStringWithKey(@"复制成功") attachedView:self.view];
}
@end
