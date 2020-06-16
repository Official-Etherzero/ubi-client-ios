//
//  YYPercentView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/1/8.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYPercentView.h"
#import "YYViewHeader.h"

@interface YYPercentView ()

@property (nonatomic, strong) YYLabel *contentView;
@property (nonatomic, strong) CAShapeLayer *outLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end

@implementation YYPercentView

- (instancetype)init {
    if (self = [super init]) {
        self.layer.cornerRadius = YYSIZE_30;
        self.clipsToBounds = YES;
        
        self.contentView = [[YYLabel alloc] initWithFont:FONT_BEBAS_36 textColor:COLOR_ffd060 text:@"0%"];
        self.contentView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        CGFloat kLineWidth = YYSIZE_10;
        self.outLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(YYSIZE_30, YYSIZE_30) radius:YYSIZE_30 startAngle:0 endAngle:M_PI *2   clockwise:YES];
        self.outLayer.strokeColor = COLOR_ffd060_A01.CGColor;
        self.outLayer.lineWidth = kLineWidth;
        self.outLayer.fillColor =  [UIColor clearColor].CGColor;
        self.outLayer.lineCap = kCALineCapRound;
        self.outLayer.path = path.CGPath;
        [self.layer addSublayer:self.outLayer];
    }
    return self;
}

- (void)setPercent:(NSString *)percent {
    _percent = percent;
    self.contentView.text = percent;
    
    UIBezierPath *kpath = [UIBezierPath bezierPath];
    [kpath addArcWithCenter:CGPointMake(YYSIZE_30, YYSIZE_30) radius:YYSIZE_30 startAngle:-M_PI_2 endAngle:(M_PI *2 *[percent integerValue] / 100.0f)-M_PI_2 clockwise:YES];
    [kpath fill];
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.strokeColor = COLOR_ffd060.CGColor;
    self.progressLayer.lineWidth = YYSIZE_10;
//    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.path = kpath.CGPath;
    [self.layer addSublayer:self.progressLayer];
}


@end
