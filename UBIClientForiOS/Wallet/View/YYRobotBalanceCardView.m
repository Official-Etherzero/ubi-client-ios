//
//  YYRobotBalanceCardView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/2/17.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYRobotBalanceCardView.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import "NSString+Ext.h"


@interface YYRobotBalanceCardView ()

@property (nonatomic, strong) YYLabel *balanceView;

@end

@implementation YYRobotBalanceCardView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_151824;
        self.layer.cornerRadius = 15.0f;
        self.clipsToBounds = YES;
        
        UIImageView *bottomView = [[UIImageView alloc] init];
        bottomView.image = [UIImage imageNamed:@"robot_bg"];
        [self addSubview:bottomView];
        bottomView.layer.cornerRadius = 15.0f;
        bottomView.clipsToBounds = YES;
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_offset(CGSizeMake(YYSIZE_300, YYSIZE_175));
        }];
        
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_cbd9ff text:YYStringWithKey(@"Robot Balance (UBI)")];
        [self addSubview:titleView];
        titleView.textAlignment = NSTextAlignmentCenter;
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_60);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        self.balanceView = [[YYLabel alloc] initWithFont:FONT_BEBAS_44 textColor:COLOR_ffffff text:@"0"];
        [self addSubview:self.balanceView];
        self.balanceView.textAlignment = NSTextAlignmentCenter;
        [self.balanceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_10);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
    }
    return self;
}

- (void)setBalance:(double)balance {
    self.balanceView.text = [[NSString stringWithFormat:@"%f",balance] yy_holdDecimalPlaceToIndex:8];
}


@end
