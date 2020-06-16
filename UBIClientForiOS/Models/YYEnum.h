//
//  YYEnum.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/5.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, OrderStatus) {
    ORDER_PROCESSING  = 1,
    ORDER_COMPLETE    = 2,
    ORDER_CANCEL      = 3,
};

typedef NS_ENUM(NSUInteger, OrderCurrentStatus) {
    ORDER_NEW_CREATE          = 0,
    ORDER_BUIES_CONFIRM       = 1,
    ORDER_WAIT_PAYMENT        = 2,
    ORDER_CONFIRM_PAYMENT     = 3,
    ORDER_TRADE_COMPLETE      = 4,
    ORDER_SELLER_UNRECEIVED   = 5,
};

typedef NS_ENUM(NSUInteger, AccountType) {
    ACCOUNT_TRANSFER   = 0,
    ACCOUNT_ROBOT      = 1,
    ACCOUNT_WALLET     = 2,
};

typedef NS_ENUM(NSUInteger, TransferType) {
    TRANSFER_TRA_WALLET    = 0,
    TRANSFER_TRA_ROBOT     = 1,
    TRANSFER_ROB_TRANSFER  = 2,
    TRANSFER_WAL_ROBOT     = 3,
};

typedef NS_ENUM(NSUInteger, MiningMachineType) {
    MINING_MACHINE_PRIMARY      = 1,
    MINING_MACHINE_INTERMEDIATE = 2,
    MINING_MACHINE_ADVANCED     = 3,
    MINING_MACHINE_TOP,
    MINING_MACHINE_SUPER,
    MINING_MACHINE_INTELLIGENT,
};

NSString *yyGetMiningMachineTypeString(MiningMachineType type);
NSString *yyGetMiningMachineCardImageString(MiningMachineType type);
NSString *yyGetOrderStatusString(OrderStatus status);
NSString *yyGetAccountTypeString(AccountType type);
NSString *yyGetOrderCurrentStatusString(OrderCurrentStatus status);

@interface YYEnum : NSObject
@end

NS_ASSUME_NONNULL_END
