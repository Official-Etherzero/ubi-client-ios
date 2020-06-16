//
//  YYUBICardView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/2/17.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FunctionBlock)(NSInteger index);

@interface YYUBICardView : UIView

@property (nonatomic,   copy) FunctionBlock functionBlock;
@property (nonatomic,   copy) NSString      *balance;
@property (nonatomic,   copy) NSString      *usdtPrice;

@end

NS_ASSUME_NONNULL_END
