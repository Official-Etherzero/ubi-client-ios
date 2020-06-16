//
//  WDBaseFunctionController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/24.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDBaseFunctionController.h"
#import "YYNavigationView.h"
#import "UIViewController+Ext.h"
#import "YYViewHeader.h"

@interface WDBaseFunctionController ()
<YYNavigationViewDelegate>

@property (nonatomic, strong) YYNavigationView *top_View;

@end

@implementation WDBaseFunctionController

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.navigationItem.title = YYStringWithKey(title);
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage yy_imageWithColor:COLOR_151824] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : COLOR_ffffff,
                                                                      NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
    [self yy_hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self yy_hideTabBar:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_151824;
    self.top_View = [[YYNavigationView alloc] initWithNavigationItem:self.navigationItem];
    self.top_View.delegate = self;
    [self.top_View returnButton];
}

#pragma mark - YYNavigationViewDelegate

- (void)yyNavigationViewReturnClick:(YYNavigationView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
