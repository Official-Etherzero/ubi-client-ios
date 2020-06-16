//
//  YYTransferView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/4/14.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TransferConfirmBlock)(NSString *psd);
typedef void(^TransferCancelBlock)(void);

@interface YYTransferView : UIView

+ (instancetype)showPasswordViewConfirmBlock:(TransferConfirmBlock _Nullable)confirmBlock
                                 cancelBlock:(TransferCancelBlock _Nullable)cancelBlock;

@end

NS_ASSUME_NONNULL_END
