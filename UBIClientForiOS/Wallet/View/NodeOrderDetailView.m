//
//  NodeOrderDetailView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "NodeOrderDetailView.h"
#import "YYTextView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "YYSecureView.h"
#import "EVOMd5Generate.h"
#import "NSString+Ext.h"
#import "YYDateModel.h"
#import "YYToastView.h"

@interface NodeOrderDetailView ()

@property (nonatomic,   copy) ConfirmBlock confirmBlock;
@property (nonatomic,   copy) CancelBlock  cancelBlock;
@property (nonatomic,   copy) NSString     *textContent;
@property (nonatomic, strong) UITextField  *textField;

@end

@implementation NodeOrderDetailView

+ (instancetype)showOrderDetailViewWithModel:(NodeModel *)model
                                confirmBlock:(ConfirmBlock _Nullable)confirmBlock
                                 cancelBlock:(CancelBlock _Nullable)cancelBlock {
    NodeOrderDetailView *view = [[NodeOrderDetailView alloc] initWithNodeDetailModel:model];
    view.confirmBlock = confirmBlock;
    view.cancelBlock = cancelBlock;
    return view;
}

- (instancetype)initWithNodeDetailModel:(NodeModel *)model {
    if (self = [super init]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
        }];
        self.backgroundColor = COLOR_000000_A05;
        
        UIView *bottomView = [[UIView alloc] init];
        [self addSubview:bottomView];
        bottomView.layer.cornerRadius = 10.0f;
        bottomView.clipsToBounds = YES;
        bottomView.backgroundColor = COLOR_ffffff;
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_275, YYSIZE_273));
        }];
        
        // title View
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_30 textColor:COLOR_1a1a1a text:YYStringWithKey(@"订单详情")];
        titleView.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_16);
            make.centerX.mas_equalTo(bottomView.mas_centerX);
        }];
        
        // miner name
        YYLabel *minerView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_26 textColor:COLOR_1a1a1a text:model.Name];
        minerView.textAlignment = NSTextAlignmentLeft;
        [bottomView addSubview:minerView];
        [minerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bottomView.mas_left).offset(YYSIZE_35);
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_52);
        }];
        
        // create time
        YYLabel *createTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_1a1a1a_A08 text:YYStringWithKey(@"创建时间")];
        createTitleView.textAlignment = NSTextAlignmentLeft;
        [bottomView addSubview:createTitleView];
        [createTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(minerView.mas_left);
            make.top.mas_equalTo(minerView.mas_bottom).offset(YYSIZE_11);
        }];
        
        YYLabel *createView = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_1a1a1a_A08 text:[YYDateModel yy_currentDay]];
        createView.textAlignment = NSTextAlignmentRight;
        [bottomView addSubview:createView];
        [createView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(bottomView.mas_right).offset(-YYSIZE_34);
            make.top.mas_equalTo(minerView.mas_bottom).offset(YYSIZE_11);
        }];
        
        // cycle
        YYLabel *cycleTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_1a1a1a_A08 text:YYStringWithKey(@"周期")];
        cycleTitleView.textAlignment = NSTextAlignmentLeft;
        [bottomView addSubview:cycleTitleView];
        [cycleTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(minerView.mas_left);
            make.top.mas_equalTo(createTitleView.mas_bottom).offset(YYSIZE_06);
        }];
        
        YYLabel *cycleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_1a1a1a_A08 text:[NSString stringWithFormat:@"%@ 天",model.Period]];
        cycleView.textAlignment = NSTextAlignmentRight;
        [bottomView addSubview:cycleView];
        [cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(createView.mas_right);
            make.top.mas_equalTo(cycleTitleView.mas_top);
        }];
        
        // end time
        YYLabel *endTimeTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_1a1a1a_A08 text:YYStringWithKey(@"到期时间")];
        endTimeTitleView.textAlignment = NSTextAlignmentLeft;
        [bottomView addSubview:endTimeTitleView];
        [endTimeTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(minerView.mas_left);
            make.top.mas_equalTo(cycleTitleView.mas_bottom).offset(YYSIZE_06);
        }];
        
        YYLabel *endTimeView = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_1a1a1a_A08 text:[YYDateModel yy_afterCurrentDays:[model.Period integerValue]]];
        endTimeView.textAlignment = NSTextAlignmentRight;
        [bottomView addSubview:endTimeView];
        [endTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(createView.mas_right);
            make.top.mas_equalTo(endTimeTitleView.mas_top);
        }];
        
        // output
        YYLabel *outputTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_1a1a1a_A08 text:YYStringWithKey(@"每月产出")];
        outputTitleView.textAlignment = NSTextAlignmentLeft;
        [bottomView addSubview:outputTitleView];
        [outputTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(minerView.mas_left);
            make.top.mas_equalTo(endTimeTitleView.mas_bottom).offset(YYSIZE_06);
        }];
        
        YYLabel *outputView = [[YYLabel alloc] initWithFont:FONT_DESIGN_22 textColor:COLOR_ff5959 text:[NSString stringWithFormat:@"%ldUBI",(long)model.Earnings]];
        outputView.textAlignment = NSTextAlignmentRight;
        [bottomView addSubview:outputView];
        [outputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(createView.mas_right);
            make.top.mas_equalTo(outputTitleView.mas_top);
        }];

        self.textField = [[UITextField alloc] init];
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
        self.textField.font = FONT_DESIGN_28;
        self.textField.textColor = COLOR_1a1a1a;
        self.textField.layer.borderColor = COLOR_1a1a1a_A02.CGColor;
        self.textField.backgroundColor = COLOR_ffffff;
        self.textField.textAlignment = NSTextAlignmentCenter;
        self.textField.layer.cornerRadius = 2.0f;
        self.textField.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString *plc = [[NSMutableAttributedString alloc] initWithString:YYStringWithKey(@"请输入交易密码") attributes:@{NSFontAttributeName: FONT_DESIGN_24,NSForegroundColorAttributeName: COLOR_1a1a1a_A05}];
        self.textField.attributedPlaceholder = plc;
        self.textField.secureTextEntry = YES;
        [self.textField addTarget:self action:@selector(textField:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(outputTitleView.mas_bottom).offset(YYSIZE_16);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(YYSIZE_201, YYSIZE_31));
        }];
        
        YYButton *cancelView = [[YYButton alloc] initWithFont:FONT_DESIGN_26 borderWidth:0.5f borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"取消") titleColor:COLOR_3d5afe backgroundColor:COLOR_ffffff cornerRadius:2.0f];
        [bottomView addSubview:cancelView];
        [cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.textField.mas_left);
            make.top.mas_equalTo(self.textField.mas_bottom).offset(YYSIZE_20);
            make.size.mas_offset(CGSizeMake(YYSIZE_91, YYSIZE_31));
        }];
        WDWeakify(self);
        [cancelView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            [self removeFromSuperview];
            if (self.cancelBlock) {
                self.cancelBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        YYButton *confirmView = [[YYButton alloc] initWithFont:FONT_DESIGN_26 borderWidth:0.5f borderColoer:COLOR_3d5afe.CGColor masksToBounds:YES title:YYStringWithKey(@"确认") titleColor:COLOR_ffffff backgroundColor:COLOR_3d5afe cornerRadius:2.0f];
        [bottomView addSubview:confirmView];
        [confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.textField.mas_right);
            make.top.mas_equalTo(cancelView.mas_top);
            make.size.mas_offset(CGSizeMake(YYSIZE_91, YYSIZE_31));
        }];
        [confirmView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            if (self.textContent.length == 0) {
                [YYToastView showCenterWithTitle:YYStringWithKey(@"请输入交易密码") attachedView:[UIApplication sharedApplication].keyWindow];
                return ;
            }
            [self removeFromSuperview];
            NSString *passwordString = [EVOMd5Generate genMd5:self.textContent];
            if (self.confirmBlock) {
                self.confirmBlock(passwordString);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - textfield

- (void)textField:(UITextField *)textField {
    self.textContent = self.textField.text;
}


@end
