//
//  MyOrderDetailCell.h
//  UBIClientForiOS
//
//  Created by yang on 2020/4/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderDetailCell : UITableViewCell

@property (nonatomic, strong) MyOrderModel *model;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
