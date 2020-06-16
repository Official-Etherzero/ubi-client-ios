//
//  StatisticsView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/4/23.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "StatisticsView.h"
#import "YYViewHeader.h"

@interface StatisticsView ()

@property (nonatomic, strong) YYLabel *countView;
@property (nonatomic, strong) YYLabel *priceView;
@property (nonatomic, strong) YYLabel *lastView;
@property (nonatomic, strong) YYLabel *sumView;

@end

@implementation StatisticsView

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.backgroundColor = COLOR_1a203a;
    self.lastView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_3ae9df text:@"最近成交价:¥0"];
    [self addSubview:self.lastView];
    [self.lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_15);
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_12);
    }];
    
    self.priceView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_3ae9df text:@"指导价:¥0"];
    [self addSubview:self.priceView];
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lastView.mas_left);
        make.top.mas_equalTo(self.lastView.mas_bottom).offset(YYSIZE_05);
    }];
    
    self.countView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_3ae9df text:YYStringWithKey(@"求购单:0")];
    [self addSubview:self.countView];
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_12);
        make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_100);
    }];
    
    self.sumView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_3ae9df text:YYStringWithKey(@"求购总量")];
    [self addSubview:self.sumView];
    [self.sumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.countView.mas_left);
        make.top.mas_equalTo(self.countView.mas_bottom).offset(YYSIZE_05);
    }];
}

- (void)setModel:(StatisticsModel *)model {
    _model = model;
    self.countView.text = [NSString stringWithFormat:@"求购单:%ld",(long)model.Count];
    self.priceView.text = [NSString stringWithFormat:@"指导价:¥%@",model.Price];
    self.lastView.text = [NSString stringWithFormat:@"最近成交价:¥%@",model.LastPrice];
    self.sumView.text = [NSString stringWithFormat:@"求购总量:%@",model.Sum];
}

@end
