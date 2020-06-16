//
//  MySelfNodeModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NodeDetailModel : NSObject

@property (nonatomic,   copy) NSString  *ExpireTime;
@property (nonatomic,   copy) NSString  *StartTime;
@property (nonatomic,   copy) NSString  *RewardYesterday;
@property (nonatomic,   copy) NSString  *Reward;
@property (nonatomic,   copy) NSString  *UserID;
@property (nonatomic,   copy) NSString  *OAmount;
@property (nonatomic, assign) NSInteger NodeID;
@property (nonatomic, assign) NSInteger MiniID;
@property (nonatomic, assign) NSInteger RestOfDay;


@property (nonatomic,   copy) NSString  *Phone;
@property (nonatomic,   copy) NSString  *Email;
@property (nonatomic,   copy) NSString  *CompleteTime;
@property (nonatomic,   copy) NSString  *ExpireStatus;
@property (nonatomic, assign) NSInteger isFree;
@property (nonatomic,   copy) NSString  *SuanLi;
@property (nonatomic,   copy) NSString  *Name;
@property (nonatomic,   copy) NSString  *RateOfProgress;

@end

@class NodeDetailModel;
@interface MySelfNodeModel : NSObject

@property (nonatomic, assign) NSInteger TotalCount;
@property (nonatomic,   copy) NSString  *TotalReward;
@property (nonatomic,   copy) NSString  *TotalRewardYesterday;
@property (nonatomic,   copy) NSString  *MySuanLi;
@property (nonatomic,   copy) NSString  *TeamSuanLi;
@property (nonatomic,   copy) NSArray<NodeDetailModel *> *UserNodeList;

@end

NS_ASSUME_NONNULL_END
