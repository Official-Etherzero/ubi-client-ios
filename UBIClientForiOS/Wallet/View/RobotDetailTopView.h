//
//  RobotDetailTopView.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/29.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunningRobotModel.h"
#import "MySelfNodeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RobotDetailTopView : UIView

@property (nonatomic, strong) NodeDetailModel *model;
@property (nonatomic,   copy) NSString  *income;

@end

NS_ASSUME_NONNULL_END
