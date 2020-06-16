//
//  YYOrderListController.m
//  UBIClientForiOS
//
//  Created by yang on 2020/4/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYOrderListController.h"
#import "YYViewHeader.h"
#import "YYOrderViewModel.h"
#import "YYInterfaceMacro.h"
#import "YYViewHeader.h"
#import "YYUserDefaluts.h"
#import "MyOrderModel.h"
#import "YYPageView.h"
#import "MyOrderListView.h"
#import "YYOrderDetailController.h"

@interface YYOrderListController ()
<YYPageViewDelegate,
UIScrollViewDelegate>

@property (nonatomic, strong) YYOrderViewModel  *viewModel;
@property (nonatomic, strong) YYPageView  *pageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic,   copy) NSArray *models;
@property (nonatomic,   copy) NSArray *titles;

@property (nonatomic, strong) MyOrderListView *taskView;
@property (nonatomic, strong) MyOrderListView *completeView;
@property (nonatomic, strong) MyOrderListView *cancelView;

@end

@implementation YYOrderListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_151824;
    self.navigationItem.title = YYStringWithKey(@"订单记录");
    [self initSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initData];
}

- (void)initSubViews {
    self.titles = @[@"进行中",@"已完成",@"已取消"];
    self.pageView = [[YYPageView alloc] initWithFrame:CGRectMake(0, 0, YYSCREEN_WIDTH, YYSIZE_50) titles:self.titles];
    [self.view addSubview:self.pageView];
    self.pageView.delegate = self;
    
    UIView *line = [UIView new];
    line.backgroundColor = COLOR_212538;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pageView.mas_bottom);
        make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH, 0.5));
    }];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.contentSize = CGSizeMake(YYSCREEN_WIDTH *self.models.count,0);
    self.scrollView.bounces = YES;
    self.scrollView.delegate = self;
    self.scrollView.canCancelContentTouches = YES;
    self.scrollView.delaysContentTouches = NO;
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(line.mas_bottom);
        if (iOS11) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    if (@available(iOS 11.0, *)) {
        if ([self.scrollView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    self.taskView = [[MyOrderListView alloc] init];
    [self.scrollView addSubview:self.taskView];
    self.taskView.frame = CGRectMake(0, 0, YYSCREEN_WIDTH, YYSIZE_553);
    WDWeakify(self);
    self.taskView.selectedBlock = ^(MyOrderModel * _Nonnull model) {
        WDStrongify(self);
        [self enterDetailViewControllerWithModel:model];
    };
    
    self.completeView = [[MyOrderListView alloc] init];
    [self.scrollView addSubview:self.completeView];
    self.completeView.frame = CGRectMake(YYSCREEN_WIDTH, 0, YYSCREEN_WIDTH, YYSIZE_553);
    self.completeView.selectedBlock = ^(MyOrderModel * _Nonnull model) {
        WDStrongify(self);
        [self enterDetailViewControllerWithModel:model];
    };
    
    self.cancelView = [[MyOrderListView alloc] init];
    self.cancelView.frame = CGRectMake(YYSCREEN_WIDTH * 2, 0, YYSCREEN_WIDTH, YYSIZE_553);
    [self.scrollView addSubview:self.cancelView];
    self.cancelView.selectedBlock = ^(MyOrderModel * _Nonnull model) {
        WDStrongify(self);
        [self enterDetailViewControllerWithModel:model];
    };
    self.scrollView.contentSize = CGSizeMake(YYSCREEN_WIDTH *3, 0);
}

- (void)enterDetailViewControllerWithModel:(MyOrderModel *)model {
    YYOrderDetailController *vc = [[YYOrderDetailController alloc] initWithMyOrderModel:model];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initData {
    
    // 列出与我相关的订单 1、进行中 2、已完成 3、已取消
    WDWeakify(self);
    [self.viewModel yy_viewModelGetMyOrdersWithToken:[YYUserDefaluts yy_getAccessTokeCache] type:1 page:1 pageSize:160 success:^(id  _Nonnull responseObject) {
        // 进行中
        if ([responseObject isKindOfClass:[NSArray class]]) {
            WDStrongify(self);
            self.taskView.models = responseObject;
        }
    } failure:nil];
    
    [self.viewModel yy_viewModelGetMyOrdersWithToken:[YYUserDefaluts yy_getAccessTokeCache] type:2 page:1 pageSize:160 success:^(id  _Nonnull responseObject) {
        // 已完成
        if ([responseObject isKindOfClass:[NSArray class]]) {
            WDStrongify(self);
            self.completeView.models = responseObject;
        }
        
    } failure:nil];
    
    [self.viewModel yy_viewModelGetMyOrdersWithToken:[YYUserDefaluts yy_getAccessTokeCache] type:3 page:1 pageSize:160 success:^(id  _Nonnull responseObject) {
        // 已取消
        if ([responseObject isKindOfClass:[NSArray class]]) {
            WDStrongify(self);
            self.cancelView.models = responseObject;
        }
    } failure:nil];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"Decelerating : %f",scrollView.contentOffset.x);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ((int)scrollView.contentOffset.x > (YYSCREEN_WIDTH *self.pageView.index)
        && self.pageView.index < self.titles.count -1) {
        self.pageView.index ++;
        [self selectImportViewIndex:self.pageView.index animate:YES];
        [scrollView scrollsToTop];
    } else if ((int)scrollView.contentOffset.x < (YYSCREEN_WIDTH *self.pageView.index)
               && self.pageView.index > 0) {
        self.pageView.index --;
        [self selectImportViewIndex:self.pageView.index animate:YES];
    }
}

- (void)selectImportViewIndex:(NSUInteger)index animate:(BOOL)isAnimate {
    [self.scrollView setContentOffset:CGPointMake(YYSCREEN_WIDTH *index, 0) animated:YES];
}

#pragma mark - YYPageViewDelegate

- (void)pageViewDidChangeIndex:(YYPageView *)pageView {
    [self.scrollView setContentOffset:CGPointMake(YYSCREEN_WIDTH *pageView.index, 0) animated:YES];
}

#pragma mark - lazy

- (YYOrderViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYOrderViewModel alloc] init];
    }
    return _viewModel;
}

@end
