//
//  RobotsListCell.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "RobotsListCell.h"
#import "YYViewHeader.h"
#import "SettingRowModel.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "YYEnum.h"
#import "NSString+Ext.h"
#import "UILabel+Ext.h"

@interface RobotsListCell ()

@property(nonatomic, strong, readwrite) YYLabel  *titleView;
@property(nonatomic, strong, readwrite) YYLabel  *priceView;
@property(nonatomic, strong, readwrite) YYLabel  *dailyOutput;
@property(nonatomic, strong, readwrite) YYLabel  *cycleView;
@property(nonatomic, strong, readwrite) YYLabel  *remainingView;
@property(nonatomic, strong, readwrite) YYButton *buyBtn;
@property(nonatomic, strong, readwrite) UIImageView *bottomView;

@end

@implementation RobotsListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR_151824;
        
        self.bottomView = [[UIImageView alloc] init];
        self.bottomView.image = [UIImage imageNamed:@"multifunctional_big"];
        self.bottomView.layer.cornerRadius = 5.0f;
        self.bottomView.clipsToBounds = YES;
        [self addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_100));
        }];
        
        self.titleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff text:@""];
        self.titleView.textAlignment = NSTextAlignmentLeft;
        [self.bottomView addSubview:self.titleView];
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_26);
            make.left.mas_equalTo(self.bottomView.mas_left).offset(YYSIZE_12);
            make.height.mas_offset(YYSIZE_15);
        }];
        
        YYLabel *daylyTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff_A05 text:YYStringWithKey(@"日产出")];
        daylyTitleView.textAlignment = NSTextAlignmentLeft;
        [self.bottomView addSubview:daylyTitleView];
        [daylyTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleView);
            make.top.mas_equalTo(self.titleView.mas_bottom).offset(YYSIZE_22);
        }];
        
        self.dailyOutput = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff text:@""];
        self.dailyOutput.textAlignment = NSTextAlignmentLeft;
        [self.bottomView addSubview:self.dailyOutput];
        [self.dailyOutput mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(daylyTitleView.mas_right).offset(YYSIZE_08);
            make.top.mas_equalTo(daylyTitleView.mas_top);
        }];
        
        YYLabel *cycleTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff_A05 text:YYStringWithKey(@"周期")];
        cycleTitleView.textAlignment = NSTextAlignmentLeft;
        [self.bottomView addSubview:cycleTitleView];
        [cycleTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleView);
            make.top.mas_equalTo(daylyTitleView.mas_bottom).offset(YYSIZE_09);
        }];
        
        self.cycleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff text:@""];
        self.cycleView.textAlignment = NSTextAlignmentLeft;
        [self.bottomView addSubview:self.cycleView];
        [self.cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dailyOutput.mas_left);
            make.top.mas_equalTo(cycleTitleView.mas_top);
        }];

        
        self.remainingView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ff6b3d text:@""];
        self.remainingView.backgroundColor = COLOR_ffd060;
        self.remainingView.layer.cornerRadius = 10.0f;
        self.remainingView.clipsToBounds = YES;
        self.remainingView.textAlignment = NSTextAlignmentCenter;
        [self.bottomView addSubview:self.remainingView];
        [self.remainingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bottomView.mas_right).offset(-YYSIZE_16);
            make.top.mas_equalTo(self.bottomView.mas_top).offset(YYSIZE_11);
            make.size.mas_offset(CGSizeMake(YYSIZE_94, YYSIZE_20));
        }];
        self.remainingView.hidden = YES;
        
        self.priceView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_36 textColor:COLOR_ffffff text:@""];
        self.priceView.textAlignment = NSTextAlignmentRight;
        [self.bottomView addSubview:self.priceView];
        [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bottomView.mas_right).offset(-YYSIZE_16);
//            make.bottom.mas_equalTo(self.bottomView.mas_bottom).offset(-YYSIZE_22);
            make.centerY.mas_equalTo(self.bottomView.mas_centerY);
        }];
    }
    return self;
}

- (void)setModel:(MiningInfosModel *)model {
    _model = model;
    self.titleView.text = yyGetMiningMachineTypeString(model.MiniID);
    self.bottomView.image = [UIImage imageNamed:yyGetMiningMachineCardImageString(model.MiniID)];
    self.priceView.text = [NSString stringWithFormat:@"%ld UBI",(long)model.Input];
    self.dailyOutput.text = [NSString stringWithFormat:@"%@ UBI",[model.Ret yy_holdDecimalPlaceToIndex:4]];
    self.cycleView.text = [NSString stringWithFormat:@"%ld%@",(long)model.Cycle,YYStringWithKey(@"天")];
    self.remainingView.text = [NSString stringWithFormat:@"%@%ld%@",YYStringWithKey(@"剩余"),(long)model.Limit,YYStringWithKey(@"台")];
}

- (void)setNodeModel:(NodeModel *)nodeModel {
    _nodeModel = nodeModel;
    self.titleView.text = yyGetMiningMachineTypeString(nodeModel.MiniID);
    self.bottomView.image = [UIImage imageNamed:yyGetMiningMachineCardImageString(nodeModel.MiniID)];
    self.priceView.text = [NSString stringWithFormat:@"%@ UBI",nodeModel.Input];
    self.dailyOutput.text = [NSString stringWithFormat:@"%@ UBI",nodeModel.EveryDay];
    self.cycleView.text = [NSString stringWithFormat:@"%@%@",nodeModel.Period,YYStringWithKey(@"天")];
//    self.remainingView.text = [NSString stringWithFormat:@"%@%ld%@",YYStringWithKey(@"剩余"),(long)model.Limit,YYStringWithKey(@"台")];
}

+ (NSString *)identifier {
    return @"RobotsListCell";
}

@end
