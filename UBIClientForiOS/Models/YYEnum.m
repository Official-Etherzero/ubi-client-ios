//
//  YYEnum.m
//  ExchangeClientForIOS
//
//  Created by yang on 2019/12/5.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYEnum.h"
#import "YYLanguageTool.h"

@implementation YYEnum

// 矿机类型 1-初级，2-中级，3-高级， 4-顶级，5-特级，6-智能",
NSString *yyGetMiningMachineTypeString(MiningMachineType type) {
    switch (type) {
        case MINING_MACHINE_PRIMARY:
            return YYStringWithKey(@"初级机器人");
            break;
        case MINING_MACHINE_INTERMEDIATE:
            return YYStringWithKey(@"中级机器人");
            break;
        case MINING_MACHINE_ADVANCED:
            return YYStringWithKey(@"高级机器人");
            break;
        case MINING_MACHINE_TOP:
            return YYStringWithKey(@"顶级机器人");
            break;
        case MINING_MACHINE_SUPER:
            return YYStringWithKey(@"特级机器人");
            break;
        case MINING_MACHINE_INTELLIGENT:
            return YYStringWithKey(@"智能机器人");
            break;
            
        default:
            break;
    }
    return @"";
}

NSString *yyGetMiningMachineCardImageString(MiningMachineType type) {
    switch (type) {
        case MINING_MACHINE_PRIMARY:
            return @"primary";
            break;
        case MINING_MACHINE_INTERMEDIATE:
            return @"intermediate";
            break;
        case MINING_MACHINE_ADVANCED:
            return @"multifunctional";
            break;
        case MINING_MACHINE_TOP:
            return @"top";
            break;
        case MINING_MACHINE_SUPER:
            return @"super";
            break;
        case MINING_MACHINE_INTELLIGENT:
            return @"intelligent";
            break;
            
        default:
            break;
    }
    return @"";
}

NSString *yyGetOrderStatusString(OrderStatus status) {
    switch (status) {
        case ORDER_PROCESSING:
            return YYStringWithKey(@"进行中");
            break;
        case ORDER_COMPLETE:
            return YYStringWithKey(@"已完成");
            break;
        case ORDER_CANCEL:
            return YYStringWithKey(@"已取消");
            break;
        default:
            break;
    }
}

NSString *yyGetOrderCurrentStatusString(OrderCurrentStatus status) {
    switch (status) {
        case ORDER_NEW_CREATE:{
            return YYStringWithKey(@"新建的订单");
        }
            break;
        case ORDER_BUIES_CONFIRM:{
            return YYStringWithKey(@"等待买家确认");
        }
            break;
        case ORDER_WAIT_PAYMENT:{
            return YYStringWithKey(@"待付款");
        }
            break;
        case ORDER_CONFIRM_PAYMENT:{
            return YYStringWithKey(@"待确认收款");
        }
            break;
        case ORDER_TRADE_COMPLETE:{
            return YYStringWithKey(@"交易完成");
        }
            break;
        case ORDER_SELLER_UNRECEIVED:{
            return YYStringWithKey(@"卖家未收到钱");
        }
            break;
        default:
            break;
    }
}


NSString *yyGetAccountTypeString(AccountType type) {
    switch (type) {
        case ACCOUNT_TRANSFER:
            return YYStringWithKey(@"交易账户");
            break;
        case ACCOUNT_ROBOT:
            return YYStringWithKey(@"机器人账户");
            break;
        case ACCOUNT_WALLET:
            return YYStringWithKey(@"钱包账户");
            break;
        default:
            break;
    }
}

@end
