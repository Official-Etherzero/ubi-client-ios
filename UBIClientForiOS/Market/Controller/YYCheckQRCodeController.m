//
//  YYCheckQRCodeController.m
//  UBIClientForiOS
//
//  Created by yang on 2020/4/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYCheckQRCodeController.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "LocalServer.h"
#import "YYOrderViewModel.h"
#import "YYUserDefaluts.h"
#import "SellerModel.h"

@interface YYCheckQRCodeController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) YYButton    *saveView;
@property (nonatomic, strong) YYOrderViewModel  *viewModel;
@property (nonatomic, strong) MyOrderModel      *model;
@property (nonatomic, strong) SellerModel       *sellerModel;

@end

@implementation YYCheckQRCodeController

- (instancetype)initWithOrderModel:(MyOrderModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_151824;
    self.navigationItem.title = YYStringWithKey(@"付款二维码");
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = [UIImage imageNamed:@"al_icon"];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.left.right.mas_equalTo(self.view);
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-YYSIZE_80);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).offset(-YYSIZE_80);
        }
    }];
    
    self.saveView = [[YYButton alloc] initWithFont:FONT_DESIGN_36 borderWidth:0 borderColoer:COLOR_486cff.CGColor masksToBounds:YES title:YYStringWithKey(@"保存至手机相册") titleColor:COLOR_ffffff backgroundColor:COLOR_486cff cornerRadius:YYSIZE_21];
    [self.view addSubview:self.saveView];
    [self.saveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-YYSIZE_20);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).offset(-YYSIZE_20);
        }
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_42));
    }];
    
    WDWeakify(self);
    [self.saveView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        [LocalServer syncExportLocalResourceWitImage:self.imageView.image completeHandler:^(NSError * _Nullable error) {
            if (error) {
                [YYToastView showCenterWithTitle:error.localizedDescription attachedView:[UIApplication sharedApplication].keyWindow];
            } else {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"成功保存图片到相册") attachedView:[UIApplication sharedApplication].keyWindow];
            }
        }];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)initData {
    WDWeakify(self);
    [self.viewModel yy_viewModelSeeSalesQRWithToken:[YYUserDefaluts yy_getAccessTokeCache] orderId:self.model.OrderID success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[SellerModel class]]) {
            WDStrongify(self);
            self.sellerModel = responseObject;
            if (self.sellerModel.pic2) {
                [self.imageView yy_setImageWithURL:[NSURL URLWithString:self.sellerModel.pic2] options:YYWebImageOptionUseNSURLCache];
            } else {
                [self.imageView yy_setImageWithURL:[NSURL URLWithString:self.sellerModel.pic1] options:YYWebImageOptionUseNSURLCache];
            }
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        }
    } failure:nil];
}

#pragma mark - lazy

- (YYOrderViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYOrderViewModel alloc] init];
    }
    return _viewModel;
}

@end
