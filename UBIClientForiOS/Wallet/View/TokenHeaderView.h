//
//  TokenHeaderView.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TokenHeaderView : UICollectionReusableView

@property (nonatomic,  copy) void(^addTokenBlock)(void);

@end

NS_ASSUME_NONNULL_END
