//
//  RobotTopView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "RobotTopView.h"
#import "YYViewHeader.h"
#import "RobotTitleView.h"
#import "NSString+Ext.h"

@interface RobotTopView ()
@property (nonatomic, strong) RobotTitleView *allHashrateView;
@property (nonatomic, strong) RobotTitleView *allNodesView;
@property (nonatomic, strong) RobotTitleView *myHashrateView;
@property (nonatomic, strong) RobotTitleView *teamHashrateView;
@property (nonatomic, strong) YYLabel        *balanceView;

@end

@implementation RobotTopView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_151824;
        
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ebefff text:YYStringWithKey(@"余额(UBI)")];
        titleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_30);
            make.height.mas_offset(YYSIZE_12);
        }];
        
        self.balanceView = [[YYLabel alloc] initWithFont:FONT_BEBAS_70 textColor:COLOR_ffffff text:@"0"];
        self.balanceView.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.balanceView];
        [self.balanceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.top.mas_equalTo(titleView.mas_bottom).offset(YYSIZE_12);
            make.height.mas_offset(YYSIZE_35);
        }];
        
        self.allHashrateView = [[RobotTitleView alloc] initWithLeftView:@"net" title:[NSString stringWithFormat:@"%@(T)",YYStringWithKey(@"全网算力")]];
        [self addSubview:self.allHashrateView];
        
        self.allNodesView = [[RobotTitleView alloc] initWithLeftView:@"dot" title:YYStringWithKey(@"全网节点(个)")];
        [self addSubview:self.allNodesView];
        
        self.myHashrateView = [[RobotTitleView alloc] initWithLeftView:@"my" title:[NSString stringWithFormat:@"%@(T)",YYStringWithKey(@"我的算力")]];
        [self addSubview:self.myHashrateView];
        
        self.teamHashrateView = [[RobotTitleView alloc] initWithLeftView:@"team" title:[NSString stringWithFormat:@"%@(T)",YYStringWithKey(@"团队算力")]];
        [self addSubview:self.teamHashrateView];
        
        [self.allHashrateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.balanceView.mas_left);
            make.top.mas_equalTo(self.balanceView.mas_bottom).offset(YYSIZE_25);
            make.size.mas_offset(CGSizeMake(YYSIZE_160, YYSIZE_70));
        }];
        
        [self.allNodesView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
            make.top.mas_equalTo(self.allHashrateView.mas_top);
            make.size.mas_offset(CGSizeMake(YYSIZE_160, YYSIZE_70));
        }];
        
        [self.myHashrateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.balanceView.mas_left);
            make.top.mas_equalTo(self.allHashrateView.mas_bottom).offset(YYSIZE_11);
            make.size.mas_offset(CGSizeMake(YYSIZE_160, YYSIZE_70));
        }];
        
        [self.teamHashrateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_22);
            make.top.mas_equalTo(self.myHashrateView.mas_top);
            make.size.mas_offset(CGSizeMake(YYSIZE_160, YYSIZE_70));
        }];
    }
    return self;
}

- (void)setBalance:(NSString *)balance {
    _balance = balance;
    self.balanceView.text = [balance yy_holdDecimalPlaceToIndex:4];
}

- (void)setModel:(YYUserInfoModel *)model {
    self.balanceView.text = model.ETZ;
    self.allHashrateView.content = [model.AllSuanLi yy_holdDecimalPlaceToIndex:2];
    self.allNodesView.content = model.AllNodeCount;
    self.myHashrateView.content = [model.MySuanLi yy_holdDecimalPlaceToIndex:2];
    self.teamHashrateView.content = [model.TeamSuanLi yy_holdDecimalPlaceToIndex:2];
}

@end
