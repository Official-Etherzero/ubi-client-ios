//
//  RobotEarningsModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/2/16.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RobotEarningsModel : NSObject

@property (nonatomic, assign) double Cumulative;
@property (nonatomic, assign) double Last;

@end

NS_ASSUME_NONNULL_END
