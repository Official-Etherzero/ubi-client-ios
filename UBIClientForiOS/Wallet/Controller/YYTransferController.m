//
//  YYTransferController.m
//  UBIClientForiOS
//
//  Created by yang on 2020/4/14.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYTransferController.h"
#import "YYViewHeader.h"
#import "YYPlaceholderView.h"
#import "YYTextView.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "YYUserInfoViewModel.h"
#import "YYUserDefaluts.h"
#import "YYUserInfoModel.h"
#import "NSString+Ext.h"
#import "YYTransferView.h"
#import "YYNavigationView.h"
#import "YYTransferDetailController.h"

@interface YYTransferController ()
<YYNavigationViewDelegate>

@property (nonatomic, strong) YYLabel              *assetsView;
@property (nonatomic, strong) YYPlaceholderView    *dataView;
@property (nonatomic, strong) YYPlaceholderView    *acountView;
@property (nonatomic, strong) YYButton             *confirmView;
@property (nonatomic, strong) YYButton             *allView;
@property (nonatomic, strong) YYUserInfoModel      *model;
@property (nonatomic, strong) YYUserInfoViewModel  *viewModel;
@property (nonatomic,   copy) NSString             *scanString;
@property (nonatomic, strong) YYNavigationView     *navView;

@end

@implementation YYTransferController

- (instancetype)initWithScanString:(NSString *)str {
    if (self = [super init]) {
        self.scanString = str;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_151824;
    self.navigationItem.title = YYStringWithKey(@"转账");
    [self initSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self initViewModel];
}

- (void)initSubViews {
    
    self.navView = [[YYNavigationView alloc] initWithNavigationItem:self.navigationItem];
    self.navView.delegate = self;
    [self.navView custom];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = COLOR_19213a;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_14);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_14);
        }
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_12_5);
        make.size.mas_offset(CGSizeMake(YYSIZE_350, YYSIZE_60));
    }];
    
    UIImageView *leftView = [[UIImageView alloc] init];
    leftView.image = [UIImage imageNamed:@"coin_ubi"];
    [bottomView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomView.mas_left).offset(YYSIZE_10);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
    }];
    
    YYLabel *rightView = [[YYLabel alloc] initWithFont:FONT_DESIGN_34 textColor:COLOR_ffffff text:@"UBI"];
    [bottomView addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.left.mas_equalTo(leftView.mas_right).offset(YYSIZE_12);
    }];
    
    YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_30 textColor:COLOR_ffffff text:YYStringWithKey(@"可转资产")];
    [self.view addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_bottom).offset(YYSIZE_30);
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_21);
    }];
    
    
    self.assetsView = [[YYLabel alloc] initWithFont:FONT_DESIGN_34 textColor:COLOR_feb43c text:@"0"];
    [self.view addSubview:self.assetsView];
    [self.assetsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleView.mas_centerY);
        make.left.mas_equalTo(titleView.mas_right).offset(YYSIZE_12_5);
    }];
    
    self.dataView = [[YYPlaceholderView alloc] initWithAttackViewFont:FONT_DESIGN_34 height:YYSIZE_40 plcStr:YYStringWithKey(@"数量")];
    [self.view addSubview:self.dataView];
    [self.dataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_12_5);
        make.top.mas_equalTo(titleView.mas_bottom).mas_offset(YYSIZE_15);
        make.size.mas_offset(CGSizeMake(YYSIZE_350, YYSIZE_60));
    }];
    
    self.allView = [[YYButton alloc] initWithFont:FONT_DESIGN_34 title:YYStringWithKey(@"全部") titleColor:COLOR_4c7aff];
    [self.view addSubview:self.allView];
    self.allView.stretchLength = 20.0f;
    [self.allView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.dataView.mas_centerY);
        make.right.mas_equalTo(self.dataView.mas_right).offset(-YYSIZE_25);
    }];
    WDWeakify(self);
    [self.allView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        if (self.model.ETZ) {
            self.dataView.content = self.model.ETZ;
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.acountView = [[YYPlaceholderView alloc] initWithAttackViewFont:FONT_DESIGN_34 height:YYSIZE_40 plcStr:YYStringWithKey(@"请输入UID")];
    [self.view addSubview:self.acountView];
    [self.acountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dataView);
        make.top.mas_equalTo(self.dataView.mas_bottom).offset(YYSIZE_13);
        make.size.mas_offset(CGSizeMake(YYSIZE_350, YYSIZE_60));
    }];
    
    YYLabel *desView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_34466e text:YYStringWithKey(@"仅限UBI内部转账，扣取30%手续费")];
    [self.view addSubview:desView];
    [desView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_21);
        make.top.mas_equalTo(self.acountView.mas_bottom).offset(YYSIZE_25);
    }];
    
    self.confirmView = [[YYButton alloc] initWithFont:FONT_DESIGN_36 borderWidth:0 borderColoer:COLOR_486cff.CGColor masksToBounds:YES title:YYStringWithKey(@"确认转出") titleColor:COLOR_ffffff backgroundColor:COLOR_486cff cornerRadius:22.5];
    [self.view addSubview:self.confirmView];
    [self.confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.acountView.mas_bottom).offset(YYSIZE_80);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_300, YYSIZE_45));
    }];
    [self.confirmView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        [self transferAmout];
    } forControlEvents:UIControlEventTouchUpInside];
    
    if (self.scanString) {
        self.acountView.content = self.scanString;
    }
}

- (void)transferAmout {
    WDWeakify(self);
    if ([self.dataView.content integerValue] == 0) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入转账金额") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (!self.acountView.content) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入转账账号") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (self.acountView.content.length != 8) {
        [YYToastView showCenterWithTitle:YYStringWithKey(@"账号不存在") attachedView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    [YYTransferView showPasswordViewConfirmBlock:^(NSString * _Nonnull psd) {
        WDStrongify(self);
               [self.viewModel yy_viewModelTrsferWithToken:[YYUserDefaluts yy_getAccessTokeCache] password:psd targetPhone:self.acountView.content amount:self.dataView.content success:^(id  _Nonnull responseObject) {
                   [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
                   [self initViewModel];
               } failure:^(NSError * _Nonnull error) {
                   [YYToastView showCenterWithTitle:error.localizedDescription attachedView:[UIApplication sharedApplication].keyWindow];
               }];
    } cancelBlock:nil];
}

- (void)initViewModel {
    WDWeakify(self);
    [self.viewModel yy_viewModelGetUserInfoWithToken:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[YYUserInfoModel class]]) {
            WDStrongify(self);
            self.model = responseObject;
            self.assetsView.text = [self.model.ETZ yy_holdDecimalPlaceToIndex:6];
        }
    } failure:^(NSError * _Nonnull error) {
        [YYToastView showCenterWithTitle:error.localizedDescription attachedView:[UIApplication sharedApplication].keyWindow];
    }];
}

#pragma mark - YYNavigationViewDelegate
- (void)yyNavigationViewReturnClick:(YYNavigationView *)view {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)yyNavigationViewConfirmClick:(YYNavigationView *)view {
    [self.navigationController pushViewController:[[YYTransferDetailController alloc] init] animated:YES];
}

#pragma mark - lazy

- (YYUserInfoViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYUserInfoViewModel alloc] init];
    }
    return _viewModel;
}

@end
