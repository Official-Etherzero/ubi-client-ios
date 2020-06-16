//
//  RunningRobotCell.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "RunningRobotCell.h"
#import "YYViewHeader.h"
#import "YYDateModel.h"
#import "YYPercentView.h"
#import "YYEnum.h"

@interface RunningRobotCell ()

@property (nonatomic, strong) YYLabel  *titleView;
@property (nonatomic, strong) YYLabel  *startView;
@property (nonatomic, strong) YYLabel  *endView;
@property (nonatomic, strong) YYPercentView *percentView;
@property (nonatomic, strong) UIImageView   *bottomView;

@end

@implementation RunningRobotCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR_151824;
        
        self.bottomView = [[UIImageView alloc] init];
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
            make.left.mas_equalTo(self.bottomView.mas_left).offset(YYSIZE_12);
            make.top.mas_equalTo(self.bottomView.mas_top).offset(YYSIZE_15);
        }];
        
        YYLabel *startTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff_A05 text:YYStringWithKey(@"启动日期")];
        startTitleView.textAlignment = NSTextAlignmentLeft;
        [self.bottomView addSubview:startTitleView];
        [startTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleView);
            make.top.mas_equalTo(self.titleView.mas_bottom).offset(YYSIZE_24);
        }];
        
        self.startView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff text:@""];
        self.startView.textAlignment = NSTextAlignmentLeft;
        [self.bottomView addSubview:self.startView];
        [self.startView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(startTitleView.mas_right).offset(YYSIZE_10);
            make.top.mas_equalTo(startTitleView.mas_top);
        }];
        
        YYLabel *endTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff_A05 text:YYStringWithKey(@"到期日期")];
        endTitleView.textAlignment = NSTextAlignmentLeft;
        [self.bottomView addSubview:endTitleView];
        [endTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleView);
            make.top.mas_equalTo(startTitleView.mas_bottom).offset(YYSIZE_06);
        }];
        
        self.endView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff text:@""];
        self.endView.textAlignment = NSTextAlignmentLeft;
        [self.bottomView addSubview:self.endView];
        [self.endView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.startView.mas_left);
            make.top.mas_equalTo(endTitleView.mas_top);
        }];
        
        self.percentView = [[YYPercentView alloc] init];
        [self.bottomView addSubview:self.percentView];
        [self.percentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bottomView.mas_right).offset(-YYSIZE_15);
            make.centerY.mas_equalTo(self.bottomView.mas_centerY);
            make.size.mas_offset(CGSizeMake(YYSIZE_60, YYSIZE_60));
        }];
    }
    return self;
}

- (void)setModel:(NodeDetailModel *)model {
    _model = model;
    self.bottomView.image = [UIImage imageNamed:yyGetMiningMachineCardImageString(model.MiniID)];
    self.titleView.text = model.Name;
    self.startView.text = model.StartTime;
    self.endView.text = model.ExpireTime;
    self.percentView.percent = model.RateOfProgress;
}

+ (NSString *)identifier {
    return @"RunningRobotCell";
}

@end
