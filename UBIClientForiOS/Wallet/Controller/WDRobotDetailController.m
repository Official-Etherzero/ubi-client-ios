//
//  WDRobotDetailController.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/29.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDRobotDetailController.h"
#import "RobotBottomView.h"
#import "YYMillViewModel.h"
#import "RobotDetailTopView.h"
#import "YYViewHeader.h"
#import "RobotIncomeCell.h"
#import "WalletDataManager.h"
#import "RobotBenefitsModel.h"
#import "YYToastView.h"
#import "YYInterfaceMacro.h"
#import "YYNodeViewModel.h"
#import "YYUserDefaluts.h"
#import "NodeRewardModel.h"

@interface WDRobotDetailController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) NodeDetailModel    *model;
@property (nonatomic, strong) YYMillViewModel    *viewModel;
@property (nonatomic, strong) RobotDetailTopView *topView;
@property (nonatomic, strong) RobotBottomView    *bottomView;
@property (nonatomic, strong) UITableView        *tableView;
@property (nonatomic, strong) AccountModel       *accountModel;
@property (nonatomic, strong) RobotBenefitsModel *benefitsModel;
@property (nonatomic, strong) NSArray<MinerIncomeModel *> *models;
@property (nonatomic, strong) YYNodeViewModel    *nodeViewModel;
@property (nonatomic, strong) NodeRewardModel    *rewardModel;

@end

@implementation WDRobotDetailController

- (instancetype)initRobotDetailWithModel:(NodeDetailModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_151824;
    self.navigationItem.title = YYStringWithKey(@"机器人");
    self.accountModel = [WalletDataManager accountModel];
    [self initSubViews];
    [self initViewModel];
}

- (void)initSubViews {
    self.topView = [[RobotDetailTopView alloc] init];
    self.topView.model = self.model;
    self.topView.layer.cornerRadius = 5.0f;
    self.topView.clipsToBounds = YES;
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_10);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_10);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(YYSIZE_331, YYSIZE_160));
    }];
    
    self.bottomView = [[RobotBottomView alloc] initWithTitle:YYStringWithKey(@"收益记录")];
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
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = COLOR_151824;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = YYSIZE_40;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomView.mas_top).offset(YYSIZE_52);
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[RobotIncomeCell class]
           forCellReuseIdentifier:[RobotIncomeCell identifier]];
}

- (void)initViewModel {
    WDWeakify(self);
    [self.nodeViewModel yy_viewModelGetNodeRewardListWithPageSize:1 currentPage:500 nodeId:self.model.NodeID token:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NodeRewardModel class]]) {
            WDStrongify(self);
            self.rewardModel = responseObject;
            self.topView.income = self.rewardModel.TotalReward;
            [self.tableView reloadData];
        }
    } failure:^(NSError * _Nonnull error) {
        [YYToastView showCenterWithTitle:error.localizedDescription attachedView:[UIApplication sharedApplication].keyWindow];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rewardModel.UserNodeList.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RobotIncomeCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[RobotIncomeCell identifier] forIndexPath:indexPath];
    cell.model = self.rewardModel.UserNodeList[indexPath.row];
    return cell;
}

#pragma mark - lazy

- (YYNodeViewModel *)nodeViewModel {
    if (!_nodeViewModel) {
        _nodeViewModel = [[YYNodeViewModel alloc] init];
    }
    return _nodeViewModel;
}

@end
