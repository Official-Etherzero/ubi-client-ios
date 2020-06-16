//
//  YYValidationCodeView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/2/27.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CodeDidChangeBlock)(NSString *codeString);

@interface YYValidationCodeView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                   labelCount:(NSInteger)labelCount
                labelDistance:(CGFloat)labelDistance;

@property (nonatomic,   copy) CodeDidChangeBlock  codeBlock;
/// 默认颜色 不设置的话是黑色
@property (nonatomic, strong) UIColor *defaultColor;
/// 改变后的颜色 不设置的话是红色
@property (nonatomic, strong) UIColor *changedColor;

@end

@interface WDTextField : UITextField

@end

NS_ASSUME_NONNULL_END
