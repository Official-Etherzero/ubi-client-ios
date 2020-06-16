//
//  RevenueView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/2/16.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "RevenueView.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import "NSString+Ext.h"

@interface RevenueView ()

@property (nonatomic, strong) YYLabel *contentView;

@end

@implementation RevenueView

- (instancetype)initRevenueViewWithIcon:(NSString *)iconString
                                  title:(nonnull NSString *)title {
    if (self = [super init]) {
        UIImageView *leftView = [[UIImageView alloc] init];
        leftView.image = [UIImage imageNamed:iconString];
        [self addSubview:leftView];
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_7d87a0 text:title];
        [self addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftView.mas_right).offset(YYSIZE_05);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        YYLabel *contentView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_ffffff text:@"0"];
        [self addSubview:contentView];
        self.contentView = contentView;
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_15);
        }];
    }
    return self;
}

- (void)setContent:(NSString *)content {
    self.contentView.text = content;
}



@end
