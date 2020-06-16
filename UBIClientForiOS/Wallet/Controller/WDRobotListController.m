//
//  WDRobotListController.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDRobotListController.h"
#import "YYMillViewModel.h"
#import "RobotTopView.h"
#import "YYViewHeader.h"
#import "YYNavigationView.h"
#import "RobotBottomView.h"
#import "MiningInfosModel.h"
#import "RobotsListCell.h"
#import "YYInterfaceMacro.h"
#import "YYToastView.h"
#import "YYUserDefaluts.h"
#import "WalletDataManager.h"
#import "SettingPasswordView.h"
#import "OrderPasswordView.h"
#import "YYUserInfoViewModel.h"
#import "UserInfoModel.h"
#import "WalletDataManager.h"
#import "YYRegisterLoginView.h"
#import "WDWalletUserInfo.h"
#import "RechargeView.h"
#import "YYSellViewModel.h"
#import "OtcDetailModel.h"
#import "YYInterfaceMacro.h"
#import "YYNodeViewModel.h"
#import "NodeModel.h"
#import "NodeOrderDetailView.h"
#import "RequestModel.h"

@interface WDRobotListController ()
<YYNavigationViewDelegate,
UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView               *tableView;
@property (nonatomic, strong) RobotTopView              *topView;
@property (nonatomic, strong) YYNavigationView          *navigationView;
@property (nonatomic, strong) YYUserInfoViewModel       *userInfoViewModel;
@property (nonatomic, strong) YYUserInfoModel           *infoModel;
@property (nonatomic, strong) RobotBottomView           *bottomView;
@property (nonatomic, strong) YYRegisterLoginView       *registerLoginView;
@property (nonatomic,   copy) NSArray<NodeModel *>      *models;
@property (nonatomic, strong) YYSellViewModel           *sellViewModel;
@property (nonatomic, strong) YYNodeViewModel           *nodeViewModel;
@end

@implementation WDRobotListController

- (instancetype)initWithInfoModel:(YYUserInfoModel *)infoModel
                                {
    if (self = [super init]) {
        self.infoModel = infoModel;
    }
    return self;
}

- (instancetype)initFreeRobotViewController {
    if (self = [super init]) {
        WDWeakify(self);
        // 获取免费的节点
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_151824;
    self.navigationItem.title = YYStringWithKey(@"机器人");
    [self initViewModel];
    [self initSubViews];
}

- (void)initSubViews {
    
    self.navigationView = [[YYNavigationView alloc] initWithNavigationItem:self.navigationItem];
    [self.navigationView returnButton];
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
        make.height.mas_offset(YYSIZE_220);
    }];
    self.topView.model = self.infoModel;
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = COLOR_151824;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = YYSIZE_120;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).offset(-YYSIZE_120);
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[RobotsListCell class]
           forCellReuseIdentifier:[RobotsListCell identifier]];
}

- (void)initViewModel {
    // 节点列表
    WDWeakify(self);
    [self.nodeViewModel yy_viewModelGetNodeListSuccess:^(id  _Nonnull responseObject) {
        WDStrongify(self);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            self.models = responseObject;
            [self.tableView reloadData];
        } else {
            [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
        }
    } failure:^(NSError * _Nonnull error) {
        [YYToastView showCenterWithTitle:error.localizedDescription attachedView:[UIApplication sharedApplication].keyWindow];
    }];
}

- (void)buyNodeWithNodeModel:(NodeModel *)model {
    WDWeakify(self);
       [NodeOrderDetailView showOrderDetailViewWithModel:model confirmBlock:^(NSString * _Nonnull psd) {
           WDStrongify(self);
           [self.nodeViewModel yy_viewModelBuyNodeWithToken:[YYUserDefaluts yy_getAccessTokeCache] nodeId:model.MiniID password:psd success:^(id  _Nonnull responseObject) {
               if ([responseObject isKindOfClass:[RequestModel class]]) {
                   RequestModel *model = responseObject;
                   if (model.code == 0) {
                       [YYToastView showCenterWithTitle:YYStringWithKey(@"购买成功") attachedView:[UIApplication sharedApplication].keyWindow];
                       [self.navigationController popViewControllerAnimated:YES];
                   } else {
                       [YYToastView showCenterWithTitle:model.msg attachedView:[UIApplication sharedApplication].keyWindow];
                   }
               }
           } failure:^(NSError * _Nonnull error) {
               [YYToastView showCenterWithTitle:error.localizedDescription attachedView:[UIApplication sharedApplication].keyWindow];
           }];
       } cancelBlock:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RobotsListCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[RobotsListCell identifier] forIndexPath:indexPath];
    cell.nodeModel = self.models[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NodeModel *model = self.models[indexPath.row];
    [self buyNodeWithNodeModel:model];
}

- (void)showRechargeViewWithOtcDetail:(OtcDetailModel *)model {
    WDWeakify(self);
    [RechargeView showRechargeViewWithUsdtAddress:model.USDTSysAddr confirmBlock:^(NSString * _Nonnull address) {
        WDStrongify(self);
        [self copyWithAddress:address];
    } cancelBlock:nil];
}

- (void)copyWithAddress:(NSString *)address {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = address;
    [YYToastView showCenterWithTitle:YYStringWithKey(@"复制成功") attachedView:[UIApplication sharedApplication].keyWindow show:^{
    }];
}

#pragma mark - YYNavigationViewDelegate

- (void)yyNavigationViewReturnClick:(YYNavigationView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -

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

- (YYSellViewModel *)sellViewModel {
    if (!_sellViewModel) {
        _sellViewModel = [[YYSellViewModel alloc] init];
    }
    return _sellViewModel;
}

@end
