//
//  RobotCardView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/2/16.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RobotEarningsModel.h"
#import "CalculateStatisticalModel.h"
#import "YYUserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TapTeamNodeBlock)(void);

@interface RobotCardView : UIView

@property (nonatomic, strong) RobotEarningsModel        *earnModel;
@property (nonatomic, strong) CalculateStatisticalModel *calculatemodel;
@property (nonatomic, strong) YYUserInfoModel           *infoModel;
@property (nonatomic,   copy) TapTeamNodeBlock          tapTeamNodeBlock;

@end

NS_ASSUME_NONNULL_END
