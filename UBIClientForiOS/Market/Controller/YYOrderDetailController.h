//
//  YYOrderDetailController.h
//  UBIClientForiOS
//
//  Created by yang on 2020/4/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "WDBaseFunctionController.h"
#import "MyOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYOrderDetailController : WDBaseFunctionController

- (instancetype)initWithMyOrderModel:(MyOrderModel *)model;

@end

NS_ASSUME_NONNULL_END
