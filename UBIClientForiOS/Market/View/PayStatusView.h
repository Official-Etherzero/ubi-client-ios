//
//  PayStatusView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/4/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CheckQRCodeBlock)(void);
typedef void(^ConfirmPayBlock)(NSInteger type);
typedef void(^ConfrimCollectionBlock)(NSInteger status);
@interface PayStatusView : UIView

@property (nonatomic, strong) MyOrderModel      *model;
@property (nonatomic,   copy) CheckQRCodeBlock  checkBlock;
@property (nonatomic,   copy) ConfirmPayBlock   payBlock;
@property (nonatomic,   copy) ConfrimCollectionBlock collectionBlock;


@end

NS_ASSUME_NONNULL_END
