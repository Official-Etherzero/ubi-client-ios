//
//  WDWalletViewController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDWalletViewController.h"

#import "WDRobotController.h"
#import "WDRobotListController.h"
#import "WDScanCodeController.h"
#import "WDCollectionController.h"
#import "WDMineViewController.h"

#import "AccountModel.h"
#import "WalletDataManager.h"
#import "LocalServer.h"
#import "WDWalletUserInfo.h"
#import "YYDateModel.h"
#import "YYUserDefaluts.h"
#import "YYExchangeRateModel.h"
#import "WalletDataManager.h"
#import "YYMillViewModel.h"
#import "RobotEarningsModel.h"
#import "YYUserInfoViewModel.h"
#import "BlanceModel.h"
#import "YYUserInfoModel.h"

#import "WalletHeaderView.h"
#import "YYInterfaceMacro.h"
#import "UIViewController+CWLateralSlide.h"
#import "YYAlertView+Ext.h"
#import "TokenListView.h"
#import "YYViewHeader.h"
#import "YYAddress.h"
#import "UIViewController+Ext.h"
#import "YYToastView.h"
#import "YYFunctionView.h"
#import "YYWalletTopView.h"
#import "RobotCardView.h"
#import "YYUBIiCarouselView.h"
#import "WDTabbarController.h"
#import "WDGoogleValidationController.h"
#import "YYUBICardView.h"
#import "YYTeamNodeController.h"
#import "YYTransferController.h"
#import "YYTransferView.h"
#import "YYNodeViewModel.h"
#import "RequestModel.h"

#import <BlocksKit/BlocksKit.h>

#import "TerminalModel.h"
#import "NSString+AES.h"

@interface WDWalletViewController ()

@property (nonatomic, strong) NSMutableArray         *addresses;
@property (nonatomic,   copy) NSString               *praviteString;
@property (nonatomic, strong) AccountModel           *account;
@property (nonatomic,   copy) NSArray<RateModel *>   *rateModels;
@property (nonatomic, strong) YYWalletTopView        *topView;
@property (nonatomic, strong) RobotCardView          *robotCardView;
@property (nonatomic, strong) YYUBIiCarouselView     *carouselView;
@property (nonatomic, strong) YYMillViewModel        *millViewModel;
@property (nonatomic, strong) YYUserInfoViewModel    *userInfoViewModel;
@property (nonatomic, strong) YYUBICardView          *cardView;
@property (nonatomic, strong) YYNodeViewModel        *nodeViewModel;

@end

/** 进入钱包就一直需要去刷新代币的价格*/

@implementation WDWalletViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    self.view.backgroundColor = COLOR_151824;
    [super viewDidLoad];
    [self initSubViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotifyAccountBalanceChange:) name:kAPIAccountModel object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage yy_imageWithColor:COLOR_151824] forBarMetrics:UIBarMetricsDefault];
    [self yy_hideTabBar:NO];
    [self initialDatas];
}

- (void)initialDatas {
    [self getMillInfo];
}

- (void)initSubViews {
   
    WDWeakify(self);
    // topView
    self.topView = [[YYWalletTopView alloc] init];
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, YYSIZE_35));
    }];
    self.topView.setBlock = ^{
        WDStrongify(self);
        [self showMineViewController];
    };
    
    self.topView.scanBlock = ^{
        [LocalServer syncAVCaptureDeviceForAuthorizationCompleteHandler:^(NSError * _Nonnull error) {
            WDStrongify(self)
            if (error == nil) {
                [self.navigationController pushViewController:[[WDScanCodeController alloc] initWithTitle:YYStringWithKey(@"扫一扫")] animated:YES];
            }
        }];
    };
    // 中间 175
    self.cardView = [[YYUBICardView alloc] init];
    [self.view addSubview:self.cardView];
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_300, YYSIZE_175));
        make.top.mas_equalTo(self.topView.mas_bottom);
    }];
    self.cardView.functionBlock = ^(NSInteger index) {
        WDStrongify(self);
        switch (index) {
            case 0: // 转账
            {
                YYTransferController *vc = [[YYTransferController alloc] initWithTitle:YYStringWithKey(@"转账")];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1: // 收款
            {
                [self.navigationController pushViewController:[[WDCollectionController alloc] initWithTitle:YYStringWithKey(@"收款")] animated:YES];
            }
                break;
            case 2: // 划转
            {
                [UIApplication sharedApplication].delegate.window.rootViewController = [WDTabbarController setupViewControllersWithIndex:1];
            }
                break;
            default:
                break;
        }
    };
    
    // advertView button - 跳转交易页面
    YYButton *advertView = [YYButton buttonWithType:UIButtonTypeCustom];
    [advertView setImage:[UIImage imageNamed:@"banner"] forState:UIControlStateNormal];
    [self.view addSubview:advertView];
    [advertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).offset(YYSIZE_204);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_75));
    }];
    [advertView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        [self showTransferView];
    } forControlEvents:UIControlEventTouchUpInside];
    
    // titleView robotBtn
    YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_36 textColor:COLOR_ffffff text:YYStringWithKey(@"我的机器人")];
    [self.view addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_25);
        make.top.mas_equalTo(advertView.mas_bottom).offset(YYSIZE_25);
    }];
    
    YYButton *robotView = [YYButton buttonWithType:UIButtonTypeCustom];
    [robotView setImage:[UIImage imageNamed:@"into"] forState:UIControlStateNormal];
    robotView.stretchLength = 10.0f;
    [self.view addSubview:robotView];
    [robotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleView.mas_centerY);
        make.right.mas_equalTo(self.view.mas_right).offset(-YYSIZE_22);
    }];
    [robotView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        WDRobotController *vc = [[WDRobotController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.robotCardView = [[RobotCardView alloc] init];
    [self.view addSubview:self.robotCardView];
    self.robotCardView.layer.cornerRadius = 10.0f;
    self.robotCardView.clipsToBounds = YES;
    [self.robotCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_12);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_170));
    }];
    
    self.robotCardView.tapTeamNodeBlock = ^{
        WDStrongify(self);
        YYTeamNodeController *teamNodeVC = [[YYTeamNodeController alloc] init];
        [self.navigationController pushViewController:teamNodeVC animated:YES];
    };
}

- (void)showTransferView {
    WDWeakify(self);
    [YYTransferView showPasswordViewConfirmBlock:^(NSString * _Nonnull psd) {
        WDStrongify(self);
        [self.nodeViewModel yy_viewModelGetFreeNodeWithToken:[YYUserDefaluts yy_getAccessTokeCache] password:psd success:^(id  _Nonnull responseObject) {
            if (responseObject) {
                [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
            }
        } failure:^(NSError * _Nonnull error) {
            [YYToastView showCenterWithTitle:error.localizedDescription attachedView:[UIApplication sharedApplication].keyWindow];
        }];
    } cancelBlock:nil];
}

- (void)showMineViewController {
    WDMineViewController *vc = [[WDMineViewController alloc] init];
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration defaultConfiguration];
    conf.direction = CWDrawerTransitionFromLeft; // 从右边滑出
    conf.finishPercent = 0.2f;
    conf.showAnimDuration = 0.2;
    conf.HiddenAnimDuration = 0.2;
    conf.maskAlpha = 0.1;
    [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeDefault configuration:conf];
}

- (void)getAccountModel {
    if ([WDWalletUserInfo allObjects].count > 0) {
        NSInteger index = [YYUserDefaluts yy_getAccountModelIndex];
        self.account = [WalletDataManager getAccountsForDataBase][index];
    }
}

- (void)getMillInfo {
    // 查询用户信息
    WDWeakify(self);
    [self.userInfoViewModel yy_viewModelGetUserInfoWithToken:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        WDStrongify(self);
        if ([responseObject isKindOfClass:[YYUserInfoModel class]]) {
            self.robotCardView.infoModel = responseObject;
            self.cardView.balance = self.robotCardView.infoModel.ETZ;
        } else {
            [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
            NSLog(@"123%@",responseObject);
        }
    } failure:^(NSError * _Nonnull error) {
        [YYToastView showCenterWithTitle:error.localizedDescription attachedView:[UIApplication sharedApplication].keyWindow];
    }];
}

#pragma mark -notify

- (void)onNotifyAccountBalanceChange:(NSNotification *)notification {
    AccountModel *model = notification.userInfo[kAPIAccountModelInfo];
    dispatch_async_main_safe(^{
        if ([model.address isEqualToString:self.account.address]) {
            // 单一去赋值
            self.account.balance = model.balance;
        }
    });
}

#pragma mark - lazy

- (YYMillViewModel *)millViewModel {
    if (!_millViewModel) {
        _millViewModel = [[YYMillViewModel alloc] init];
    }
    return _millViewModel;
}

- (YYUserInfoViewModel *)userInfoViewModel {
    if (!_userInfoViewModel) {
        _userInfoViewModel = [[YYUserInfoViewModel alloc] init];
    }
    return _userInfoViewModel;
}

- (YYNodeViewModel *)nodeViewModel {
    if (!_nodeViewModel) {
        _nodeViewModel = [[YYNodeViewModel alloc] init];
    }
    return _nodeViewModel;
}

#pragma mark -RDVItemStyleDelegate

- (UIImage *)rdvItemNormalImage {
    return [UIImage imageNamed:@"asset"];
}

- (UIImage *)rdvItemHighLightImage {
    return [UIImage imageNamed:@"asset_sel"];
}

- (NSString *)rdvItemTitle {
    return YYStringWithKey(@"资产");
}

@end
