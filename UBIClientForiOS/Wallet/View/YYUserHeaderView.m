//
//  YYUserHeaderView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/23.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYUserHeaderView.h"
#import "YYUserDefaluts.h"
#import "YYViewHeader.h"

@interface YYUserHeaderView ()

@property (nonatomic, strong) YYLabel *usernameLabel;
@property (nonatomic, strong) YYLabel *userIdLabel;

@end

@implementation YYUserHeaderView

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.backgroundColor = COLOR_151824;
    UIImageView *rightView = [[UIImageView alloc] init];
    [self addSubview:rightView];
    rightView.image = [UIImage imageNamed:@"person_header"];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(YYSIZE_05);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(YYSIZE_50, YYSIZE_50));
    }];
    
    self.usernameLabel = [[YYLabel alloc] init];
    [self addSubview:self.usernameLabel];
    self.usernameLabel.text = @"example@sina.com";
    if ([YYUserDefaluts yy_getUserInfo]) {
        self.usernameLabel.text = [YYUserDefaluts yy_getUserInfo];
    }
    [self.usernameLabel setTextColor:COLOR_ffffff];
    self.usernameLabel.textAlignment = NSTextAlignmentLeft;
    [self.usernameLabel setFont:FONT_DESIGN_40];
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(rightView.mas_right).offset(YYSIZE_05);
        make.top.mas_equalTo(rightView.mas_top).offset(-YYSIZE_03);
        make.size.mas_offset(CGSizeMake(YYSIZE_200, YYSIZE_38));
    }];
    
    self.userIdLabel = [[YYLabel alloc] init];
    [self addSubview:self.userIdLabel];
    self.userIdLabel.text = @"UID:10000001";
    [self.userIdLabel setTextColor:COLOR_ffffff_A06];
    self.userIdLabel.textAlignment = NSTextAlignmentLeft;
    [self.userIdLabel setFont:FONT_DESIGN_24];
    [self.userIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.usernameLabel.mas_left);
        make.bottom.mas_equalTo(rightView.mas_bottom);
        make.size.mas_offset(CGSizeMake(YYSIZE_200, YYSIZE_20));
    }];
}

- (void)setInfoModel:(YYUserInfoModel *)infoModel {
    _infoModel = infoModel;
    NSString *numString = infoModel.Email && infoModel.Email.length > 0 ? infoModel.Email : infoModel.Phone;
    NSString *numberString = [numString stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    self.usernameLabel.text = numberString;
    self.userIdLabel.text = [NSString stringWithFormat:@"UID: %@",infoModel.UserID];
}

@end
