//
//  RunningRobotView.h
//  UBIClientForiOS
//
//  Created by etz on 2019/12/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunningRobotModel.h"
#import "MySelfNodeModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddRobotBlock)(void);
typedef void(^SelectedRobotBlock)(NodeDetailModel *model);

@interface RunningRobotView : UIView

@property (nonatomic, copy) NSArray<NodeDetailModel *> *models;
@property (nonatomic, copy) AddRobotBlock      addRobotBlock;
@property (nonatomic, copy) SelectedRobotBlock selectedRobotBlock;


@end

NS_ASSUME_NONNULL_END
