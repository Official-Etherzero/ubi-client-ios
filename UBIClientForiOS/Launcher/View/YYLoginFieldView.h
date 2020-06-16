//
//  YYLoginFieldView.h
//  UBIClientForiOS
//
//  Created by etz on 2020/5/19.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYLoginFieldView : UIView

@property (nonatomic,   copy) NSString *content;
@property (nonatomic, strong) UITextField *textField;

- (instancetype)initWithAttackView:(UIView *)attackView
                            plcStr:(NSString *)plcStr
                        leftMargin:(float)margin;

- (void)setSecureTextEntry:(BOOL)isSecurity;

- (void)updateSecureTextEntry:(BOOL)isSecurity;

@end

NS_ASSUME_NONNULL_END
