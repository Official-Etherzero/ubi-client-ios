//
//  MyOrderListView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/4/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DidSelectedBlock)(MyOrderModel *model);

@interface MyOrderListView : UIView

@property (nonatomic,  copy) NSArray<MyOrderModel *> *models;
@property (nonatomic,  copy) DidSelectedBlock selectedBlock;

@end

NS_ASSUME_NONNULL_END
