//
//  YYWalletTopView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/2/16.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SetBlock)(void);
typedef void(^ScanBlock)(void);

@interface YYWalletTopView : UIView
@property (nonatomic,   copy) SetBlock     setBlock;
@property (nonatomic,   copy) ScanBlock    scanBlock;

@property (nonatomic,   copy) NSString     *title;

@end

NS_ASSUME_NONNULL_END
