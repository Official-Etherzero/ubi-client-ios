//
//  YYUBIiCarouselView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/2/17.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlanceModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^UBIFunctionBlock)(NSInteger index);

@interface YYUBIiCarouselView : UIView

@property (nonatomic,   copy) UBIFunctionBlock block;
@property (nonatomic,   copy) NSString *balance;
@property (nonatomic,   copy) NSString *usdtPrice;
@property (nonatomic, strong) BlanceModel *model;

@end

NS_ASSUME_NONNULL_END
