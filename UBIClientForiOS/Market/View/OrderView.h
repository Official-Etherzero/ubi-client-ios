//
//  OrderView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/4/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BuyBlock)(float data,float price);

@interface OrderView : UIView

@property (nonatomic,   copy) BuyBlock buyBlock;

@end

NS_ASSUME_NONNULL_END
