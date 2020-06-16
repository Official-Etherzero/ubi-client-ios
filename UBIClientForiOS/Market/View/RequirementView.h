//
//  RequirementView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/4/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^OrderRecordBlock)(void);

@interface RequirementView : UIView

@property (nonatomic,   copy) OrderRecordBlock  orderBlock;

@end

NS_ASSUME_NONNULL_END
