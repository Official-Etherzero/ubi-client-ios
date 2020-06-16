//
//  RobotBottomView.m
//  UBIClientForiOS
//
//  Created by etz on 2019/12/26.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "RobotBottomView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "UIButton+Ext.h"

@implementation RobotBottomView

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.backgroundColor = COLOR_151824;
//        UIView *leftView = [[UIView alloc] init];
//        [self addSubview:leftView];
//        leftView.backgroundColor = COLOR_3d5afe;
//        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self);
//            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_31);
//            make.size.mas_offset(CGSizeMake(YYSIZE_04, YYSIZE_19));
//        }];
        
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_Heavy_44 textColor:COLOR_ffffff text:title];
        titleView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_31);
        }];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_151824;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"robot"];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(YYSIZE_50);
        make.size.mas_offset(CGSizeMake(YYSIZE_87, YYSIZE_80));
    }];
    
    YYLabel *centerView = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:COLOR_7d87a0 text:YYStringWithKey(@"您还没有机器人")];
    centerView.textAlignment = NSTextAlignmentCenter;
    [self addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(YYSIZE_10);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    YYButton *addView = [[YYButton alloc] initWithFont:FONT_PingFangSC_Medium_30 borderWidth:0.5f borderColoer:COLOR_1b213b.CGColor masksToBounds:YES title:YYStringWithKey(@"立即购买") titleColor:COLOR_ffffff backgroundColor:COLOR_1b213b cornerRadius:28.5f];
    addView.titleLabel.textAlignment = NSTextAlignmentCenter;
    [addView setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addView yy_leftButtonAndImageWithSpacing:10];
    [self addSubview:addView];
    [addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(YYSIZE_45);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_331, YYSIZE_57));
    }];
    WDWeakify(self);
    [addView bk_addEventHandler:^(id  _Nonnull sender) {
        WDStrongify(self);
        if (self.addMinerBlock) {
            self.addMinerBlock();
        }
    } forControlEvents:UIControlEventTouchUpInside];
}


@end
