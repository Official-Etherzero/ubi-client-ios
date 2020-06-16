//
//  YYOrderController.m
//  UBIClientForiOS
//
//  Created by yang on 2020/4/23.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYOrderController.h"
#import "YYViewHeader.h"
#import "UIViewController+Ext.h"
#import <BlocksKit/BlocksKit.h>
#import "YYOrderViewModel.h"
#import "StatisticsView.h"
#import "RequirementView.h"
#import "YYUserDefaluts.h"
#import "StatisticsModel.h"
#import "YYInterfaceMacro.h"
#import "YYOrderListController.h"
#import "OrderView.h"
#import "OrderOptionalCell.h"
#import "OrderHeaderView.h"
#import "PurchaseOrderModel.h"
#import "YYTransferView.h"
#import "RequestModel.h"

@interface YYOrderController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) YYLabel          *titleView;
@property (nonatomic, strong) YYOrderViewModel *orderViewModel;
@property (nonatomic, strong) StatisticsView   *statisticsView;
@property (nonatomic, strong) RequirementView  *requirementView;
@property (nonatomic, strong) OrderView        *orderView;
@property (nonatomic, strong) UITableView      *listView;
@property (nonatomic, strong) NSMutableArray<PurchaseOrderModel *> *models;

@end

@implementation YYOrderController


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initData];
    [self yy_hideTabBar:NO];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage yy_imageWithColor:COLOR_151824] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : COLOR_ffffff,
                                                                      NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_151824;
    self.navigationItem.title = YYStringWithKey(@"C2C");
    [self initSubViews];
}

- (void)initSubViews {
    
    self.titleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_32 textColor:COLOR_ffffff text:YYStringWithKey(@"C2C统计")];
    self.titleView.backgroundColor = COLOR_333c62;
    self.titleView.textInsets = UIEdgeInsetsMake(YYSIZE_13, YYSIZE_15, YYSIZE_13, 0);
    [self.view addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_350, YYSIZE_42));
    }];
    
    self.statisticsView = [[StatisticsView alloc] init];
    [self.view addSubview:self.statisticsView];
    [self.statisticsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_350, YYSIZE_60));
    }];
    
    self.requirementView = [[RequirementView alloc] init];
    [self.view addSubview:self.requirementView];
    [self.requirementView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.statisticsView.mas_bottom).offset(YYSIZE_15);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_350, YYSIZE_42));
    }];
    WDWeakify(self);
    self.requirementView.orderBlock = ^{
        WDStrongify(self);
        YYOrderListController *listViewController = [[YYOrderListController alloc] init];
        [self.navigationController pushViewController:listViewController animated:YES];
    };
    
    self.orderView = [[OrderView alloc] init];
    [self.view addSubview:self.orderView];
    [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.requirementView.mas_bottom).offset(YYSIZE_10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_350, YYSIZE_173));
    }];
    self.orderView.buyBlock = ^(float data, float price) {
        WDStrongify(self);
        [self buyUBIWithNum:data price:price];
    };
    
    self.listView = [[UITableView alloc] init];
    self.listView.dataSource = self;
    self.listView.delegate = self;
    self.listView.backgroundColor = COLOR_1a203a;
    [self.view addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderView.mas_bottom).offset(YYSIZE_15);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
        make.left.right.mas_equalTo(self.view);
    }];
    self.listView.rowHeight = YYSIZE_44;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.listView registerClass:[OrderHeaderView class]
forHeaderFooterViewReuseIdentifier:OrderHeaderView.identifier];
    [self.listView registerClass:[OrderOptionalCell class]
          forCellReuseIdentifier:OrderOptionalCell.identifier];
}

- (void)initData {
    WDWeakify(self);
    [self.orderViewModel yy_viewModelGetOrdersInfoWithToken:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[StatisticsModel class]]) {
            WDStrongify(self);
            self.statisticsView.model = responseObject;
        } else {
            [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
        }
    } failure:^(NSError * _Nonnull error) {
        [YYToastView showCenterWithTitle:error.localizedDescription attachedView:[UIApplication sharedApplication].keyWindow];
    }];
    
    [self.orderViewModel yy_viewModelGetListOrdersWithToken:[YYUserDefaluts yy_getAccessTokeCache] page:1 pageSize:160 success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            WDStrongify(self);
            self.models = responseObject;
            [self.listView reloadData];
        } else {
           [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
        }
    } failure:nil];
}

- (void)buyUBIWithNum:(float)num price:(float)price {
    WDWeakify(self);
    [YYTransferView showPasswordViewConfirmBlock:^(NSString * _Nonnull psd) {
        WDStrongify(self);
        [self.orderViewModel yy_viewModelCreateBuyOrderWithToken:[YYUserDefaluts yy_getAccessTokeCache] password:psd count:num price:price success:^(id  _Nonnull responseObject) {
            [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
        } failure:nil];
    } cancelBlock:nil];
}

- (void)sellUBIWithOrderId:(NSString *)orderId {
    WDWeakify(self);
    [self.orderViewModel yy_viewModelLockOrderWithToken:[YYUserDefaluts yy_getAccessTokeCache] orderId:orderId success:^(id  _Nonnull responseObject) {
        RequestModel *model = responseObject;
        WDStrongify(self);
        if (model.code == 0) {
            [YYTransferView showPasswordViewConfirmBlock:^(NSString * _Nonnull psd) {
                // 确认出售
                [self.orderViewModel yy_viewModelConfirmSaleWithToken:[YYUserDefaluts yy_getAccessTokeCache] orderId:orderId password:psd success:^(id  _Nonnull responseObject) {
                    [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
                } failure:nil];
            } cancelBlock:^{
                // 放弃出售
                [self.orderViewModel yy_viewModelGiveUpSaleWithToken:[YYUserDefaluts yy_getAccessTokeCache] orderId:orderId success:^(id  _Nonnull responseObject) {
                    [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
                } failure:nil];
            }];
        } else {
            [YYToastView showCenterWithTitle:model.msg attachedView:[UIApplication sharedApplication].keyWindow];
        }
    } failure:^(NSError * _Nonnull error) {
        [YYToastView showCenterWithTitle:error.localizedDescription attachedView:[UIApplication sharedApplication].keyWindow];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    OrderHeaderView *header = [self.listView dequeueReusableHeaderFooterViewWithIdentifier:OrderHeaderView.identifier];
    return header;
}

#pragma mark -UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderOptionalCell *cell = [self.listView dequeueReusableCellWithIdentifier:OrderOptionalCell.identifier
                                                                   forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    WDWeakify(self);
    cell.sellBlock = ^(NSString * _Nonnull orderId) {
        WDStrongify(self);
        [self sellUBIWithOrderId:orderId];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return OrderHeaderView.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YYSIZE_60;
}

#pragma mark - lazy

- (YYOrderViewModel *)orderViewModel {
    if (!_orderViewModel) {
        _orderViewModel = [[YYOrderViewModel alloc] init];
    }
    return _orderViewModel;
}

- (NSMutableArray<PurchaseOrderModel *> *)models {
    if (!_models) {
        _models = @[].mutableCopy;
    }
    return _models;
}

#pragma mark -RDVItemStyleDelegate

- (UIImage *)rdvItemNormalImage {
    return [UIImage imageNamed:@"Market"];
}

- (UIImage *)rdvItemHighLightImage {
    return [UIImage imageNamed:@"Market_sel"];
}

- (NSString *)rdvItemTitle {
    return YYStringWithKey(@"C2C");
}

@end
