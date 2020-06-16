//
//  YYOrderDetailController.m
//  UBIClientForiOS
//
//  Created by yang on 2020/4/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYOrderDetailController.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "YYUserDefaluts.h"
#import "YYOrderViewModel.h"
#import "YYCheckQRCodeController.h"
#import "PayStatusView.h"
#import "YYTransferView.h"

@interface YYOrderDetailController ()

@property (nonatomic, strong) YYOrderViewModel *viewModel;
@property (nonatomic, strong) MyOrderModel     *model;
@property (nonatomic, strong) PayStatusView    *statusView;

@end

@implementation YYOrderDetailController

- (instancetype)initWithMyOrderModel:(MyOrderModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_151824;
    self.navigationItem.title = YYStringWithKey(@"订单详情");
    [self initSubViews];
}

- (void)initSubViews {
    self.statusView = [[PayStatusView alloc] init];
    [self.view addSubview:self.statusView];
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_20);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_20);
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
        make.left.right.mas_equalTo(self.view);
    }];
    WDWeakify(self);
    self.statusView.collectionBlock = ^(NSInteger status) {
       // 确认收款
        WDStrongify(self);
        [YYTransferView showPasswordViewConfirmBlock:^(NSString * _Nonnull psd) {
            [self.viewModel yy_viewModelSalesLastConfirmWithToken:[YYUserDefaluts yy_getAccessTokeCache] orderId:self.model.OrderID status:status password:psd success:^(id  _Nonnull responseObject) {
                [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
            } failure:nil];
        } cancelBlock:nil];
    };
    
    self.statusView.payBlock = ^(NSInteger type) {
        // 确认付款
        WDStrongify(self);
        [self.viewModel yy_viewModelCompleteNoticeWithToken:[YYUserDefaluts yy_getAccessTokeCache] orderId:self.model.OrderID payType:type success:^(id  _Nonnull responseObject) {
            [YYToastView showCenterWithTitle:responseObject attachedView:[UIApplication sharedApplication].keyWindow];
        } failure:nil];
    };
    
    self.statusView.checkBlock = ^{
        // 传二维码地址
        WDStrongify(self);
        YYCheckQRCodeController *vc = [[YYCheckQRCodeController alloc] initWithOrderModel:self.model];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    self.statusView.model = self.model;
}

#pragma mark - lazy

- (YYOrderViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYOrderViewModel alloc] init];
    }
    return _viewModel;
}


@end
