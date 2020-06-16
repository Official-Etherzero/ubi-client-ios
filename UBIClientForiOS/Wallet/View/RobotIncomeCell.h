//
//  RobotIncomeCell.h
//  UBIClientForiOS
//
//  Created by etz on 2020/1/2.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RobotBenefitsModel.h"
#import "NodeRewardModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RobotIncomeCell : UITableViewCell

@property (nonatomic, strong) RewardModel *model;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
