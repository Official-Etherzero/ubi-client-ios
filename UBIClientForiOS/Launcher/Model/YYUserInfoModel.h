//
//  YYUserInfoModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/3/21.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYUserInfoModel : NSObject

@property (nonatomic,   copy) NSString  *Access_Token;
@property (nonatomic,   copy) NSString  *ETZ;
@property (nonatomic,   copy) NSString  *RechargeAddr;
@property (nonatomic,   copy) NSString  *UserID;
@property (nonatomic,   copy) NSString  *WalletAddr;

@property (nonatomic,   copy) NSString  *InviteCode;
@property (nonatomic, assign) NSInteger IsTrueName;  // 是否实名 0 未实名， 1 实名

@property (nonatomic,   copy) NSString  *Email;
@property (nonatomic,   copy) NSString  *Phone;


@property (nonatomic,   copy) NSString  *AllNodeCount;
@property (nonatomic,   copy) NSString  *AllSuanLi;
@property (nonatomic,   copy) NSString  *MyReward;
@property (nonatomic,   copy) NSString  *MyRewardYes;
@property (nonatomic,   copy) NSString  *MySuanLi;
@property (nonatomic,   copy) NSString  *TeamSuanLi;

@property (nonatomic,   copy) NSString  *Pic1;  // 微信
@property (nonatomic,   copy) NSString  *Pic2;  // 支付宝
@property (nonatomic, assign) NSInteger HavaFreeNode; // 1、表示已经领过免费节点

@end

NS_ASSUME_NONNULL_END
