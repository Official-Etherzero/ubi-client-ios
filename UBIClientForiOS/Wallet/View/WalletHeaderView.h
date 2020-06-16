//
//  WalletHeaderView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClickWalletBlock)(void);

@interface WalletHeaderView : UIView

@property (nonatomic, strong) AccountModel     *model;
@property (nonatomic,   copy) ClickWalletBlock walletBlock;

@end

NS_ASSUME_NONNULL_END
