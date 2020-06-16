//
//  OrderOptionalCell.m
//  UBIClientForiOS
//
//  Created by yang on 2020/4/24.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "OrderOptionalCell.h"
#import "YYViewHeader.h"
#import <BlocksKit/BlocksKit.h>
#import "YYInterfaceMacro.h"

@interface OrderOptionalCell ()

@property (nonatomic, strong) YYLabel  *orderView;
@property (nonatomic, strong) YYLabel  *dataView;
@property (nonatomic, strong) YYLabel  *priceView;
@property (nonatomic, strong) YYButton *sellView;

@end

@implementation OrderOptionalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR_1a203a;
        
        self.orderView = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:COLOR_ffffff text:YYStringWithKey(@"M520917")];
        [self addSubview:self.orderView];
        [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_23);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        self.dataView = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:COLOR_ffffff text:YYStringWithKey(@"1250")];
        [self addSubview:self.dataView];
        [self.dataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_112);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        self.priceView = [[YYLabel alloc] initWithFont:FONT_DESIGN_28 textColor:COLOR_ffffff text:YYStringWithKey(@"5")];
        [self addSubview:self.priceView];
        [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_182);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        self.sellView = [[YYButton alloc] initWithFont:FONT_DESIGN_28 borderWidth:0.5 borderColoer:COLOR_486cff.CGColor masksToBounds:YES title:YYStringWithKey(@"卖给TA") titleColor:COLOR_486cff backgroundColor:COLOR_1a203a cornerRadius:4.0f];
        self.sellView.stretchLength = 15.0f;
        [self addSubview:self.sellView];
        [self.sellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-YYSIZE_28);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_offset(CGSizeMake(YYSIZE_60, YYSIZE_30));
        }];
        WDWeakify(self);
        [self.sellView bk_addEventHandler:^(id  _Nonnull sender) {
            WDStrongify(self);
            if (self.sellBlock) {
                self.sellBlock(self.model.OrderID);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setModel:(PurchaseOrderModel *)model {
    _model = model;
    self.orderView.text = model.OrderID;
    self.dataView.text = [NSString stringWithFormat:@"%ld",(long)model.Count];
    self.priceView.text = model.Price;
}

+ (NSString *)identifier {
    return @"OrderOptionalCell";
}

@end
