//
//  WDMineViewController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDMineViewController.h"
#import "YYColor.h"
#import "SettingDataSource.h"
#import "PersonalCenterCell.h"
#import "PersonalHeader.h"
#import "SettingRowModel.h"
#import "YYLanguageTool.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import "WalletDataManager.h"
#import "WDSettingLanguageSelectorController.h"
#import "WDHelpCenterController.h"
#import "WDAboutUSController.h"
#import "WDGoogleValidationController.h"
#import "YYInviteFriendsController.h"
#import "YYRealNameCertificationController.h"
#import "UIViewController+Ext.h"
#import "YYMyQRCodeController.h"

#import "WDTabbarController.h"
#import "UIViewController+CWLateralSlide.h"
#import "YYUserDefaluts.h"
#import "YYLoginController.h"
#import "YYUserHeaderView.h"
#import "YYUserInfoViewModel.h"
#import "YYUserInfoModel.h"


#define WALLET_MANAGER [NSIndexPath indexPathForRow:0 inSection:0]
#define LANGUAGE_SET [NSIndexPath indexPathForRow:0 inSection:1]
#define NODE_CHANGE [NSIndexPath indexPathForRow:1 inSection:1]
#define GOOGLE_VALIDATION [NSIndexPath indexPathForRow:0 inSection:2]
#define HELP_CENTER [NSIndexPath indexPathForRow:1 inSection:2]
#define ABOUT_US [NSIndexPath indexPathForRow:2 inSection:2]

#define REAL_NAME [NSIndexPath indexPathForRow:0 inSection:0]
#define LAN_SET [NSIndexPath indexPathForRow:1 inSection:0]
#define INVITE_F [NSIndexPath indexPathForRow:2 inSection:0]
#define HELP_C [NSIndexPath indexPathForRow:3 inSection:0]
#define MY_CODE [NSIndexPath indexPathForRow:4 inSection:0]

@interface WDMineViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) YYUserHeaderView  *headView;
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSArray           *items;
@property (nonatomic, strong) SettingDataSource *settingDataSource;
@property (nonatomic, strong) NSMutableArray    *wallets;
@property (nonatomic, strong) NSMutableArray    *systems;
@property (nonatomic, strong) NSMutableArray    *otheres;
@property (nonatomic, strong) NSMutableArray    *list;
@property (nonatomic, strong) YYButton          *backBtn;
@property (nonatomic, strong) YYUserInfoViewModel *viewModel;


@end

@implementation WDMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = YYStringWithKey(@"个人中心");
    self.view.backgroundColor = COLOR_151824;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setTableView];
    [self initCellData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self yy_hideTabBar:NO];
    [self initViewModel];
//    [UIApplication sharedApplication].delegate.window.rootViewController = [WDTabbarController setupViewControllersWithIndex:2];
}

#pragma mark - property

- (void)setTableView {
    
    self.headView = [[YYUserHeaderView alloc] init];
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(YYSIZE_20);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).mas_offset(YYSIZE_20);
        }
        make.height.mas_offset(YYSIZE_80);
    }];
    
    self.backBtn = [[YYButton alloc] initWithFont:FONT_DESIGN_30 borderWidth:0 borderColoer:COLOR_ffffff.CGColor masksToBounds:YES title:YYStringWithKey(@"退出登录") titleColor:COLOR_5d4fe0 backgroundColor:COLOR_ffffff_A01 cornerRadius:YYSIZE_12_5];
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            // 83;
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-YYSIZE_28);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).offset(-YYSIZE_28);
        }
        make.left.mas_equalTo(self.view.mas_left).offset(YYSIZE_25);
        // height 45
        make.size.mas_offset(CGSizeMake(YYSIZE_75, YYSIZE_25));
    }];
    self.backBtn.stretchLength = 20.0f;
    [self.backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = COLOR_151824;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        if (iOS11) {
//            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_40);
////            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
//        } else {
//            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
////            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
//        }
        make.top.mas_equalTo(self.headView.mas_bottom).offset(YYSIZE_05);
        make.bottom.mas_equalTo(self.backBtn.mas_top).offset(-YYSIZE_10);
        make.left.right.mas_equalTo(self.view);
    }];
    self.tableView.rowHeight = YYSIZE_44;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[PersonalHeader class]
forHeaderFooterViewReuseIdentifier:PersonalHeader.identifier];
    [self.tableView registerClass:[PersonalCenterCell class]
           forCellReuseIdentifier:PersonalCenterCell.identifier];
}

- (void)initViewModel {
    WDWeakify(self);
    [self.viewModel yy_viewModelGetUserInfoWithToken:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        WDStrongify(self);
        if ([responseObject isKindOfClass:[YYUserInfoModel class]]) {
            YYUserInfoModel *model = responseObject;
            self.headView.infoModel = model;
            if (model.IsTrueName == 1) {
                [YYUserDefaluts yy_setIsRealName:YES];
            }
        }
    } failure:nil];
}

- (void)backClick {
    // 清理缓存
    [self clearCache];
    [self dismissLoginView];
}

- (void)dismissLoginView {
    YYLoginController *vc = [YYLoginController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
//    [self presentViewController:vc animated:YES completion:nil];
    vc.loginBlock = ^{
        [UIApplication sharedApplication].delegate.window.rootViewController
        = [WDTabbarController setupViewControllersWithIndex:0];
    };
//    WDWeakify(self);
//    vc.dismissBlock = ^{
//        WDStrongify(self);
//        [self dismissLoginView];
//    };
}

- (void)clearCache {
    // 清除缓存
    [YYUserDefaluts yy_setIsRealName:NO];
    [YYUserDefaluts yy_removeAccessTokenCache];
    [YYUserDefaluts yy_clearUserInfo];
    [YYUserDefaluts yy_clearUserId];
}

- (void)initCellData {
    self.settingDataSource = [SettingDataSource new];
    self.wallets = [NSMutableArray array];
    self.systems = [NSMutableArray array];
    self.otheres = [NSMutableArray array];
    
    [self.list addObjectsFromArray:@[[SettingRowModel modelWithImageName:@"rl_nam" title:YYStringWithKey(@"实名认证") rowType:WDSettingRowTypeArrow],
                                     [SettingRowModel modelWithImageName:@"language_set" title:YYStringWithKey(@"语言设置") rowType:WDSettingRowTypeArrow],
                                     [SettingRowModel modelWithImageName:@"in_friend" title:YYStringWithKey(@"邀请好友") rowType:WDSettingRowTypeArrow],
                                     [SettingRowModel modelWithImageName:@"help_center" title:YYStringWithKey(@"帮助中心") rowType:WDSettingRowTypeArrow],
                                     [SettingRowModel modelWithImageName:@"cl_code" title:YYStringWithKey(@"收款二维码") rowType:WDSettingRowTypeArrow]]];
    
//    [self.wallets addObjectsFromArray:@[[SettingRowModel modelWithImageName:@"wallet_manager" title:YYStringWithKey(@"钱包管理") rowType:WDSettingRowTypeArrow]]];
//    [self.systems addObjectsFromArray:@[[SettingRowModel modelWithImageName:@"language_set"         title:YYStringWithKey(@"语言设置") rowType:WDSettingRowTypeArrow],
//                                        [SettingRowModel modelWithImageName:@"node_change" title:YYStringWithKey(@"节点切换") rowType:WDSettingRowTypeArrow]]];
//    [self.otheres addObjectsFromArray:@[[SettingRowModel modelWithImageName:@"google" title:YYStringWithKey(@"谷歌验证") rowType:WDSettingRowTypeArrow],
//                                        [SettingRowModel modelWithImageName:@"help_center" title:YYStringWithKey(@"帮助中心") rowType:WDSettingRowTypeArrow],
//                                        [SettingRowModel modelWithImageName:@"about_us" title:YYStringWithKey(@"关于我们") rowType:WDSettingRowTypeArrow]]];
//
//    self.settingDataSource.sections = @[[SettingHeaderModel modelWithTitle:YYStringWithKey(@"钱包") cells:self.wallets],
//                                         [SettingHeaderModel modelWithTitle:YYStringWithKey(@"系统设置") cells:self.systems],
//                                         [SettingHeaderModel modelWithTitle:YYStringWithKey(@"其它") cells:self.otheres]].mutableCopy;
    [self.tableView reloadData];
}

#pragma mark -UITableViewDataSource

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.settingDataSource.numberOfSection;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    PersonalHeader *header = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:PersonalHeader.identifier];
//    header.model = [self.settingDataSource sectionModelWithSection:section];
//    return header;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalCenterCell *cell = [self.tableView dequeueReusableCellWithIdentifier:PersonalCenterCell.identifier
                                                                   forIndexPath:indexPath];
    cell.model = self.list[indexPath.row];
    return cell;
}

#pragma mark -UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return PersonalHeader.height;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YYSIZE_60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    SettingRowModel *model = [self.settingDataSource rowWithIndexPath:indexPath];
//    if (NSIndexPathEqual(indexPath, WALLET_MANAGER)) {
//        WDPersonalWalletDetailController *vc = [[WDPersonalWalletDetailController alloc] initWithAccountModel:[WalletDataManager accountModel]];
//        [self cw_pushViewController:vc];
//    } else if (NSIndexPathEqual(indexPath, LANGUAGE_SET)) {
//        WDSettingLanguageSelectorController *vc = [WDSettingLanguageSelectorController new];
//        vc.setLanguageBlock = ^{
//            [UIApplication sharedApplication].delegate.window.rootViewController = [WDTabbarController setupViewControllersWithIndex:0];
//        };
//        [self cw_pushViewController:vc];
//    } else if (NSIndexPathEqual(indexPath, NODE_CHANGE)) {
//        [self cw_pushViewController:[[WDNodeSwitchController alloc] initWithTitle:YYStringWithKey(model.title)]];
//    } else if (NSIndexPathEqual(indexPath, GOOGLE_VALIDATION)) {
//        NSString *codeStr = [YYUserDefaluts yy_getValueForKey:@"isBindGoogle"];
//        if ([codeStr isEqualToString:@"0"]) {
//            return;
//        }
//        // 谷歌验证
//        [self cw_pushViewController:[[WDGoogleValidationController alloc] initWithTitle:YYStringWithKey(model.title)]];
//    } else if (NSIndexPathEqual(indexPath, HELP_CENTER)) {
//        // 这里暂时不让点击
//        return;
//        [self.navigationController pushViewController:[[WDHelpCenterController alloc]initWithTitle:YYStringWithKey(model.title)] animated:YES];
//    } else if (NSIndexPathEqual(indexPath, ABOUT_US)) {
//        // 这里暂时不让点击
//        return;
//        [self.navigationController pushViewController:[[WDAboutUSController alloc] initWithTitle:YYStringWithKey(model.title)] animated:YES];
//    }
    
    SettingRowModel *model = self.list[indexPath.row];
    if (NSIndexPathEqual(indexPath, REAL_NAME)) {
        if ([YYUserDefaluts yy_getIsRealName]) {
            [YYToastView showCenterWithTitle:YYStringWithKey(@"已实名") attachedView:[UIApplication sharedApplication].keyWindow];
            return;
        }
        YYRealNameCertificationController *vc = [[YYRealNameCertificationController alloc] init];
        [self cw_pushViewController:vc];
    } else if (NSIndexPathEqual(indexPath, LAN_SET)) {
        WDSettingLanguageSelectorController *vc = [WDSettingLanguageSelectorController new];
        vc.setLanguageBlock = ^{
            [UIApplication sharedApplication].delegate.window.rootViewController = [WDTabbarController setupViewControllersWithIndex:0];
        };
        [self cw_pushViewController:vc];
    } else if (NSIndexPathEqual(indexPath, INVITE_F)) {
        YYInviteFriendsController *vc = [[YYInviteFriendsController alloc] init];
        [self cw_pushViewController:vc];
    } else if (NSIndexPathEqual(indexPath, HELP_C)) {
        return;
        [self.navigationController pushViewController:[[WDHelpCenterController alloc]initWithTitle:YYStringWithKey(model.title)] animated:YES];
    } else if (NSIndexPathEqual(indexPath, MY_CODE)) {
        YYMyQRCodeController *qrCode = [[YYMyQRCodeController alloc] init];
        [self cw_pushViewController:qrCode];
    }
    [self yy_hideTabBar:YES];
}

#pragma mark -RDVItemStyleDelegate

- (UIImage *)rdvItemNormalImage {
    return [UIImage imageNamed:@"message"];
}

- (UIImage *)rdvItemHighLightImage {
    return [UIImage imageNamed:@"message_sel"];
}

- (NSString *)rdvItemTitle {
    return YYStringWithKey(@"信息");
}

#pragma mark - lazy

- (NSMutableArray *)list {
    if (!_list) {
        _list = @[].mutableCopy;
    }
    return _list;
}

- (YYUserInfoViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYUserInfoViewModel alloc] init];
    }
    return _viewModel;
}

@end
