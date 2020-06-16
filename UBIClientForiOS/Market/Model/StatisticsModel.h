//
//  StatisticsModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/4/23.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StatisticsModel : NSObject

@property (nonatomic, assign) NSInteger Count; // 求购单数
@property (nonatomic,   copy) NSString *Price; // 指导价格
@property (nonatomic,   copy) NSString *LastPrice; // 最后成交价格
@property (nonatomic,   copy) NSString *Sum;       // 总额

@end

NS_ASSUME_NONNULL_END
