//
//  WDRobotListController.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDBaseFunctionController.h"
#import "CalculateStatisticalModel.h"
#import "YYUserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDRobotListController : WDBaseFunctionController

- (instancetype)initWithInfoModel:(YYUserInfoModel *)infoModel;

- (instancetype)initFreeRobotViewController;

@end

NS_ASSUME_NONNULL_END
