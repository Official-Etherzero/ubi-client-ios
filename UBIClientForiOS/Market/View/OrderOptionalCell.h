//
//  OrderOptionalCell.h
//  UBIClientForiOS
//
//  Created by yang on 2020/4/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SellBlock)(NSString *orderId);

@interface OrderOptionalCell : UITableViewCell

@property (nonatomic,   copy) SellBlock sellBlock;
@property (nonatomic, strong) PurchaseOrderModel *model;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
