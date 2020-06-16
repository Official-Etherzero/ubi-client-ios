//
//  RobotCardView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/2/16.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "RobotCardView.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import "RobotTitleView.h"
#import "NSString+Ext.h"
#import "RevenueView.h"

@interface RobotCardView ()

@property (nonatomic, strong) RobotTitleView *myPowerView;
@property (nonatomic, strong) RobotTitleView *teamPowerView;
@property (nonatomic, strong) RevenueView    *lastRevenueView;
@property (nonatomic, strong) RevenueView    *cumulativeRevenueView;

@end

@implementation RobotCardView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_1b213b;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.myPowerView = [[RobotTitleView alloc] initWithLeftView:@"MyPower" title:[NSString stringWithFormat:@"%@(T)",YYStringWithKey(@"我的算力")]];
    [self addSubview:self.myPowerView];
    [self.myPowerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_15);
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_30);
        make.size.mas_offset(CGSizeMake(YYSIZE_150, YYSIZE_40));
    }];
    
    self.teamPowerView = [[RobotTitleView alloc] initWithLeftView:@"TeamPower" title:[NSString stringWithFormat:@"%@(T)",YYStringWithKey(@"全网算力")]];
    [self addSubview:self.teamPowerView];
    [self.teamPowerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_15);
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_30);
        make.size.mas_offset(CGSizeMake(YYSIZE_150, YYSIZE_40));
    }];
    
    self.lastRevenueView = [[RevenueView alloc] initRevenueViewWithIcon:@"LastRevenue" title:YYStringWithKey(@"昨日收益")];
    [self addSubview:self.lastRevenueView];
    [self.lastRevenueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.myPowerView.mas_bottom).offset(YYSIZE_30);
        make.left.right.mas_equalTo(self);
        make.height.mas_offset(YYSIZE_15);
    }];
    
    // CumulativeRevenue
    self.cumulativeRevenueView = [[RevenueView alloc] initRevenueViewWithIcon:@"CumulativeRevenue" title:YYStringWithKey(@"累计收益")];
    [self addSubview:self.cumulativeRevenueView];
    [self.cumulativeRevenueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lastRevenueView.mas_bottom).offset(YYSIZE_12);
        make.left.right.mas_equalTo(self);
        make.height.mas_offset(YYSIZE_15);
    }];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(enterToTeamNode)];
    [self addGestureRecognizer:tapGesture];
}

- (void)enterToTeamNode {
    if (self.tapTeamNodeBlock) {
        self.tapTeamNodeBlock();
    }
}

- (void)setEarnModel:(RobotEarningsModel *)earnModel {
    self.lastRevenueView.content = [[NSString stringWithFormat:@"%f",earnModel.Last] yy_holdDecimalPlaceToIndex:6];
    self.cumulativeRevenueView.content = [[NSString stringWithFormat:@"%f",earnModel.Cumulative] yy_holdDecimalPlaceToIndex:6];;
}

- (void)setInfoModel:(YYUserInfoModel *)infoModel {
    _infoModel = infoModel;
    self.myPowerView.content = [infoModel.MySuanLi yy_holdDecimalPlaceToIndex:4];
    self.teamPowerView.content = [infoModel.AllSuanLi yy_holdDecimalPlaceToIndex:4];
    self.lastRevenueView.content = [infoModel.MyRewardYes yy_holdDecimalPlaceToIndex:4];
    self.cumulativeRevenueView.content = [infoModel.MyReward yy_holdDecimalPlaceToIndex:4];
}

@end
