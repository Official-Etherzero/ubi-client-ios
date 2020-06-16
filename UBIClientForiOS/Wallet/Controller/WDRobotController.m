//
//  WDRobotController.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDRobotController.h"
#import "YYUserInfoViewModel.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import "UserInfoModel.h"
#import "YYRegisterLoginView.h"
#import "YYToastView.h"
#import "YYNavigationView.h"
#import "RobotTitleView.h"
#import "YYMillViewModel.h"
#import "YYUserDefaluts.h"
#import "RobotTopView.h"
#import "RobotBottomView.h"
#import "RobotMoreFunctionView.h"
#import "MiningInfosModel.h"
#import "CalculateStatisticalModel.h"
#import "WDRobotListController.h"
#import <BlocksKit/BlocksKit.h>
#import "RunningRobotView.h"
#import "RunningRobotModel.h"
#import "WDWalletUserInfo.h"
#import "WDRobotDetailController.h"
#import "RobotMoreFunctionView.h"
#import "WDTabbarController.h"

#import "YYUserInfoModel.h"
#import "YYNodeViewModel.h"
#import "NodeModel.h"
#import "MySelfNodeModel.h"

@interface WDRobotController ()
<YYNavigationViewDelegate>

@property (nonatomic, strong) RunningRobotView    *runningRobotView;
@property (nonatomic, strong) YYRegisterLoginView *registerLoginView;
@property (nonatomic, strong) YYNavigationView    *navigationView;
@property (nonatomic, strong) RobotTopView        *topView;
@property (nonatomic, strong) RobotBottomView     *bottomView;
@property (nonatomic, strong) RobotMoreFunctionView *functionView;
@property (nonatomic, strong) YYUserInfoViewModel *userInfoViewModel;
@property (nonatomic, strong) YYMillViewModel     *millViewModel;
@property (nonatomic, strong) YYUserInfoModel     *infoModel;
@property (nonatomic, strong) CalculateStatisticalModel *calculateModel;
@property (nonatomic, strong) YYNodeViewModel     *nodeViewModel;

@end

@implementation WDRobotController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_151824;
    self.navigationItem.title = YYStringWithKey(@"我的机器人");
    [self initSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage yy_imageWithColor:COLOR_151824] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : COLOR_ffffff,
                                                                      NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
    [self getUserInfo];
    [self getMyNodes];
}

- (void)initSubViews {
    self.navigationView = [[YYNavigationView alloc] initWithNavigationItem:self.navigationItem];
    [self.navigationView custom];
    self.navigationView.delegate = self;
    
    self.topView = [[RobotTopView alloc] init];
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(YYSIZE_270);
    }];
    
    self.bottomView = [[RobotBottomView alloc] init];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).offset(YYSIZE_10);
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    WDWeakify(self);
    self.bottomView.addMinerBlock = ^{
        WDStrongify(self);
        [self enterRobotListController];
    };
    
    self.runningRobotView = [[RunningRobotView alloc] init];
    self.runningRobotView.hidden = YES;
    [self.view addSubview:self.runningRobotView];
    [self.runningRobotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomView.mas_top).offset(YYSIZE_20);
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    self.runningRobotView.addRobotBlock = ^{
        WDStrongify(self);
        [self enterRobotListController];
    };
    
    self.runningRobotView.selectedRobotBlock = ^(NodeDetailModel * _Nonnull model) {
        WDStrongify(self);
        WDRobotDetailController *vc = [[WDRobotDetailController alloc] initRobotDetailWithModel:model];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    self.functionView = [[RobotMoreFunctionView alloc] initWithIcons:@[@"jilu",@"huazhan",@"jiangli"] titles:@[@"购买记录",@"划转奖励",@"奖励记录"]];
    self.functionView.hidden = YES;
    self.functionView.selectedTagBlock = ^(NSInteger tag) {
        WDStrongify(self);
        self.functionView.hidden = YES;
        if (tag == 1) {
            [UIApplication sharedApplication].delegate.window.rootViewController = [WDTabbarController setupViewControllersWithIndex:1];
        }
    };
}

- (void)enterRobotListController {
    WDRobotListController *vc = [[WDRobotListController alloc] initWithInfoModel:self.infoModel];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getMyNodes {
    [self.nodeViewModel yy_viewModelMyNodeListWithPageSize:1 currentPage:500 token:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[MySelfNodeModel class]]) {
            MySelfNodeModel *model = responseObject;
            if (model.UserNodeList.count > 0) {
                self.runningRobotView.hidden = NO;
                self.runningRobotView.models = model.UserNodeList;
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [YYToastView showCenterWithTitle:error.localizedDescription attachedView:[UIApplication sharedApplication].keyWindow];
    }];
}

- (void)getUserInfo {
    WDWeakify(self);
    [self.userInfoViewModel yy_viewModelGetUserInfoWithToken:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        WDStrongify(self);
        if ([responseObject isKindOfClass:[YYUserInfoModel class]]) {
            self.infoModel = responseObject;
            self.topView.model = responseObject;
        } else {
            [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
        }
    } failure:^(NSError * _Nonnull error) {
        [YYToastView showCenterWithTitle:error.localizedDescription attachedView:[UIApplication sharedApplication].keyWindow];
    }];
}

#pragma mark - YYNavigationViewDelegate

- (void)yyNavigationViewReturnClick:(YYNavigationView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)yyNavigationViewConfirmClick:(YYNavigationView *)view {
    self.functionView.hidden = NO;
}

#pragma mark - lazy

- (YYNodeViewModel *)nodeViewModel {
    if (!_nodeViewModel) {
        _nodeViewModel = [[YYNodeViewModel alloc] init];
    }
    return _nodeViewModel;
}

- (YYUserInfoViewModel *)userInfoViewModel {
    if (!_userInfoViewModel) {
        _userInfoViewModel = [[YYUserInfoViewModel alloc] init];
    }
    return _userInfoViewModel;
}

- (YYUserInfoModel *)infoModel {
    if (!_infoModel) {
        _infoModel = [[YYUserInfoModel alloc] init];
    }
    return _infoModel;
}
@end
