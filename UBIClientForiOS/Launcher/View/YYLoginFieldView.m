//
//  YYLoginFieldView.m
//  UBIClientForiOS
//
//  Created by etz on 2020/5/19.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYLoginFieldView.h"
#import "YYViewHeader.h"

@interface YYLoginFieldView ()

@end

@implementation YYLoginFieldView

- (instancetype)initWithAttackView:(UIView *)attackView plcStr:(NSString *)plcStr leftMargin:(float)margin {
    if (self = [super init]) {
        self.backgroundColor = COLOR_151824;
        [attackView addSubview:self];
        self.textField = [[UITextField alloc] init];
        self.textField.borderStyle = UITextBorderStyleNone;
        self.textField.font = FONT_DESIGN_28;
        self.textField.textColor = COLOR_ffffff;
        NSMutableAttributedString *plc = [[NSMutableAttributedString alloc] initWithString:plcStr attributes:@{NSFontAttributeName: FONT_DESIGN_28,NSForegroundColorAttributeName:COLOR_7d87a0}];
        self.textField.attributedPlaceholder = plc;
        self.textField.secureTextEntry = NO;
        [self.textField addTarget:self action:@selector(textField:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(margin);
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_60);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.height.mas_offset(YYSIZE_40);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = COLOR_212538;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH -YYSIZE_24*2, 0.5));
        }];
    }
    return self;
}

- (void)setSecureTextEntry:(BOOL)isSecurity {
    self.textField.secureTextEntry = isSecurity;
}

- (void)updateSecureTextEntry:(BOOL)isSecurity {
    [self.textField becomeFirstResponder];
    self.content = self.textField.text;
    if (isSecurity) {
        self.textField.secureTextEntry = YES;
    } else {
        self.textField.secureTextEntry = NO;
    }
}

#pragma mark - textfield

- (void)textField:(UITextField *)textField {
    self.content = self.textField.text;
}

@end
