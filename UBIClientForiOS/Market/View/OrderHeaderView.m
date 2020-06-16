//
//  OrderHeaderView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/4/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "OrderHeaderView.h"
#import "YYViewHeader.h"

@implementation OrderHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = COLOR_1a203a;
        
        YYLabel *orderNum = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:COLOR_899ae4 text:YYStringWithKey(@"订单号")];
        [self addSubview:orderNum];
        [orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_23);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        YYLabel *numTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:COLOR_899ae4 text:YYStringWithKey(@"数量")];
        [self addSubview:numTitleView];
        [numTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_112);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        YYLabel *unitTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:COLOR_899ae4 text:YYStringWithKey(@"价格")];
        [self addSubview:unitTitleView];
        [unitTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_182);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        YYLabel *optionView = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:COLOR_899ae4 text:YYStringWithKey(@"操作")];
        [self addSubview:optionView];
        [optionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_28);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return self;
}

+ (NSString *)identifier {
    return @"OrderHeaderView";
}

+ (CGFloat)height {
    return YYSIZE_60;
}

@end
