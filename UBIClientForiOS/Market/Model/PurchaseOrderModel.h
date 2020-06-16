//
//  PurchaseOrderModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/4/23.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PurchaseOrderModel : NSObject

@property (nonatomic, assign) NSInteger Count;      // 求购数量
@property (nonatomic,   copy) NSString *OrderID;    // 订单号
@property (nonatomic,   copy) NSString *Price;      // 价格
@property (nonatomic,   copy) NSString *WriteTime;  // 时间

@end

NS_ASSUME_NONNULL_END
