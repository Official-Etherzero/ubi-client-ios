//
//  YYTransferView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/4/14.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYTransferView.h"
#import "YYViewHeader.h"
#import "YYSecureView.h"
#import "EVOMd5Generate.h"
#import "NSString+Ext.h"
#import "YYToastView.h"
#import "YYInterfaceMacro.h"
#import <BlocksKit/BlocksKit.h>

@interface YYTransferView ()

@property (nonatomic,   copy) TransferConfirmBlock confirmBlock;
@property (nonatomic,   copy) TransferCancelBlock  cancelBlock;
@property (nonatomic, strong) UITextField  *textField;
@property (nonatomic,   copy) NSString     *textContent;



@end

@implementation YYTransferView

+ (instancetype)showPasswordViewConfirmBlock:(TransferConfirmBlock)confirmBlock cancelBlock:(TransferCancelBlock)cancelBlock {
    YYTransferView *view = [[YYTransferView alloc] init];
    view.confirmBlock = confirmBlock;
    view.cancelBlock = cancelBlock;
    return view;
}

- (instancetype)init {
    if (self = [super init]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
        }];
        self.backgroundColor = COLOR_000000_A05;
        
        UIView *bottomView = [[UIView alloc] init];
        [self addSubview:bottomView];
        bottomView.layer.cornerRadius = 10.0f;
        bottomView.clipsToBounds = YES;
        bottomView.backgroundColor = COLOR_1b213b;
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY).offset(-YYSIZE_20);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_275, YYSIZE_150));
        }];
        
        // password
        self.textField = [[UITextField alloc] init];
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
        self.textField.font = FONT_DESIGN_28;
        self.textField.textColor = COLOR_7d87a0;
        self.textField.backgroundColor = COLOR_272d48;
        self.textField.layer.borderWidth = 1;
        self.textField.layer.borderColor = COLOR_272d48.CGColor;
        self.textField.layer.cornerRadius = 5.0f;
        self.textField.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString *plc = [[NSMutableAttributedString alloc] initWithString:YYStringWithKey(@"请输入交易密码") attributes:@{NSFontAttributeName: FONT_DESIGN_28,NSForegroundColorAttributeName: COLOR_7d87a0}];
        self.textField.attributedPlaceholder = plc;
        self.textField.secureTextEntry = YES;
        [self.textField addTarget:self action:@selector(textField:) forControlEvents:UIControlEventEditingChanged];
        [bottomView addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_30);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(YYSIZE_220, YYSIZE_40));
        }];
        
        
        YYButton *cancelView = [[YYButton alloc] initWithFont:FONT_DESIGN_26 borderWidth:0.5f borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"取消") titleColor:COLOR_3d5afe backgroundColor:COLOR_ffffff cornerRadius:2.0f];
            [bottomView addSubview:cancelView];
            [cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.textField.mas_left);
                make.top.mas_equalTo(self.textField.mas_bottom).offset(YYSIZE_20);
                make.size.mas_offset(CGSizeMake(YYSIZE_91, YYSIZE_31));
            }];
            WDWeakify(self);
            [cancelView bk_addEventHandler:^(id  _Nonnull sender) {
                WDStrongify(self);
                [self removeFromSuperview];
                if (self.cancelBlock) {
                    self.cancelBlock();
                }
            } forControlEvents:UIControlEventTouchUpInside];
            
            YYButton *confirmView = [[YYButton alloc] initWithFont:FONT_DESIGN_26 borderWidth:0.5f borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"确认") titleColor:COLOR_ffffff backgroundColor:COLOR_3d5afe cornerRadius:2.0f];
            [bottomView addSubview:confirmView];
            [confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.textField.mas_right);
                make.top.mas_equalTo(cancelView.mas_top);
                make.size.mas_offset(CGSizeMake(YYSIZE_91, YYSIZE_31));
            }];
            [confirmView bk_addEventHandler:^(id  _Nonnull sender) {
                WDStrongify(self);
                if (self.textContent.length == 0) {
                    [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入交易密码") attachedView:[UIApplication sharedApplication].keyWindow];
                    return ;
                }
                [self removeFromSuperview];
                NSString *passwordString = [EVOMd5Generate genMd5:self.textContent];
                if (self.confirmBlock) {
                    self.confirmBlock(passwordString);
                }
            } forControlEvents:UIControlEventTouchUpInside];
        }
    return self;
}

#pragma mark - textfield

- (void)textField:(UITextField *)textField {
    self.textContent = self.textField.text;
}


@end
