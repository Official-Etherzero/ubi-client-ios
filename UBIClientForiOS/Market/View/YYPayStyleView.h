//
//  YYPayStyleView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/4/27.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectedBlock)(NSInteger tap);

@interface YYPayStyleView : UIView

- (instancetype)initViewContent:(NSString *)content
                   confirmTitle:(NSString *)confirmTitle
                 unConfirmTitle:(NSString *)unConfirmTitle;

@property (nonatomic,   copy) SelectedBlock  selectedBlock;

@end

NS_ASSUME_NONNULL_END
