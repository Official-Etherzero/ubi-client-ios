//
//  YYPlaceholderView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/20.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYPlaceholderView.h"
#import "YYViewHeader.h"
#import "YYTextView.h"
#import "Masonry.h"

@interface YYPlaceholderView ()
<UITextViewDelegate>

@property (nonatomic, strong) YYTextView *textView;
@property (nonatomic, strong) UILabel    *contentLabel;
@property (nonatomic, strong) UILabel    *label;

@end

@implementation YYPlaceholderView

- (instancetype)initWithAttackView:(UIView *)attackView
                            plcStr:(NSString *)plcStr
                              font:(UIFont *)font
                        leftMargin:(float)leftMargin {
    if (self = [super init]) {
        self.backgroundColor = COLOR_ffffff;
        [attackView addSubview:self];
        self.textView = [YYTextView new];
        self.textView.backgroundColor = COLOR_ffffff;
        self.textView.textColor = COLOR_1a1a1a;
        self.textView.textAlignment = NSTextAlignmentLeft;
        self.textView.font = font;
        self.textView.placeholder = plcStr;
        self.textView.placeholderColor = COLOR_1a1a1a_A025;
        self.textView.delegate = self;
        self.textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, 0);
        [self addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(leftMargin);
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_60);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_offset(YYSIZE_16);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = COLOR_ebecf0;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH -leftMargin*2, 1));
        }];
    }
    return self;
}

- (instancetype)initWithAttackView:(UIView *)attackView
                            plcStr:(NSString *)plcStr
                        leftMargin:(float)margin {
    if (self = [super init]) {
        self.backgroundColor = COLOR_151824;
        [attackView addSubview:self];
        self.textView = [YYTextView new];
        self.textView.backgroundColor = COLOR_151824;
        self.textView.textColor = COLOR_ffffff;
        self.textView.textAlignment = NSTextAlignmentLeft;
        self.textView.font = FONT_DESIGN_28;
        self.textView.placeholder = plcStr;
        self.textView.placeholderColor = COLOR_7d87a0;
        self.textView.delegate = self;
        [self addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
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

- (instancetype)initPlaceholderViewWithFont:(UIFont *)font
                                     plcStr:(NSString *)plcStr
                                 leftMargin:(float)leftMargin {
    if (self = [super init]) {
        self.backgroundColor = COLOR_151824;
        self.textView = [YYTextView new];
        self.textView.backgroundColor = COLOR_151824;
        self.textView.textColor = COLOR_ffffff;
        self.textView.textAlignment = NSTextAlignmentLeft;
        self.textView.font = font;
        self.textView.placeholder = YYStringWithKey(plcStr);
        self.textView.placeholderColor = COLOR_ffffff_A05;
        self.textView.delegate = self;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.textView.text attributes:@{NSKernAttributeName:@(0)}];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.textView.text length])];
        self.textView.attributedText = attributedString;
        [self.textView sizeToFit];
        [self addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(leftMargin);
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_60);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.height.mas_offset(YYSIZE_40);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = COLOR_ebecf0;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.size.mas_offset(CGSizeMake(YYSCREEN_WIDTH -leftMargin*2, 1));
        }];
    }
    return self;
}

- (instancetype)initWithAttackView:(UIView *)attackView
                             title:(NSString *)title
                            plcStr:(NSString *)plcStr {
    if (self = [super init]) {
        [attackView addSubview:self];
        [self initSubViewsWithTitle:title plcStr:plcStr];
    }
    return self;
}

- (void)initSubViewsWithTitle:(NSString *)title plcStr:(NSString *)plcString {
    self.backgroundColor = COLOR_151824;
    
    self.textView = [YYTextView new];
    self.textView.backgroundColor = COLOR_151824;
    self.textView.textColor = COLOR_ffffff;
    self.textView.textAlignment = NSTextAlignmentLeft;
    self.textView.font = FONT_DESIGN_28;
    self.textView.placeholder = plcString;
    self.textView.placeholderColor = COLOR_ffffff_A05;
    self.textView.delegate = self;
    [self addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_110);
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_60);
        make.centerY.mas_equalTo(self.mas_centerY).offset(-0.5);
        make.height.mas_offset(YYSIZE_30);
    }];
    
    UILabel *label = [UILabel new];
    label.text = title;
    label.textColor = COLOR_ffffff;
    label.font = FONT_DESIGN_28;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(YYSIZE_22);
        make.centerY.mas_equalTo(self.textView.mas_centerY);
    }];
    self.label = label;
    
    UIView *line = [UIView new];
    line.backgroundColor = COLOR_212538;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, 0.5));
    }];
}

- (instancetype)initWithAttackView:(UIView *)attackView
                             title:(NSString *)title
                           content:(NSString *)content {
    if (self = [super init]) {
        [attackView addSubview:self];
        self.backgroundColor = COLOR_1b213b;
        
        UILabel *contentView = [UILabel new];
        contentView.textColor = COLOR_ffffff;
        contentView.textAlignment = NSTextAlignmentLeft;
        contentView.numberOfLines = 0;
        contentView.font = FONT_DESIGN_28;
        [self addSubview:contentView];
        contentView.text = content;
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_95);
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_60);
            make.centerY.mas_equalTo(self.mas_centerY).offset(-0.5);
            make.height.mas_offset(YYSIZE_40);
        }];
        self.contentLabel = contentView;
        
        UILabel *label = [UILabel new];
        label.text = title;
        label.textColor = COLOR_7d87a0;
        label.font = FONT_DESIGN_28;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(YYSIZE_22);
            make.centerY.mas_equalTo(contentView.mas_centerY);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = COLOR_212538;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.size.mas_offset(CGSizeMake(YYSIZE_331, 0.5));
        }];
    }
    return self;
}

- (instancetype)initWithAttackViewFont:(UIFont *)font
                                height:(CGFloat)height
                                plcStr:(NSString *)plcStr{
    if (self = [super init]) {
        self.backgroundColor = COLOR_1a203a;
        self.textView = [YYTextView new];
        self.textView.backgroundColor = COLOR_1a203a;
        self.textView.textColor = COLOR_ffffff;
        self.textView.textAlignment = NSTextAlignmentLeft;
        self.textView.font = font;
        [self.textView.placeHolderLabel setFont:font];
        self.textView.placeholder = plcStr;
        self.textView.placeholderColor = COLOR_383f57;
        self.textView.delegate = self;
        [self addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_10);
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_offset(height);
        }];
    }
    return self;
}

- (void)resignFirstResponder {
    if ([self.textView isFirstResponder]) {
        [self.textView resignFirstResponder];
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.label.text = title;
}

- (void)setContent:(NSString *)content {
    _content = content;
    self.textView.text = content;
}

- (void)setDesString:(NSString *)desString {
    _desString = desString;
    self.contentLabel.text = desString;
}

#pragma mark - textDelegate

- (void)textViewDidChange:(UITextView *)textView {
    self.content = textView.text;
}

- (float)heightForTextView:(UITextView *)textView WithText:(NSString *)strText{
    CGSize constraint = CGSizeMake(textView.contentSize.width , CGFLOAT_MAX);
    CGRect size = [strText boundingRectWithSize:constraint
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}
                                        context:nil];
    float textHeight = size.size.height +22;
    return textHeight;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    CGRect frame = textView.frame;
    float height;
    if ([text isEqual:@""]) {
        if (![textView.text isEqualToString:@""]) {
            height = [ self heightForTextView:textView WithText:[textView.text substringToIndex:[textView.text length] - 1]];
        }else{
            height = [ self heightForTextView:textView WithText:textView.text];
        }
    }else{
        height = [self heightForTextView:textView WithText:[NSString stringWithFormat:@"%@%@",textView.text,text]];
    }
    frame.size.height = height;
    [UIView animateWithDuration:0.5 animations:^{
        textView.frame = frame;
    } completion:nil];
    return YES;
}


@end
