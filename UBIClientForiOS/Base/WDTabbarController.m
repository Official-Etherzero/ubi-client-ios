//
//  WDTabbarController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDTabbarController.h"
#import "RDVTabBarController.h"
#import "WDMineViewController.h"
#import "WDWalletViewController.h"
#import "YYOrderController.h"

@implementation WDTabbarController

+ (UIViewController *)setupViewControllersWithIndex:(NSUInteger)index {
    UIViewController *walletVC = [[WDWalletViewController alloc] init];
    UIViewController *naviWalletVC = [[UINavigationController alloc] initWithRootViewController:walletVC];
    
    YYOrderController *marketVC = [[YYOrderController alloc] init];
    UIViewController *naviMarketVC = [[UINavigationController alloc] initWithRootViewController: marketVC];
    
//    WDMineViewController *mineVC = [[WDMineViewController alloc] init];
//    UIViewController *navMineVC = [[UINavigationController alloc] initWithRootViewController:mineVC];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[naviWalletVC,
                                           naviMarketVC]];
    [tabBarController.tabBar setHeight:49];
    [tabBarController setSelectedIndex:index];
    return tabBarController;
}

@end
