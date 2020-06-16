//
//  OrderPasswordView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/1/9.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "OrderPasswordView.h"
#import "YYTextView.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"
#import "YYSecureView.h"
#import "EVOMd5Generate.h"
#import "NSString+Ext.h"
#import "YYDateModel.h"
#import "YYToastView.h"

@interface OrderPasswordView ()

@property (nonatomic,   copy) OrderConfirmBlock confirmBlock;
@property (nonatomic,   copy) CancelBlock  cancelBlock;
@property (nonatomic, strong) YYSecureView *textView;
@property (nonatomic,   copy) NSString     *textContent;
@property (nonatomic, strong) YYTextView   *codeView;

@end

@implementation OrderPasswordView

+ (instancetype)showOrderPasswordViewWithModel:(MiningInfosModel *)model
                                  confirmBlock:(OrderConfirmBlock)confirmBlock
                                   cancelBlock:(CancelBlock _Nullable)cancelBlock {
    OrderPasswordView *view = [[OrderPasswordView alloc] initWithMiningInfosModel:model];
    view.confirmBlock = confirmBlock;
    view.cancelBlock = cancelBlock;
    return view;
}

- (instancetype)initWithMiningInfosModel:(MiningInfosModel *)model {
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
        bottomView.backgroundColor = COLOR_1b213b;
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY).offset(-YYSIZE_35);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_280, YYSIZE_410));
        }];
        
        // title View
        YYLabel *titleView = [[YYLabel alloc] initWithFont:FONT_PingFangSC_BLOD_30 textColor:COLOR_ffffff text:YYStringWithKey(@"订单详情")];
        titleView.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_28);
            make.centerX.mas_equalTo(bottomView.mas_centerX);
        }];
        
        // miner name
        YYLabel *minerView = [[YYLabel alloc] initWithFont:FONT_DESIGN_30 textColor:COLOR_ffffff text:model.Name];
        minerView.textAlignment = NSTextAlignmentLeft;
        [bottomView addSubview:minerView];
        [minerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bottomView.mas_left).offset(YYSIZE_30);
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_74);
        }];
        
        // create time
        YYLabel *createTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_7d87a0_A08 text:YYStringWithKey(@"创建时间")];
        createTitleView.textAlignment = NSTextAlignmentLeft;
        [bottomView addSubview:createTitleView];
        [createTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(minerView.mas_left);
            make.top.mas_equalTo(minerView.mas_bottom).offset(YYSIZE_12);
        }];
        
        YYLabel *createView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff text:[YYDateModel yy_currentDay]];
        createView.textAlignment = NSTextAlignmentRight;
        [bottomView addSubview:createView];
        [createView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(bottomView.mas_right).offset(-YYSIZE_30);
            make.top.mas_equalTo(minerView.mas_bottom).offset(YYSIZE_12);
        }];
        
        // cycle
        YYLabel *cycleTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_7d87a0_A08 text:YYStringWithKey(@"周期")];
        cycleTitleView.textAlignment = NSTextAlignmentLeft;
        [bottomView addSubview:cycleTitleView];
        [cycleTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(minerView.mas_left);
            make.top.mas_equalTo(createTitleView.mas_bottom).offset(YYSIZE_12);
        }];
        
        YYLabel *cycleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff text:[NSString stringWithFormat:@"%ld%@",(long)model.Cycle,YYStringWithKey(@"天")]];
        cycleView.textAlignment = NSTextAlignmentRight;
        [bottomView addSubview:cycleView];
        [cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(createView.mas_right);
            make.top.mas_equalTo(cycleTitleView.mas_top);
        }];
        
        // end time
        YYLabel *endTimeTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_7d87a0_A08 text:YYStringWithKey(@"到期时间")];
        endTimeTitleView.textAlignment = NSTextAlignmentLeft;
        [bottomView addSubview:endTimeTitleView];
        [endTimeTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(minerView.mas_left);
            make.top.mas_equalTo(cycleTitleView.mas_bottom).offset(YYSIZE_12);
        }];
        
        YYLabel *endTimeView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ffffff text:[YYDateModel yy_afterCurrentDays:model.Cycle]];
        endTimeView.textAlignment = NSTextAlignmentRight;
        [bottomView addSubview:endTimeView];
        [endTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(createView.mas_right);
            make.top.mas_equalTo(endTimeTitleView.mas_top);
        }];
        
        // output
        YYLabel *outputTitleView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_7d87a0_A08 text:YYStringWithKey(@"预计每日产出")];
        outputTitleView.textAlignment = NSTextAlignmentLeft;
        [bottomView addSubview:outputTitleView];
        [outputTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(minerView.mas_left);
            make.top.mas_equalTo(endTimeTitleView.mas_bottom).offset(YYSIZE_12);
        }];
        
        YYLabel *outputView = [[YYLabel alloc] initWithFont:FONT_DESIGN_24 textColor:COLOR_ff4860 text:[NSString stringWithFormat:@"%@ UBI",[model.Ret yy_holdDecimalPlaceToIndex:4]]];
        outputView.textAlignment = NSTextAlignmentRight;
        [bottomView addSubview:outputView];
        [outputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(createView.mas_right);
            make.top.mas_equalTo(outputTitleView.mas_top);
        }];

        
        // password
        self.textView = [YYSecureView new];
        [bottomView addSubview:self.textView];
        self.textView.inputUnitCount = 12; // 最大 12
        self.textView.unitSpace = 3;
        self.textView.secureTextEntry = YES; // 密文
        self.textView.layer.borderColor = COLOR_272d48.CGColor;
        self.textView.layer.borderWidth = 1;
        self.textView.layer.cornerRadius = 5.0;
        self.textView.textAlignment = NSTextAlignmentCenter;
        [self.textView setFont:FONT_DESIGN_24];
        self.textView.placeholder = YYStringWithKey(@"请输入交易密码");
        self.textView.alignment = NSTextAlignmentCenter;
        self.textView.placeholderColor = COLOR_7d87a0;
        self.textView.textColor = COLOR_7d87a0;
        self.textView.backgroundColor = COLOR_272d48;
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(outputTitleView.mas_bottom).offset(YYSIZE_28);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(YYSIZE_220, YYSIZE_40));
        }];
        [self.textView addObserver: self forKeyPath: @"secureContent" options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context: nil];
        
        YYTextView *codeView = [YYTextView new];
        //        addressView.layer.borderColor = COLOR_7d87a0_A03.CGColor;
        [bottomView addSubview:codeView];
        codeView.layer.borderColor = COLOR_272d48.CGColor;
        codeView.layer.borderWidth = 1;
        codeView.layer.cornerRadius = 5.0;
        codeView.textAlignment = NSTextAlignmentCenter;
        codeView.font = FONT_DESIGN_26;
        codeView.placeholder = YYStringWithKey(@"谷歌验证码");
        codeView.placeholderColor = COLOR_7d87a0;
        codeView.backgroundColor = COLOR_272d48;
        codeView.textContainerInset = UIEdgeInsetsMake(YYSIZE_07_5, 3, YYSIZE_07_5,3);
        [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.textView.mas_bottom).offset(YYSIZE_15);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(YYSIZE_220, YYSIZE_40));
        }];
        self.codeView = codeView;
        
        YYButton *cancelView = [YYButton buttonWithType:UIButtonTypeCustom];
        cancelView.stretchLength = 10.0f;
        [cancelView setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
        [bottomView addSubview:cancelView];
        [cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(bottomView.mas_right).offset(-YYSIZE_15);
            make.top.mas_equalTo(bottomView.mas_top).offset(YYSIZE_15);
        }];
        WDWeakify(self);
        [cancelView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            [self removeFromSuperview];
            if (self.cancelBlock) {
                self.cancelBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        YYButton *confirmView = [[YYButton alloc] initWithFont:FONT_DESIGN_26 borderWidth:0.5f borderColoer:COLOR_476cff.CGColor masksToBounds:YES title:YYStringWithKey(@"确认") titleColor:COLOR_ffffff backgroundColor:COLOR_476cff cornerRadius:20.0f];
        [bottomView addSubview:confirmView];
        [confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.codeView.mas_bottom).offset(YYSIZE_15);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_220, YYSIZE_40));
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
                self.confirmBlock(passwordString,self.codeView.text);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString: @"secureContent"]) {
        self.textContent = self.textView.secureContent;
    }
}

@end
