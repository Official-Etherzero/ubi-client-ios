//
//  RobotIncomeCell.m
//  UBIClientForiOS
//
//  Created by etz on 2020/1/2.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "RobotIncomeCell.h"
#import "YYViewHeader.h"
#import "NSString+Ext.h"

@interface RobotIncomeCell ()

@property (nonatomic, strong) YYLabel  *timeView;
@property (nonatomic, strong) YYLabel  *incomeView;

@end

@implementation RobotIncomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR_151824;
        
        UIView *line = [UIView new];
        line.backgroundColor = COLOR_212538;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(-0.5);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_335, 0.5));
        }];
        
        self.timeView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_ffffff text:@""];
        self.timeView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.timeView];
        [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
        }];
        
        self.incomeView = [[YYLabel alloc] initWithFont:FONT_DESIGN_26 textColor:COLOR_ffffff text:@""];
        self.incomeView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.incomeView];
        [self.incomeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_20);
        }];
    }
    return self;
}

- (void)setModel:(RewardModel *)model {
    _model = model;
    self.timeView.text = model.WriteTime;
    self.incomeView.text = [NSString stringWithFormat:@"+ %@ UBI",[[NSString stringWithFormat:@"%f",model.Amount] yy_holdDecimalPlaceToIndex:4]];
}

+ (NSString *)identifier {
    return @"RobotIncomeCell";
}

@end
