//
//  NodeRewardModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/26.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RewardModel : NSObject

@property (nonatomic,   copy) NSString  *WriteTime;
@property (nonatomic, assign) double    Amount;

@end

@class RewardModel;

@interface NodeRewardModel : NSObject

@property (nonatomic,   copy) NSString  *TotalCount;
@property (nonatomic,   copy) NSString  *TotalReward;
@property (nonatomic,   copy) NSString  *TotalRewardYesterday;
@property (nonatomic,   copy) NSArray<RewardModel *> *UserNodeList;

@end

NS_ASSUME_NONNULL_END
