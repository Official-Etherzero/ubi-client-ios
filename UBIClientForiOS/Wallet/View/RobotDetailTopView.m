//
//  RobotDetailTopView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/29.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "RobotDetailTopView.h"
#import "YYViewHeader.h"
#import "YYDateModel.h"
#import "NSString+Ext.h"
#import "YYPercentView.h"
#import "YYEnum.h"

@interface RobotDetailTopView ()

@property (nonatomic, strong) YYLabel *nameView;
@property (nonatomic, strong) YYLabel *startView;
@property (nonatomic, strong) YYLabel *endView;
@property (nonatomic, strong) YYLabel *incomeView;
@property (nonatomic, strong) YYPercentView *percentView;
@property (nonatomic, strong) UIImageView  *bottomView;

@end

@implementation RobotDetailTopView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_ffffff;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    
    self.bottomView = [[UIImageView alloc] init];
    [self addSubview:self.bottomView];
    self.bottomView.layer.cornerRadius = 5.0f;
    self.bottomView.clipsToBounds = YES;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    YYLabel *incomeTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff_A05 text:[NSString stringWithFormat:@"%@(UBI)",YYStringWithKey(@"累计收益")]];
    incomeTitleView.textAlignment = NSTextAlignmentCenter;
    [self addSubview:incomeTitleView];
    [incomeTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.bottomView.mas_top).offset(YYSIZE_20);
        make.height.mas_offset(YYSIZE_12);
    }];
    
    self.incomeView = [[YYLabel alloc] initWithFont:FONT_BEBAS_54 textColor:COLOR_ffffff text:@""];
    [self addSubview:self.incomeView];
    self.incomeView.textAlignment = NSTextAlignmentCenter;
    [self.incomeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(incomeTitleView.mas_bottom).offset(YYSIZE_08);
        make.height.mas_offset(YYSIZE_28);
    }];
    
    YYLabel *startTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff_A05 text:YYStringWithKey(@"启动日期")];
    [self addSubview:startTitleView];
    startTitleView.textAlignment = NSTextAlignmentLeft;
    [startTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomView.mas_left).offset(YYSIZE_15);
        make.top.mas_equalTo(self.bottomView.mas_top).offset(YYSIZE_95);
        make.height.mas_offset(YYSIZE_12);
    }];
    
    self.startView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff text:@""];
    [self addSubview:self.startView];
    self.startView.textAlignment = NSTextAlignmentLeft;
    [self.startView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(startTitleView.mas_right).offset(YYSIZE_12);
        make.top.mas_equalTo(startTitleView.mas_top);
        make.height.mas_offset(YYSIZE_12);
    }];
    
    YYLabel *endTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff_A05 text:YYStringWithKey(@"到期日期")];
    endTitleView.textAlignment = NSTextAlignmentLeft;
    [self addSubview:endTitleView];
    [endTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(startTitleView.mas_left);
        make.top.mas_equalTo(startTitleView.mas_bottom).offset(YYSIZE_15);
        make.height.mas_offset(YYSIZE_12);
    }];
    
    self.endView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff text:@""];
    [self addSubview:self.endView];
    self.endView.textAlignment = NSTextAlignmentLeft;
    [self.endView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.startView.mas_left);
        make.top.mas_equalTo(endTitleView.mas_top);
        make.height.mas_offset(YYSIZE_12);
    }];
    
    self.percentView = [[YYPercentView alloc] init];
    [self addSubview:self.percentView];
    [self.percentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_15);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-YYSIZE_15);
        make.size.mas_offset(CGSizeMake(YYSIZE_60, YYSIZE_60));
    }];
}

- (void)setModel:(NodeDetailModel *)model {
    _model = model;
    NSString *imageString;
    switch (model.MiniID) {
        case MINING_MACHINE_PRIMARY:
            imageString = @"primary_big";
            break;
        case MINING_MACHINE_INTERMEDIATE:
            imageString = @"intermediate_big";
            break;
        case MINING_MACHINE_ADVANCED:
            imageString = @"multifunctional_big";
            break;
        case MINING_MACHINE_TOP:
            imageString = @"top_big";
            break;
        case MINING_MACHINE_SUPER:
            imageString = @"super_big";
            break;
        case MINING_MACHINE_INTELLIGENT:
            imageString = @"intelligent_big";
            break;
        default:
            break;
    }
    self.bottomView.image = [UIImage imageNamed:imageString];
    self.nameView.text = model.Name;
    self.startView.text = model.StartTime;
    self.endView.text = model.ExpireTime;
    self.percentView.percent = model.RateOfProgress;
}

- (void)setIncome:(NSString *)income {
    _income = income;
    self.incomeView.text = [income yy_holdDecimalPlaceToIndex:4];
}

@end
