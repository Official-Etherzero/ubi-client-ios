//
//  YYTextView.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/20.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYTextView.h"
#import "YYViewHeader.h"


@implementation YYTextView

CGFloat const UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION = 0.25;


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Use Interface Builder User Defined Runtime Attributes to set
    // placeholder and placeholderColor in Interface Builder.
    if (!self.placeholder) {
        [self setPlaceholder:@""];
    }
    
    if (!self.placeholderColor) {
        [self setPlaceholderColor:[UIColor lightGrayColor]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification {
    if ([[self placeholder] length] == 0) {
        return;
    }
    
    [UIView animateWithDuration:UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION animations:^{
        if ([[self text] length] == 0) {
            [[self viewWithTag:999] setAlpha:1];
        } else {
            [[self viewWithTag:999] setAlpha:0];
        }
    }];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

- (void)setAlignment:(NSTextAlignment)alignment {
    [super setTextAlignment:alignment];
    _alignment = alignment;
}

- (void)drawRect:(CGRect)rect {
    if ([[self placeholder] length] > 0) {
        if (_placeHolderLabel == nil) {
            //left top 互换，坐标系不一样的
//            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.textContainerInset.left + 4/*magic*/,
//                                                                          self.textContainerInset.top,
//                                                                          self.bounds.size.width - 16,
//                                                                          YYSIZE_20)];
            _placeHolderLabel = [[UILabel alloc] init];
            [self addSubview:_placeHolderLabel];
            [_placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.mas_centerY);
                make.width.mas_equalTo(self.bounds.size.width);
                make.left.mas_equalTo(self.mas_left).offset(YYSIZE_03);
            }];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeholderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            _placeHolderLabel.textAlignment = self.textAlignment;
//            [self addSubview:_placeHolderLabel];
        }
        _placeHolderLabel.text = self.placeholder;
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if ([[self text] length] == 0 && [[self placeholder] length] > 0) {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
}

@end
