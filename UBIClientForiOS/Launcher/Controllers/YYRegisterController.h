//
//  YYRegisterController.h
//  UBIClientForiOS
//
//  Created by yang on 2020/4/13.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "WDBaseFunctionController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RegisterStatusBlock)(void);

@interface YYRegisterController : WDBaseFunctionController

@property (nonatomic, copy) RegisterStatusBlock registerBlock;

@end

NS_ASSUME_NONNULL_END
