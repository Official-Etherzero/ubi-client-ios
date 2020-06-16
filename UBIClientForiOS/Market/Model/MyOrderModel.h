//
//  MyOrderModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/4/23.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderModel : NSObject

/**
 *  Status
 *  0、新建的订单
 *  1、锁定（等待买家确认）
 *  2、锁定（买家确认，等待付款）
 *  3、锁定（买家已经转钱，等待卖家确认）
 *  4、表示交易完成
 *  5、交易未成功（未收到钱）
 */

@property (nonatomic, assign) NSInteger Count;       // 求购数量
@property (nonatomic, assign) NSInteger Status;      // 如上
@property (nonatomic, assign) NSInteger Direction;   // 1、买家  2、卖家
@property (nonatomic, assign) NSInteger PayType;     // 1、微信  2、支付宝
@property (nonatomic,   copy) NSString  *OrderID;    // 订单号
@property (nonatomic,   copy) NSString  *Price;      // 价格
@property (nonatomic,   copy) NSString  *WriteTime;  // 时间
@property (nonatomic,   copy) NSString  *LockTime;   // 锁仓时间

@property (nonatomic,   copy) NSString  *Countdown;
@property (nonatomic,   copy) NSString  *CustomID;
@property (nonatomic,   copy) NSString  *Phone;
@property (nonatomic,   copy) NSString  *UserID;
@property (nonatomic,   copy) NSString  *UBI;
@property (nonatomic,   copy) NSString  *USDTAddr;



@end

NS_ASSUME_NONNULL_END
