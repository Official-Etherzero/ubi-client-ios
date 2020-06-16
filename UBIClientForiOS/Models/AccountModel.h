//
//  AccountModel.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

/** SEEK*/
@class WDWalletUserInfo;

NS_ASSUME_NONNULL_BEGIN

@interface AccountModel : NSObject

@property (nonatomic,  copy) NSString *address;
@property (nonatomic,  copy) NSString *keyStore;
@property (nonatomic,  copy) NSString *mnemonicPhrase;
@property (nonatomic,  copy) NSString *privateKey;
@property (nonatomic,  copy) NSString *password;
@property (nonatomic,  copy) NSString *userName;
@property (nonatomic,  copy) NSString *decimal;
@property (nonatomic,strong) NSDate   *date;

@property (nonatomic,  copy) NSString *balance;   // 新增余额，但是不添加到数据库
@property (nonatomic,  copy) NSString *level;     // 矿工等级

// UBI 增加字段
/**
 "UserID": "integer,用户ID",
 "UBIAddr": "string,系统地址",
 "UBIIN": "double,场内余额，刚注册默认为0",
 "UBIOUT": "double,场外余额，刚注册默认为0"
 */

@property (nonatomic,  copy) NSString *userId;
@property (nonatomic,  copy) NSString *ubiAddress; //(相当于用户 币币账户 于钱包地址区分开来)

- (instancetype)initWithWalletUserInfo:(WDWalletUserInfo *)info;

@end

NS_ASSUME_NONNULL_END
